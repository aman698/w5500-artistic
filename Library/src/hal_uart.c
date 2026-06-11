/**
 * @file hal_uart.c
 * @brief UART Hardware Abstraction Layer implementation for STM8S003K3
 * 
 * UART1 Configuration:
 * - TX: Port D, Pin 5
 * - RX: Port D, Pin 6
 * - Baudrate: 115200 (configurable)
 * - Parity: None
 * - Data bits: 8
 * - Stop bits: 1
 */

#include "hal_uart.h"
#include "stm8s_uart1.h"
#include <string.h>

/* Circular RX buffer */
static volatile uint8_t uart_rx_buffer[UART_RX_BUFFER_SIZE];
static volatile uint16_t uart_rx_head = 0;
static volatile uint16_t uart_rx_tail = 0;
static volatile uint16_t uart_rx_count = 0;

/* TX buffer */
static uint8_t uart_tx_buffer[UART_TX_BUFFER_SIZE];

/**
 * Initialize UART1 with specified baudrate
 * Note: For STM8S003K3, using 16MHz clock
 */
void hal_uart_init(uint32_t baudrate)
{
    /* Enable UART1 clock */
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
    
    /* UART1 configuration:
     * - Baudrate: 115200
     * - Word length: 8 bits
     * - Stop bits: 1
     * - Parity: None
     * - Mode: RX and TX enabled
     */
    UART1_Init(
    baudrate,
    UART1_WORDLENGTH_8D,
    UART1_STOPBITS_1,
    UART1_PARITY_NO,
    UART1_SYNCMODE_CLOCK_DISABLE,
    (UART1_Mode_TypeDef)(UART1_MODE_TX_ENABLE | UART1_MODE_RX_ENABLE)
);
    
    /* Enable UART1 Receive Interrupt */
    UART1_ITConfig(UART1_IT_RXNE, ENABLE);
    
    /* Enable UART1 */
    UART1_Cmd(ENABLE);
    
    /* Clear buffers */
    uart_rx_head = 0;
    uart_rx_tail = 0;
    uart_rx_count = 0;
}

/**
 * Send a single byte via UART
 */
void hal_uart_send_byte(uint8_t byte)
{
    /* Wait for transmit buffer to be empty */
    while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
    
    /* Send byte */
    UART1_SendData8(byte);
    
    /* Wait for transmission to complete */
    while (UART1_GetFlagStatus(UART1_FLAG_TC) == RESET);
}

/**
 * Send data buffer via UART
 */
void hal_uart_send(const uint8_t *data, uint16_t len)
{
    uint16_t i;
    for (i = 0; i < len; i++) {
        hal_uart_send_byte(data[i]);
    }
}

/**
 * Check if data is available in RX buffer
 */
uint16_t hal_uart_available(void)
{
    return uart_rx_count;
}

/**
 * Read a single byte from RX buffer
 */
uint8_t hal_uart_read_byte(void)
{
    uint8_t byte = 0;
    
    if (uart_rx_count > 0) {
        /* Disable interrupts to protect buffer access */
        disableInterrupts();
        
        byte = uart_rx_buffer[uart_rx_tail];
        uart_rx_tail = (uart_rx_tail + 1) % UART_RX_BUFFER_SIZE;
        uart_rx_count--;
        
        enableInterrupts();
    }
    
    return byte;
}

/**
 * Read data from RX buffer
 */
uint16_t hal_uart_read(uint8_t *data, uint16_t len)
{
    uint16_t i = 0;
    
    while (i < len && uart_rx_count > 0) {
        data[i] = hal_uart_read_byte();
        i++;
    }
    
    return i;
}

/**
 * Clear RX buffer
 */
void hal_uart_clear_rx_buffer(void)
{
    disableInterrupts();
    uart_rx_head = 0;
    uart_rx_tail = 0;
    uart_rx_count = 0;
    enableInterrupts();
}

/**
 * UART1 RX Interrupt Handler
 * Called from stm8s_it.c UART1_RX_IRQHandler
 */
void uart_rx_handler(void)
{
    uint8_t byte;
    
    /* Check if RXNE flag is set */
    if (UART1_GetFlagStatus(UART1_FLAG_RXNE) != RESET) {
        byte = UART1_ReceiveData8();
        
        /* Add to circular buffer if space available */
        if (uart_rx_count < UART_RX_BUFFER_SIZE) {
            uart_rx_buffer[uart_rx_head] = byte;
            uart_rx_head = (uart_rx_head + 1) % UART_RX_BUFFER_SIZE;
            uart_rx_count++;
        }
    }
}
