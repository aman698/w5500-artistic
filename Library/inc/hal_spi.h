/**
 * @file hal_spi.h
 * @brief SPI Hardware Abstraction Layer for W5500
 */

#ifndef __HAL_SPI_H
#define __HAL_SPI_H

#include "stm8s.h"
#include "config.h"

/* Initialize SPI for W5500 communication */
void hal_spi_init(void);

/* SPI Read/Write single byte */
uint8_t hal_spi_byte(uint8_t data);

/* Bulk read/write */
void hal_spi_read(uint8_t *buf, uint16_t len);
void hal_spi_write(const uint8_t *buf, uint16_t len);

/* CS control */
void hal_spi_cs_low(void);
void hal_spi_cs_high(void);

uint8_t hal_spi_read_byte(void);
void hal_spi_write_byte(uint8_t data);

#endif /* __HAL_SPI_H */
