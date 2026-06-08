#ifndef __W5500_H
#define __W5500_H

#include "stm8s.h"

#define W5500_SPI_GPIO_PORT GPIOC

#define W5500_SCK_PIN       GPIO_PIN_5
#define W5500_MOSI_PIN      GPIO_PIN_6
#define W5500_MISO_PIN      GPIO_PIN_7

#define W5500_CS_PORT       GPIOA
#define W5500_CS_PIN        GPIO_PIN_3

#define W5500_RST_PORT      GPIOE
#define W5500_RST_PIN       GPIO_PIN_5

#define W5500_INT_PORT      GPIOF
#define W5500_INT_PIN       GPIO_PIN_4

/* Common Registers */
#define MR          0x0000
#define GAR         0x0001
#define SUBR        0x0005
#define SHAR        0x0009
#define SIPR        0x000F
#define PHYCFGR     0x002E
#define VERSIONR    0x0039

void W5500_GPIO_Init(void);
void W5500_SPI_Init(void);
void W5500_Hardware_Reset(void);

void W5500_Init(void);

uint8_t W5500_ReadReg(uint16_t addr);
void W5500_WriteReg(uint16_t addr,uint8_t data);

void W5500_Select(void);
void W5500_Unselect(void);

uint8_t W5500_SendByte(uint8_t data);

#endif