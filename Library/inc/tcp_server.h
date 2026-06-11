/**
 * @file tcp_server.h
 * @brief TCP Server interface for command reception and response
 */

#ifndef __TCP_SERVER_H
#define __TCP_SERVER_H

#include "stm8s.h"

/* TCP Server states */
typedef enum {
    TCP_STATE_IDLE,
    TCP_STATE_LISTENING,
    TCP_STATE_CONNECTED,
    TCP_STATE_ERROR
} tcp_state_t;

/* Initialize TCP server */
void tcp_server_init(uint16_t port);

/* Process TCP server (call from main loop) */
void tcp_server_process(void);

/* Send data to connected client */
int tcp_server_send(const uint8_t *data, uint16_t len);

/* Check if client is connected */
int tcp_server_is_connected(void);

/* Get current server state */
tcp_state_t tcp_server_get_state(void);

/* Close current connection */
void tcp_server_close(void);

#endif /* __TCP_SERVER_H */
