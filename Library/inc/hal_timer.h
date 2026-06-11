/**
 * @file hal_timer.h
 * @brief Timer Hardware Abstraction Layer
 */

#ifndef __HAL_TIMER_H
#define __HAL_TIMER_H

#include "stm8s.h"
#include "config.h"

typedef void (*timer_callback_t)(void);

/* Initialize Timer4 for system ticks */
void hal_timer_init(void);

/* Start/stop timer */
void hal_timer_start(void);
void hal_timer_stop(void);

/* Get elapsed milliseconds */
unsigned long hal_get_millis(void);

/* Simple delay function */
void hal_delay_ms(unsigned int ms);

/* Register timer callback */
void hal_timer_set_callback(timer_callback_t callback);

#endif /* __HAL_TIMER_H */
