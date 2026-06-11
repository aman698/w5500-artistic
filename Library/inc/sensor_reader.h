/**
 * @file sensor_reader.h
 * @brief Digital sensor input reader
 */

#ifndef __SENSOR_READER_H
#define __SENSOR_READER_H

#include "stm8s.h"

typedef struct sensor_state_s
{
    uint8_t di1;
    uint8_t di2;
    uint8_t di3;
    uint8_t di4;
} sensor_state_t;

/* Initialize sensor reader */
void sensor_reader_init(void);

/* Read all sensors */
void sensor_reader_update(void);

/* Get sensor state */
sensor_state_t sensor_reader_get_state(void);

/* Get individual sensor */
uint8_t sensor_reader_get_di(uint8_t di_num);

#endif /* __SENSOR_READER_H */
