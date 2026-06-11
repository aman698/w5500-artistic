/**
 * @file hal_gpio.c
 * @brief GPIO Hardware Abstraction Layer Implementation
 */

#include "hal_gpio.h"

/**
 * Initialize all GPIO pins
 * - Relay outputs: PP, high speed
 * - Digital inputs: floating input
 * - W5500 reset: PP, high speed
 * - Hardware reset: pull-up input
 */
void hal_gpio_init(void)
{
    /* Enable GPIO clocks */
    
    /* ===== Digital Inputs (Sensors) ===== */
    GPIO_Init(DI1_PORT, DI1_PIN, GPIO_MODE_IN_PU_NO_IT);
    GPIO_Init(DI2_PORT, DI2_PIN, GPIO_MODE_IN_PU_NO_IT);
    GPIO_Init(DI3_PORT, DI3_PIN, GPIO_MODE_IN_PU_NO_IT);
    GPIO_Init(DI4_PORT, DI4_PIN, GPIO_MODE_IN_PU_NO_IT);
    
    /* ===== Relay Outputs ===== */
    GPIO_Init(RELAY1_PORT, RELAY1_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY2_PORT, RELAY2_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY3_PORT, RELAY3_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY4_PORT, RELAY4_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY5_PORT, RELAY5_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY6_PORT, RELAY6_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    
    /* Initialize all relays to HIGH (off state for active-low) */
    hal_relay_set(1, 1);
    hal_relay_set(2, 1);
    hal_relay_set(3, 1);
    hal_relay_set(4, 1);
    hal_relay_set(5, 1);
    hal_relay_set(6, 1);
    
    /* ===== Hardware Reset Input ===== */
    GPIO_Init(HARDRST_PORT, HARDRST_PIN, GPIO_MODE_IN_PU_NO_IT);
    
    /* ===== W5500 Reset Pin ===== */
    GPIO_Init(W5500_RST_PORT, W5500_RST_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    hal_w5500_reset_high();
}

/**
 * Set relay state (1 = on, 0 = off)
 * Note: Relays are active-low (HIGH = off, LOW = on)
 */
void hal_relay_set(uint8_t relay_num, uint8_t state)
{
    GPIO_TypeDef *port;
    GPIO_Pin_TypeDef pin;
    BitStatus bit_state = (state == 0) ? SET : RESET;
    
    switch (relay_num) {
        case 1: port = RELAY1_PORT; pin = RELAY1_PIN; break;
        case 2: port = RELAY2_PORT; pin = RELAY2_PIN; break;
        case 3: port = RELAY3_PORT; pin = RELAY3_PIN; break;
        case 4: port = RELAY4_PORT; pin = RELAY4_PIN; break;
        case 5: port = RELAY5_PORT; pin = RELAY5_PIN; break;
        case 6: port = RELAY6_PORT; pin = RELAY6_PIN; break;
        default: return;
    }
    
    if (bit_state == SET) {
        GPIO_WriteHigh(port, pin);  /* Set HIGH = relay off */
    } else {
        GPIO_WriteLow(port, pin); /* Set LOW = relay on */
    }
}

/**
 * Get relay state (1 = on, 0 = off)
 */
uint8_t hal_relay_get(uint8_t relay_num)
{
    GPIO_TypeDef *port;
    GPIO_Pin_TypeDef pin;
    BitStatus bit_state;
    
    switch (relay_num) {
        case 1: port = RELAY1_PORT; pin = RELAY1_PIN; break;
        case 2: port = RELAY2_PORT; pin = RELAY2_PIN; break;
        case 3: port = RELAY3_PORT; pin = RELAY3_PIN; break;
        case 4: port = RELAY4_PORT; pin = RELAY4_PIN; break;
        case 5: port = RELAY5_PORT; pin = RELAY5_PIN; break;
        case 6: port = RELAY6_PORT; pin = RELAY6_PIN; break;
        default: return 0;
    }
    
    bit_state = GPIO_ReadInputPin(port, pin);
    /* Return 1 if LOW (relay on), 0 if HIGH (relay off) */
    return (bit_state == RESET) ? 1 : 0;
}

/**
 * Read single digital input (1 = high, 0 = low)
 */
uint8_t hal_di_read(uint8_t di_num)
{
    GPIO_TypeDef *port;
    GPIO_Pin_TypeDef pin;
    
    switch (di_num) {
        case 1: port = DI1_PORT; pin = DI1_PIN; break;
        case 2: port = DI2_PORT; pin = DI2_PIN; break;
        case 3: port = DI3_PORT; pin = DI3_PIN; break;
        case 4: port = DI4_PORT; pin = DI4_PIN; break;
        default: return 0;
    }
    
    return (GPIO_ReadInputPin(port, pin) == SET) ? 1 : 0;
}

/**
 * Read all digital inputs as nibble (DI4:DI1)
 */
uint8_t hal_di_read_all(void)
{
    uint8_t result = 0;
    result |= (hal_di_read(1) << 0);
    result |= (hal_di_read(2) << 1);
    result |= (hal_di_read(3) << 2);
    result |= (hal_di_read(4) << 3);
    return result;
}

/**
 * Set W5500 reset high
 */
void hal_w5500_reset_high(void)
{
    GPIO_WriteHigh(W5500_RST_PORT, W5500_RST_PIN);
}

/**
 * Set W5500 reset low
 */
void hal_w5500_reset_low(void)
{
    GPIO_WriteLow(W5500_RST_PORT, W5500_RST_PIN);
}

/**
 * Read hardware reset button
 */
uint8_t hal_hardrst_read(void)
{
    return (GPIO_ReadInputPin(HARDRST_PORT, HARDRST_PIN) == SET) ? 1 : 0;
}
