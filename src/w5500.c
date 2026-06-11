#include "w5500.h"
#include "stm8s_gpio.h"
#include "stm8s_spi.h"

void W5500_Select(void)
{
    GPIO_WriteLow(W5500_CS_PORT,W5500_CS_PIN);
}

void W5500_Unselect(void)
{
    GPIO_WriteHigh(W5500_CS_PORT,W5500_CS_PIN);
}

uint8_t W5500_SendByte(uint8_t data)
{
    SPI_SendData(data);

    while(SPI_GetFlagStatus(SPI_FLAG_RXNE)==RESET);

    return SPI_ReceiveData();
}

void W5500_GPIO_Init(void)
{
    GPIO_Init(GPIOC,
              GPIO_PIN_5,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_Init(GPIOC,
              GPIO_PIN_6,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_Init(GPIOC,
              GPIO_PIN_7,
              GPIO_MODE_IN_FL_NO_IT);

    GPIO_Init(GPIOA,
              GPIO_PIN_3,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_Init(GPIOE,
              GPIO_PIN_5,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_WriteHigh(GPIOA,GPIO_PIN_3);
}

void W5500_SPI_Init(void)
{
    SPI_DeInit();

    SPI_Init(
        SPI_FIRSTBIT_MSB,
        SPI_BAUDRATEPRESCALER_8,
        SPI_MODE_MASTER,
        SPI_CLOCKPOLARITY_LOW,
        SPI_CLOCKPHASE_1EDGE,
        SPI_DATADIRECTION_2LINES_FULLDUPLEX,
        SPI_NSS_SOFT,
        0x07);

    SPI_Cmd(ENABLE);
}

void W5500_Hardware_Reset(void)
{
    volatile uint32_t i;

    GPIO_WriteLow(GPIOE,GPIO_PIN_5);

    for(i=0;i<30000;i++);

    GPIO_WriteHigh(GPIOE,GPIO_PIN_5);

    for(i=0;i<60000;i++);
}

void W5500_WriteReg(uint16_t addr,uint8_t data)
{
    W5500_Select();

    W5500_SendByte(addr >> 8);
    W5500_SendByte(addr & 0xFF);

    /* Common Register Write */
    W5500_SendByte(0x04);

    W5500_SendByte(data);

    W5500_Unselect();
}

uint8_t W5500_ReadReg(uint16_t addr)
{
    uint8_t value;

    W5500_Select();

    W5500_SendByte(addr >> 8);
    W5500_SendByte(addr & 0xFF);

    /* Common Register Read */
    W5500_SendByte(0x00);

    value = W5500_SendByte(0xFF);

    W5500_Unselect();

    return value;
}

void W5500_Init(void)
{
    uint8_t i;

    uint8_t mac[6] =
    {
        0x00,0x08,0xDC,
        0x11,0x22,0x33
    };

    uint8_t ip[4] =
    {
        192,168,100,52
    };

    uint8_t sn[4] =
    {
        255,255,255,0
    };

    uint8_t gw[4] =
    {
        192,168,100,1
    };

    W5500_WriteReg(MR,0x80);

    for(i=0;i<4;i++)
        W5500_WriteReg(GAR+i,gw[i]);

    for(i=0;i<4;i++)
        W5500_WriteReg(SUBR+i,sn[i]);

    for(i=0;i<6;i++)
        W5500_WriteReg(SHAR+i,mac[i]);

    for(i=0;i<4;i++)
        W5500_WriteReg(SIPR+i,ip[i]);
}