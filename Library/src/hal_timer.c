/**
 * @file hal_timer.c
 * @brief Timer Hardware Abstraction Layer Implementation
 * Uses Timer4 for 10ms system ticks
 */

#include "hal_timer.h"

static unsigned long systick_ms = 0;
static timer_callback_t user_callback = 0;

/**
 * Timer4 interrupt handler (called from stm8s_it.c)
 */
void tim4_tick(void)
{
    systick_ms += TIMER_TICK_MS;
    if (user_callback) {
        user_callback();
    }
}

/**
 * Initialize Timer4
 * STM8S003K3 clock: 16MHz (default)
 * Timer4 is 8-bit counter
 * 
 * For 10ms tick:
 * Timer4 clock = 16MHz / (prescaler)
 * We want interrupt every 10ms = 10,000 microseconds
 * 
 * Using prescaler of 128 (TIM4_PRESCALER_128):
 * Timer frequency = 16MHz / 128 = 125kHz (8 microseconds per tick)
 * For 10ms = 1250 ticks
 * But Timer4 is 8-bit max (255), so we use AutoReload = 125 with prescaler = 128
 * Actually: 16MHz / 128 / 125 = 1000Hz = 1ms per overflow
 * For 10ms we need 10 overflows
 */
void hal_timer_init(void)
{
    /* Enable Timer4 clock */
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
    
    /* Configure Timer4:
     * - Prescaler: 128 (16MHz / 128 = 125kHz)
     * - Period: 125 (gives 1ms interrupt)
     * - We'll count 10 interrupts for 10ms tick
     */
    TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125);
    
    /* Clear interrupt flag */
    TIM4_ClearFlag(TIM4_FLAG_UPDATE);
    
    /* Enable interrupt */
    TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
    
    /* Enable general interrupts */
    enableInterrupts();
}

/**
 * Start Timer4
 */
void hal_timer_start(void)
{
    TIM4_Cmd(ENABLE);
}

/**
 * Stop Timer4
 */
void hal_timer_stop(void)
{
    TIM4_Cmd(DISABLE);
}

/**
 * Get elapsed milliseconds since startup
 */
unsigned long hal_get_millis(void)
{
    return systick_ms;
}

/**
 * Delay function using system tick
 */
void hal_delay_ms(unsigned int ms)
{
    unsigned long start = hal_get_millis();
    while ((hal_get_millis() - start) < ms);
}

/**
 * Register a callback to be called on each timer tick
 */
void hal_timer_set_callback(timer_callback_t callback)
{
    user_callback = callback;
}
