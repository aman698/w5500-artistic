/**
 * @file main.c
 * @brief Main program - STM8S003K3 + W5500 TCP Server
 * 
 * This program combines:
 * - Vehicle detection via DI1 (loop sensor)
 * - Axle counting via DI2 (axle sensor)
 * - Relay control via TCP commands (R1-R6)
 * - Status reporting via TCP ALIVE/AVCC messages
 */

#include "stm8s_conf.h"
#include <stdio.h>
#include <string.h>

/* ============================================================================
 * Axle Counting State Machine
 * ========================================================================= */

typedef struct {
    uint8_t loop_active;        /* Vehicle on loop */
    uint8_t prev_di2_state;     /* Previous axle sensor state */
    uint16_t axle_count;        /* Number of axles counted */
    uint8_t prev_di1_state;     /* Previous loop detection state */
    uint32_t embedded_seq_num;  /* Sequence number for AVCC messages */
} axle_counter_t;

static axle_counter_t axle_counter = {
    0,
    0,
    0,
    0,
    0
};

/* ============================================================================
 * Periodic Task State
 * ========================================================================= */

typedef struct {
    unsigned long last_alive_time;
    unsigned long last_sensor_time;
    unsigned long current_time;
} task_timer_t;

static task_timer_t task_timer = {0, 0, 0};

/* ============================================================================
 * Debug Print Function
 * ========================================================================= */

static void debug_print(const char *msg)
{
#if ENABLE_DEBUG
    if (uart_server_is_ready()) {
        uart_server_send((uint8_t *)msg, strlen(msg));
    }
#endif
}

/* ============================================================================
 * W5500 Initialization
 * ========================================================================= */

/**
 * Initialize W5500 chip and network
 */
void w5500_chip_init(void)
{
    uint8_t version;

    /* Reset W5500 */
    hal_w5500_reset_low();
    hal_delay_ms(10);
    hal_w5500_reset_high();
    hal_delay_ms(100);

    /* Initialize SPI interface */
    hal_spi_init();

    /* Register SPI callbacks with W5500 driver */
    reg_wizchip_spi_cbfunc(
        hal_spi_read_byte,
        hal_spi_write_byte
    );

    reg_wizchip_spiburst_cbfunc(
        hal_spi_read,
        hal_spi_write
    );

    reg_wizchip_cs_cbfunc(
        hal_spi_cs_low,
        hal_spi_cs_high
    );

    /* Initialize W5500 chip */
    wizchip_init(0, 0);

    /* Check W5500 version */
    version = getVERSIONR();

    if(version != 0x04)
    {
        while(1);
    }
}

/* ============================================================================
 * Axle Counting Logic (ported from Arduino avcc() function)
 * ========================================================================= */

/**
 * Process axle counting state machine
 */
void process_axle_counting(void)
{
    sensor_state_t sensor = sensor_reader_get_state();
    
    /* Vehicle entered loop detection */
    if (sensor.di1 == 1 && axle_counter.prev_di1_state == 0) {
        axle_counter.loop_active = 1;
        axle_counter.axle_count = 0;
    }
    
    /* Count axle pulses while vehicle is on loop */
    if (axle_counter.loop_active) {
        if (sensor.di2 == 1 && axle_counter.prev_di2_state == 0) {
            axle_counter.axle_count++;
        }
        axle_counter.prev_di2_state = sensor.di2;
    }
    
    /* Vehicle left loop */
    if (sensor.di1 == 0 && axle_counter.prev_di1_state == 1 && axle_counter.loop_active) {
        /* Calculate actual axle count (di2 transitions / 2) */
        uint16_t axle_final_count = axle_counter.axle_count / 2;
        
        /* Format and send AVCC message */
        char msg_buf[256];
        message_formatter_avcc(msg_buf, sizeof(msg_buf),
                              DEVICE_LANID,
                              axle_counter.embedded_seq_num,
                              axle_final_count);
        
        /* Send via TCP if connected */
        if (tcp_server_is_connected()) {
            tcp_server_send((uint8_t *)msg_buf, strlen(msg_buf));
        }
        
        /* Send via UART if ready */
        if (uart_server_is_ready()) {
            uart_server_send((uint8_t *)msg_buf, strlen(msg_buf));
        }
        
        /* Reset counter */
        axle_counter.embedded_seq_num++;
        axle_counter.loop_active = 0;
        axle_counter.axle_count = 0;
    }
    
    /* Update previous states */
    axle_counter.prev_di1_state = sensor.di1;
}

