/**
 * @file sensor_reader.c
 * @brief Sensor input reader implementation
 */

#include "sensor_reader.h"
#include "hal_gpio.h"

static sensor_state_t current_state = {0, 0, 0, 0};

/**
 * Initialize sensor reader
 */
void sensor_reader_init(void)
{
    /* GPIO is already initialized by hal_gpio_init() */
    sensor_reader_update();
}

/**
 * Read all digital inputs
 */
void sensor_reader_update(void)
{
    current_state.di1 = hal_di_read(1);
    current_state.di2 = hal_di_read(2);
    current_state.di3 = hal_di_read(3);
    current_state.di4 = hal_di_read(4);
}

/**
 * Get current sensor state
 */
sensor_state_t sensor_reader_get_state(void)
{
    return current_state;
}

/**
 * Get individual sensor value
 */
uint8_t sensor_reader_get_di(uint8_t di_num)
{
    switch (di_num) {
        case 1: return current_state.di1;
        case 2: return current_state.di2;
        case 3: return current_state.di3;
        case 4: return current_state.di4;
        default: return 0;
    }
}
