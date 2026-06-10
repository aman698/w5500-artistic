#include <stdio.h>
#include <string.h>

#include "stm8s_conf.h"

#define TCP_SERVER_SOCKET_NUM   0
#define TCP_SERVER_PORT         5000

// TCP RX line framing
#define TCP_RX_LINE_MAX         64
/*---------------- PIN DEFINITIONS ----------------*/


/* Inputs (DIO CARD: Opto Inputs are active-low asserted=0) */
#define DI1_PORT    GPIOD
#define DI1_PIN     GPIO_PIN_2

#define DI2_PORT    GPIOD
#define DI2_PIN     GPIO_PIN_3

#define DI3_PORT    GPIOD
#define DI3_PIN     GPIO_PIN_4

#define DI4_PORT    GPIOD
#define DI4_PIN     GPIO_PIN_7

/* Relays (DIO CARD) */
#define RELAY1_PORT GPIOB
#define RELAY1_PIN  GPIO_PIN_3

#define RELAY2_PORT GPIOB
#define RELAY2_PIN  GPIO_PIN_2

#define RELAY3_PORT GPIOB
#define RELAY3_PIN  GPIO_PIN_1

#define RELAY4_PORT GPIOB
#define RELAY4_PIN  GPIO_PIN_0

#define RELAY5_PORT GPIOC
#define RELAY5_PIN  GPIO_PIN_3

#define RELAY6_PORT GPIOC
#define RELAY6_PIN  GPIO_PIN_4

#define LAN_ID      125
#define BAUDRATE    9600


/---------------- GLOBAL VARIABLES ----------------/

volatile uint8_t loopAc = 0;
volatile uint8_t prev = 1;
volatile uint16_t hit = 0;

uint32_t EmbeddedSeqN = 0;

char RxBuffer[64];
uint8_t RxIndex = 0;

char TxBuffer[128];

/---------------- DELAY ----------------/

void Delay_ms(uint16_t ms){
    uint16_t i,j;
    for(i=0;i<ms;i++)
    {
        for(j=0;j<160;j++)
        {
            nop();
        }
    }
}

/---------------- UART ----------------/

void UART_SendChar(char c)
{
    while(UART1_GetFlagStatus(UART1_FLAG_TXE)==RESET);

    UART1_SendData8((uint8_t)c);
}

void UART_SendString(char *str)
{
    while(*str)
    {
        UART_SendChar(*str++);
    }

    UART_SendChar('\r');
    UART_SendChar('\n');
}

/---------------- RELAY ----------------/

void Relay_Write(GPIO_TypeDef* port,GPIO_Pin_TypeDef pin,uint8_t state){
    if(state)
        GPIO_WriteHigh(port,pin);
    else
        GPIO_WriteLow(port,pin);
}

void UpdateRelayState(uint8_t relay,
                      uint8_t state)
{
    switch(relay)
    {
        case 1:
            Relay_Write(RELAY1_PORT,RELAY1_PIN,state);
            break;

        case 2:
            Relay_Write(RELAY2_PORT,RELAY2_PIN,state);
            break;

        case 3:
            Relay_Write(RELAY3_PORT,RELAY3_PIN,state);
            break;

        case 4:
            Relay_Write(RELAY4_PORT,RELAY4_PIN,state);
            break;

        case 5:
            Relay_Write(RELAY5_PORT,RELAY5_PIN,state);
            break;

        case 6:
            Relay_Write(RELAY6_PORT,RELAY6_PIN,state);
            break;

        default:
            break;
    }
}

/---------------- UART COMMAND PARSER ----------------/

void ParseCommand(char *str)
{
    uint8_t relay;
    uint8_t state;

    if(sscanf(str,"R%hhu,%hhu",&relay,&state)==2)
    {
        UpdateRelayState(relay,state);
    }
}
void SPI_Config(void)
{
    SPI_DeInit();

    SPI_Init(
        SPI_FIRSTBIT_MSB,
        SPI_BAUDRATEPRESCALER_16,
        SPI_MODE_MASTER,
        SPI_CLOCKPOLARITY_LOW,
        SPI_CLOCKPHASE_1EDGE,
        SPI_DATADIRECTION_2LINES_FULLDUPLEX,
        SPI_NSS_SOFT,
        0x07
    );

    SPI_Cmd(ENABLE);
}
/---------------- UART RECEIVE ----------------/

void UART_Task(void)
{
    while(UART1_GetFlagStatus(UART1_FLAG_RXNE)!=RESET)
    {
        char ch;

        ch = UART1_ReceiveData8();

        if((ch=='\r') || (ch=='\n'))
        {
            RxBuffer[RxIndex] = 0;

            if(RxIndex > 0)
            {
                ParseCommand(RxBuffer);
            }

            RxIndex = 0;
        }
        else
        {
            if(RxIndex < sizeof(RxBuffer)-1)
            {
                RxBuffer[RxIndex++] = ch;
            }
        }
    }
}

/---------------- ALIVE MESSAGE ----------------/

void PrintAlive(void)
{
    sprintf(TxBuffer,
        "START,ALIVE,%d%d%d%d,END",

            !GPIO_ReadInputPin(DI1_PORT,DI1_PIN),
            !GPIO_ReadInputPin(DI2_PORT,DI2_PIN),
            !GPIO_ReadInputPin(DI3_PORT,DI3_PIN),
            !GPIO_ReadInputPin(DI4_PORT,DI4_PIN));

    UART_SendString(TxBuffer);
}

