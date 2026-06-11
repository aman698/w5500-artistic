/**
 * @file uart_server.h
 * @brief UART Server interface for command reception and response
 * 
 * Provides dual-channel communication:
 * - Same command protocol as TCP server
 * - Runs in parallel with W5500 TCP connection
 * - Both UART and TCP can send commands simultaneously
 */

#ifndef __UART_SERVER_H
#define __UART_SERVER_H

#include "stm8s.h"

/* UART Server states */
typedef enum {
    UART_STATE_IDLE,
    UART_STATE_READY,
    UART_STATE_RX_PENDING,
    UART_STATE_TX_PENDING,
    UART_STATE_ERROR
} uart_state_t;

/* Initialize UART server */
void uart_server_init(uint32_t baudrate);

/* Process UART server (call from main loop) */
void uart_server_process(void);

/* Send data to UART */
int uart_server_send(const uint8_t *data, uint16_t len);

/* Check if UART is ready */
int uart_server_is_ready(void);

/* Get current server state */
uart_state_t uart_server_get_state(void);

#endif /* __UART_SERVER_H */
