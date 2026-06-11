/**
 * @file hal_spi.c
 * @brief SPI Hardware Abstraction Layer Implementation
 */

#include "hal_spi.h"

void hal_spi_init(void)
{
    /* Enable SPI clock */
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);

    /* SPI Pins */
    GPIO_Init(W5500_SCK_PORT,
              W5500_SCK_PIN,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_Init(W5500_MOSI_PORT,
              W5500_MOSI_PIN,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_Init(W5500_MISO_PORT,
              W5500_MISO_PIN,
              GPIO_MODE_IN_FL_NO_IT);

    /* CS Pin */
    GPIO_Init(W5500_CS_PORT,
              W5500_CS_PIN,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    hal_spi_cs_high();

    /* Reset Pin */
    GPIO_Init(W5500_RST_PORT,
              W5500_RST_PIN,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    /* INT Pin */
    GPIO_Init(W5500_INT_PORT,
              W5500_INT_PIN,
              GPIO_MODE_IN_FL_NO_IT);

    /* SPI Configuration
       SPI Mode 0
       Fmaster/4 = 2 MHz (assuming 8 MHz CPU)
    */
    SPI_DeInit();

    SPI_Init(
        SPI_FIRSTBIT_MSB,
        SPI_BAUDRATEPRESCALER_4,
        SPI_MODE_MASTER,
        SPI_CLOCKPOLARITY_LOW,
        SPI_CLOCKPHASE_1EDGE,
        SPI_DATADIRECTION_2LINES_FULLDUPLEX,
        SPI_NSS_SOFT,
        0x07
    );

    SPI_Cmd(ENABLE);
}

uint8_t hal_spi_byte(uint8_t data)
{
    while (SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET);

    SPI_SendData(data);

    while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);

    return SPI_ReceiveData();
}

void hal_spi_read(uint8_t *buf, uint16_t len)
{
    uint16_t i;

    for (i = 0; i < len; i++)
    {
        buf[i] = hal_spi_byte(0xFF);
    }
}

void hal_spi_write(const uint8_t *buf, uint16_t len)
{
    uint16_t i;

    for (i = 0; i < len; i++)
    {
        hal_spi_byte(buf[i]);
    }
}

void hal_spi_cs_low(void)
{
    GPIO_WriteLow(W5500_CS_PORT, W5500_CS_PIN);
}

void hal_spi_cs_high(void)
{
    GPIO_WriteHigh(W5500_CS_PORT, W5500_CS_PIN);
}

uint8_t hal_spi_read_byte(void)
{
    return hal_spi_byte(0xFF);
}

void hal_spi_write_byte(uint8_t data)
{
    hal_spi_byte(data);
}