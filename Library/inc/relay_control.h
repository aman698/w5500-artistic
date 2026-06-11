/**
 * @file relay_control.h
 * @brief Relay control interface
 */

#ifndef __RELAY_CONTROL_H
#define __RELAY_CONTROL_H

#include "stm8s.h"

/* Relay states */
typedef struct {
    uint8_t relay1;
    uint8_t relay2;
    uint8_t relay3;
    uint8_t relay4;
    uint8_t relay5;
    uint8_t relay6;
} relay_state_t;

/* Initialize relay control */
void relay_control_init(void);

/* Set relay state (1 = on, 0 = off) */
void relay_control_set(uint8_t relay_num, uint8_t state);

/* Get relay state */
uint8_t relay_control_get(uint8_t relay_num);

/* Get all relay states */
relay_state_t relay_control_get_all(void);

/* Set all relays to specific state */
void relay_control_set_all(uint8_t state);

#endif /* __RELAY_CONTROL_H */
