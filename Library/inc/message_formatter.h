#ifndef MESSAGE_FORMATTER_H
#define MESSAGE_FORMATTER_H

#include "stm8s.h"
#include "sensor_reader.h"

/* Format ALIVE message */
void message_formatter_alive(char *buf,
                             int buf_size,
                             uint8_t di1,
                             uint8_t di2,
                             uint8_t di3,
                             uint8_t di4);

/* Format AVCC message */
void message_formatter_avcc(char *buf,
                            int buf_size,
                            uint16_t lanid,
                            uint32_t seqn,
                            uint16_t axle_count);

/* Convert byte to hex string */
void message_formatter_byte_to_hex(uint8_t val,
                                   char *str);

#endif