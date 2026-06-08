#include "stm8s.h"
#include "stm8s_clk.h"
#include "w5500.h"

volatile uint8_t version;

void main(void)
{
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);

    CLK_PeripheralClockConfig(
        CLK_PERIPHERAL_SPI,
        ENABLE);

    W5500_GPIO_Init();

    W5500_SPI_Init();

    W5500_Hardware_Reset();

    W5500_Init();

    version = W5500_ReadReg(VERSIONR);

    while(1)
    {
        /* breakpoint here */
    }
}