/* ============================================================================
 * Periodic Tasks
 * ========================================================================= */

/**
 * Send ALIVE message with current sensor states
 */
void send_alive_message(void)
{
    char msg_buf[256];
    sensor_state_t sensor;

    sensor = sensor_reader_get_state();

    message_formatter_alive(
        msg_buf,
        sizeof(msg_buf),
        sensor.di1,
        sensor.di2,
        sensor.di3,
        sensor.di4
    );

    if (tcp_server_is_connected())
    {
        tcp_server_send((uint8_t *)msg_buf, strlen(msg_buf));
    }

    if (uart_server_is_ready())
    {
        uart_server_send((uint8_t *)msg_buf, strlen(msg_buf));
    }
}
/**
 * Timer callback for periodic tasks
 */
void timer_callback(void)
{
    task_timer.current_time = hal_get_millis();
    
    /* Update sensor readings every 50ms */
    if ((task_timer.current_time - task_timer.last_sensor_time) >= SENSOR_READ_INTERVAL) {
        sensor_reader_update();
        process_axle_counting();
        task_timer.last_sensor_time = task_timer.current_time;
    }
    
    /* Send ALIVE message every 500ms */
    if ((task_timer.current_time - task_timer.last_alive_time) >= ALIVE_INTERVAL) {
        send_alive_message();
        task_timer.last_alive_time = task_timer.current_time;
    }
}

/* ============================================================================
 * Main Program
 * ========================================================================= */

/**
 * System initialization
 */
void system_init(void)
{
    /* Configure system clock */
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  /* 16MHz clock */
    
    /* Initialize HAL layers */
    hal_gpio_init();
    hal_timer_init();
    
    /* Initialize application modules */
    relay_control_init();
    sensor_reader_init();
    
    /* Initialize W5500 and TCP server */
    w5500_chip_init();
    tcp_server_init(TCP_SERVER_PORT);
    
    /* Initialize UART server for dual-channel communication */
    uart_server_init(UART_BAUDRATE);
    
    debug_print("System initialized: W5500 TCP + UART dual-channel\n");
    
    /* Setup timer callback for periodic tasks */
    hal_timer_set_callback(timer_callback);
    hal_timer_start();
    
    /* Delay for network initialization */
    hal_delay_ms(500);
}

/**
 * Main loop
 */
void main_loop(void)
{
    while (1) {
        /* Process TCP server communications */
        tcp_server_process();
        
        /* Process UART server communications */
        uart_server_process();
        
        /* Process any pending hardware reset */
        if (hal_hardrst_read() == 0) {
            /* Hardware reset pressed - perform reset */
            hal_delay_ms(50);
            if (hal_hardrst_read() == 0) {
                /* Send reset message */
                char msg[] = "RESET,OK\n";
                if (tcp_server_is_connected()) {
                    tcp_server_send((uint8_t *)msg, strlen(msg));
                }
                if (uart_server_is_ready()) {
                    uart_server_send((uint8_t *)msg, strlen(msg));
                }
                hal_delay_ms(100);
            }
        }
    }
}

/**
 * Program entry point
 */
int main(void)
{
    system_init();
    main_loop();
    return 0;
}

/**
 * Assert function (required by STM8S library)
 */
#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t *file, uint32_t line)
{
    /* Infinite loop on assertion failure */
    while (1);
}
#endif
