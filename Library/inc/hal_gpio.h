/**
 * @file hal_gpio.h
 * @brief GPIO Hardware Abstraction Layer
 */

#ifndef __HAL_GPIO_H
#define __HAL_GPIO_H

#include "stm8s.h"
#include "config.h"

/* GPIO Initialization */
void hal_gpio_init(void);

/* Relay Control Functions */
void hal_relay_set(uint8_t relay_num, uint8_t state);
uint8_t hal_relay_get(uint8_t relay_num);

/* Digital Input Functions */
uint8_t hal_di_read(uint8_t di_num);
uint8_t hal_di_read_all(void);

/* W5500 Reset Control */
void hal_w5500_reset_high(void);
void hal_w5500_reset_low(void);

/* Hardware Reset Input */
uint8_t hal_hardrst_read(void);

#endif /* __HAL_GPIO_H */
