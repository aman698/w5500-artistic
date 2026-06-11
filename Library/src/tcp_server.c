/**
 * @file tcp_server.c
 * @brief TCP Server implementation using W5500
 */
#include <string.h>
#include "w5500.h"
#include "tcp_server.h"
#include "command_parser.h"
#include "message_formatter.h"
#include "sensor_reader.h"
#include "config.h"
#include "socket.h"
#include "wizchip_conf.h"


/* Static variables */
static tcp_state_t server_state = TCP_STATE_IDLE;
static uint8_t server_socket = 0;
static uint8_t client_socket = 1;
static uint16_t server_port = TCP_SERVER_PORT;
static uint8_t rx_buffer[TCP_RX_BUFFER];
static uint8_t tx_buffer[TCP_TX_BUFFER];

/**
 * Initialize W5500 MAC address and network settings
 */
static void w5500_init_network(void)
{
    wiz_NetInfo netinfo;

    uint8_t mac[6] = MAC_ADDR;
    uint8_t ip[4]  = IP_ADDR;
    uint8_t sn[4]  = SUBNET_MASK;
    uint8_t gw[4]  = GATEWAY_ADDR;

    memcpy(netinfo.mac, mac, 6);
    memcpy(netinfo.ip,  ip, 4);
    memcpy(netinfo.sn,  sn, 4);
    memcpy(netinfo.gw,  gw, 4);

    netinfo.dns[0] = 8;
    netinfo.dns[1] = 8;
    netinfo.dns[2] = 8;
    netinfo.dns[3] = 8;

    netinfo.dhcp = NETINFO_STATIC;

    wizchip_setnetinfo(&netinfo);
}
/**
 * Initialize TCP Server
 */
void tcp_server_init(uint16_t port)
{
    server_port = port;
    server_state = TCP_STATE_IDLE;
    
    /* Initialize W5500 network settings */
    w5500_init_network();
    
    /* Initialize server socket */
    if (socket(server_socket, Sn_MR_TCP, server_port, 0) == server_socket) {
        /* Listen for incoming connections */
        if (listen(server_socket) == SOCK_OK) {
            server_state = TCP_STATE_LISTENING;
        }
    }
}

/**
 * Process TCP Server
 * - Accept new connections
 * - Receive commands
 * - Send responses
 */
void tcp_server_process(void)
{
    uint16_t received_len = 0;
    uint8_t sock_status;
    
    if (server_state == TCP_STATE_IDLE) {
        return;
    }
    
    sock_status = getSn_SR(server_socket);
    
    switch (sock_status) {
        case SOCK_LISTEN:
            server_state = TCP_STATE_LISTENING;
            break;
            
        case SOCK_ESTABLISHED:
            server_state = TCP_STATE_CONNECTED;
            
            /* Check for incoming data */
            received_len = getSn_RX_RSR(server_socket);
            if (received_len > 0) {
                uint16_t read_len = (received_len > TCP_RX_BUFFER) ?
                                   TCP_RX_BUFFER : received_len;
                
                /* Receive data */
                read_len = recv(server_socket, rx_buffer, read_len);
                
                if (read_len > 0) {
                    /* Parse and execute command */
                    if (command_parser_execute((const char *)rx_buffer, read_len) == 0) {
                        /* Send success response (ALIVE message) */
                        char resp_buf[80];
                        sensor_state_t state = sensor_reader_get_state();
                        message_formatter_alive(resp_buf,sizeof(resp_buf),state.di1,state.di2,state.di3,state.di4);
                        tcp_server_send((uint8_t *)resp_buf, strlen(resp_buf));
                    }
                }
            }
            break;
            
        case SOCK_CLOSED:
            server_state = TCP_STATE_LISTENING;
            /* Reopen socket */
            close(server_socket);
            socket(server_socket, Sn_MR_TCP, server_port, 0);
            listen(server_socket);
            break;
            
        default:
            server_state = TCP_STATE_ERROR;
            break;
    }
}

/**
 * Send data to connected client
 */
int tcp_server_send(const uint8_t *data, uint16_t len)
{
    uint16_t sent;

    if (server_state != TCP_STATE_CONNECTED) {
        return -1;
    }

    if (len > TCP_TX_BUFFER) {
        len = TCP_TX_BUFFER;
    }

    /* Copy to TX buffer */
    memcpy(tx_buffer, data, len);

    /* Send via socket */
    sent = send(server_socket, tx_buffer, len);

    return (sent == len) ? 0 : -1;
}

/**
 * Check if client is connected
 */
int tcp_server_is_connected(void)
{
    return (server_state == TCP_STATE_CONNECTED) ? 1 : 0;
}

/**
 * Get server state
 */
tcp_state_t tcp_server_get_state(void)
{
    return server_state;
}

/**
 * Close connection
 */
void tcp_server_close(void)
{
    if (server_state == TCP_STATE_CONNECTED) {
        close(server_socket);
        server_state = TCP_STATE_LISTENING;
    }
}
