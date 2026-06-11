/**
 * @file uart_server.c
 * @brief UART Server implementation
 * 
 * Provides bidirectional UART communication alongside TCP server.
 * Uses same command protocol and message format as TCP server.
 */

#include "uart_server.h"
#include "command_parser.h"
#include "message_formatter.h"
#include "sensor_reader.h"
#include "config.h"
#include "hal_uart.h"
#include <stdio.h>
#include <string.h>

/* State machine */
static uart_state_t uart_state = UART_STATE_IDLE;
static uint8_t uart_rx_buffer[80];
static uint16_t uart_rx_count = 0;
static uint8_t uart_tx_buffer[80];

/* Line ending detection */
#define UART_DELIMITER '\n'

/**
 * Initialize UART Server
 */
void uart_server_init(uint32_t baudrate)
{
    uart_state = UART_STATE_IDLE;
    uart_rx_count = 0;
    
    /* Initialize UART hardware */
    hal_uart_init(baudrate);
    
    uart_state = UART_STATE_READY;
}

/**
 * Process UART Server
 * - Read incoming data
 * - Parse commands
 * - Send responses
 */
void uart_server_process(void)
{
    uint16_t available_len;
    uint8_t read_byte;
    char resp_buf[80];
    sensor_state_t state;

    if (uart_state == UART_STATE_IDLE) {
        return;
    }

    available_len = hal_uart_available();

    if (available_len > 0) {
        uart_state = UART_STATE_RX_PENDING;

        while (available_len > 0 &&
               uart_rx_count < sizeof(uart_rx_buffer) - 1) {

            read_byte = hal_uart_read_byte();

            if (read_byte == '\n' || read_byte == '\r') {

                if (uart_rx_count > 0) {

                    uart_rx_buffer[uart_rx_count] = '\0';

                    if (command_parser_execute((const char *)uart_rx_buffer,
                                               uart_rx_count) == 0) {

                        state = sensor_reader_get_state();

                        message_formatter_alive(resp_buf,
                                                sizeof(resp_buf),
                                                state.di1,
                                                state.di2,
                                                state.di3,
                                                state.di4);

                        uart_server_send((uint8_t *)resp_buf,
                                         strlen(resp_buf));
                    }
                    else {
                        uart_server_send(
                            (uint8_t *)"ERROR,INVALID_COMMAND\n",
                            strlen("ERROR,INVALID_COMMAND\n"));
                    }

                    uart_rx_count = 0;
                }
            }
            else if (read_byte >= 32 && read_byte < 127) {
                uart_rx_buffer[uart_rx_count++] = read_byte;
            }

            available_len--;
        }

        uart_state = UART_STATE_READY;
    }
    else {
        uart_state = UART_STATE_READY;
    }
}
/**
 * Send data to UART
 */
int uart_server_send(const uint8_t *data, uint16_t len)
{
    if (uart_state == UART_STATE_IDLE) {
        return -1;
    }
    
    if (len > sizeof(uart_tx_buffer)) {
        len = sizeof(uart_tx_buffer);
    }
    
    /* Copy to TX buffer and send */
    memcpy(uart_tx_buffer, data, len);
    hal_uart_send(uart_tx_buffer, len);
    
    return 0;
}

/**
 * Check if UART is ready
 */
int uart_server_is_ready(void)
{
    return (uart_state != UART_STATE_IDLE) ? 1 : 0;
}

/**
 * Get current server state
 */
uart_state_t uart_server_get_state(void)
{
    return uart_state;
}
