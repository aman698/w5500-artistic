/**
 * @file message_formatter.c
 * @brief Message formatter implementation
 */

#include "message_formatter.h"
#include <stdio.h>
#include <string.h>

/**
 * Format ALIVE message
 * Format: START,ALIVE,DI1DI2DI3DI4,END
 */
void message_formatter_alive(char *buf,
                             int buf_size,
                             uint8_t di1,
                             uint8_t di2,
                             uint8_t di3,
                             uint8_t di4)
{
    if (buf == 0)
        return;

    if (buf_size < 32)
        return;

    sprintf(buf,
            "START,ALIVE,%d%d%d%d,END",
            di1,
            di2,
            di3,
            di4);
}

/**
 * Format AVCC message
 * Format: START,AVCC,LANID,SEQN,AXLE,AXLE_COUNT,END
 */
void message_formatter_avcc(char *buf,
                            int buf_size,
                            uint16_t lanid,
                            uint32_t seqn,
                            uint16_t axle_count)
{
    if (buf == 0)
        return;

    if (buf_size < 64)
        return;

    sprintf(buf,
            "START,AVCC,%u,%lu,AXLE,%u,END",
            (unsigned int)lanid,
            (unsigned long)seqn,
            (unsigned int)axle_count);
}

/**
 * Convert single byte to hex string
 */
void message_formatter_byte_to_hex(uint8_t val,
                                   char *str)
{
    static const char hex_chars[] = "0123456789ABCDEF";

    str[0] = hex_chars[(val >> 4) & 0x0F];
    str[1] = hex_chars[val & 0x0F];
    str[2] = '\0';
}