/**
 * @file relay_control.c
 * @brief Relay control implementation
 */

#include "relay_control.h"
#include "hal_gpio.h"

/**
 * Initialize relay control - all relays start OFF
 */
void relay_control_init(void)
{
    relay_control_set_all(1);  /* 1 = on for active-low relays */
}

/**
 * Set individual relay state (1 = on, 0 = off)
 */
void relay_control_set(uint8_t relay_num, uint8_t state)
{
    if (relay_num >= 1 && relay_num <= 6) {
        hal_relay_set(relay_num, state);
    }
}

/**
 * Get individual relay state
 */
uint8_t relay_control_get(uint8_t relay_num)
{
    if (relay_num >= 1 && relay_num <= 6) {
        return hal_relay_get(relay_num);
    }
    return 0;
}

/**
 * Get all relay states
 */
relay_state_t relay_control_get_all(void)
{
    relay_state_t state;
    state.relay1 = relay_control_get(1);
    state.relay2 = relay_control_get(2);
    state.relay3 = relay_control_get(3);
    state.relay4 = relay_control_get(4);
    state.relay5 = relay_control_get(5);
    state.relay6 = relay_control_get(6);
    return state;
}

/**
 * Set all relays to same state
 */
void relay_control_set_all(uint8_t state)
{
    relay_control_set(1, state);
    relay_control_set(2, state);
    relay_control_set(3, state);
    relay_control_set(4, state);
    relay_control_set(5, state);
    relay_control_set(6, state);
}