/---------------- AVCC ----------------/

void AVCC_Task(void)
{
    uint8_t di1;
    uint8_t di2;

    /* Active-low inputs */
    di1 = !GPIO_ReadInputPin(DI1_PORT, DI1_PIN);
    di2 = !GPIO_ReadInputPin(DI2_PORT, DI2_PIN);

    /* Vehicle entered loop */
    if((di1 == 1) && (loopAc == 0))
    {
        loopAc = 1;
        hit = 0;
        prev = 0;
    }

    /* Count DI2 rising edge */
    if(loopAc)
    {
        if(di2)
        {
            if(prev == 0)
            {
                hit++;
                prev = 1;
            }
        }
        else
        {
            prev = 0;
        }
    }

    /* Vehicle left loop */
    if((di1 == 0) && (loopAc == 1))
    {
        sprintf(TxBuffer,
                "START,AVCC,%u,%lu,AXLE,%u,END",
                LAN_ID,
                EmbeddedSeqN,
                hit);

        UART_SendString(TxBuffer);

        EmbeddedSeqN++;

        loopAc = 0;
        hit = 0;
        prev = 0;
    }
}

/---------------- CLOCK ----------------/

void CLK_Config(void)
{
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
}

/---------------- GPIO ----------------/

void GPIO_Config(void)
{
    /* Relay Outputs */
    GPIO_Init(GPIOB,
              GPIO_PIN_0 |
              GPIO_PIN_1 |
              GPIO_PIN_2 |
              GPIO_PIN_3,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_Init(GPIOC,
              GPIO_PIN_3 |
              GPIO_PIN_4,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    /* Digital Inputs */
    GPIO_Init(GPIOD,
              GPIO_PIN_2 |
              GPIO_PIN_3 |
              GPIO_PIN_4 |
              GPIO_PIN_7,
              GPIO_MODE_IN_PU_NO_IT);

    /* W5500 CS */
    GPIO_Init(GPIOA,
              GPIO_PIN_3,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    /* W5500 RESET */
    GPIO_Init(GPIOE,
              GPIO_PIN_5,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    /* COM Selector */
    GPIO_Init(GPIOC,
              GPIO_PIN_1,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    /* SPI Pins */
    GPIO_Init(GPIOC,
              GPIO_PIN_5 |
              GPIO_PIN_6,
              GPIO_MODE_OUT_PP_HIGH_FAST);

    GPIO_Init(GPIOC,
              GPIO_PIN_7,
              GPIO_MODE_IN_FL_NO_IT);
}

/---------------- UART CONFIG ----------------/

void UART_Config(void)
{
    UART1_DeInit();

    UART1_Init(
        BAUDRATE,
        UART1_WORDLENGTH_8D,
        UART1_STOPBITS_1,
        UART1_PARITY_NO,
        UART1_SYNCMODE_CLOCK_DISABLE,
        UART1_MODE_TXRX_ENABLE
    );

    UART1_Cmd(ENABLE);
}

/---------------- MAIN ----------------/

static void W5500_NetworkConfig(void)
{
    // Static network configuration (edit as needed)
    // NOTE: socket server uses TCP_SERVER_PORT on socket 0.
    uint8_t mac[6]  = {0x00, 0x08, 0xDC, 0x00, 0x00, (uint8_t)LAN_ID};
    uint8_t ip[4]   = {192, 168, 1, 200};
    uint8_t sn[4]   = {255, 255, 255, 0};
    uint8_t gw[4]   = {192, 168, 1, 1};
    uint8_t dns[4]  = {192, 168, 1, 1};

    wiz_NetInfo netinfo;
    memset(&netinfo, 0, sizeof(netinfo));
    memcpy(netinfo.mac, mac, 6);
    memcpy(netinfo.ip,  ip, 4);
    memcpy(netinfo.sn,  sn, 4);
    memcpy(netinfo.gw,  gw, 4);
    memcpy(netinfo.dns, dns,4);
    netinfo.dhcp = NETINFO_STATIC;

    ctlnetwork(CN_SET_NETINFO, &netinfo);
}

void main(void)
{
    CLK_Config();
    GPIO_Config();
    UART_Config();
    UART_SendString("SETUP");
    UpdateRelayState(1,1);
    UpdateRelayState(2,1);
    UpdateRelayState(3,1);
    UpdateRelayState(4,1);
    UpdateRelayState(5,1);
    UpdateRelayState(6,1);
    SPI_Config();

    /* LAN Mode */
    GPIO_WriteHigh(GPIOC, GPIO_PIN_1);

    /* W5500 Reset */
    GPIO_WriteLow(GPIOE, GPIO_PIN_5);
    Delay_ms(100);
    GPIO_WriteHigh(GPIOE, GPIO_PIN_5);
    Delay_ms(500);

    /* W5500 Init */
    W5500_Init();

    /* Network Config */
    W5500_NetworkConfig();
    enableInterrupts();

    while(1)
    {
        UART_Task();
        PrintAlive();
        AVCC_Task();
        Delay_ms(50);
    }
}