/**
 * @file hal_uart.h
 * @brief UART Hardware Abstraction Layer for STM8S003K3
 * @version 1.0
 * @date June 2026
 */

#ifndef __HAL_UART_H
#define __HAL_UART_H

#include "stm8s.h"

/* UART configuration */
#define UART_RX_BUFFER_SIZE 80
#define UART_TX_BUFFER_SIZE 80

/* Initialize UART (115200 baud, 8N1) */
void hal_uart_init(uint32_t baudrate);

/* Send a single byte */
void hal_uart_send_byte(uint8_t byte);

/* Send data buffer */
void hal_uart_send(const uint8_t *data, uint16_t len);

/* Check if data available in RX buffer */
uint16_t hal_uart_available(void);

/* Read a byte from RX buffer */
uint8_t hal_uart_read_byte(void);

/* Read data from RX buffer */
uint16_t hal_uart_read(uint8_t *data, uint16_t len);

/* Clear RX buffer */
void hal_uart_clear_rx_buffer(void);

/* UART interrupt handler (called from ISR) */
void uart_rx_handler(void);

#endif /* __HAL_UART_H */
