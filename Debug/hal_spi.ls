   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  48                     ; 8 void hal_spi_init(void)
  48                     ; 9 {
  50                     	switch	.text
  51  0000               _hal_spi_init:
  55                     ; 11     CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  57  0000 ae0101        	ldw	x,#257
  58  0003 cd0000        	call	_CLK_PeripheralClockConfig
  60                     ; 14     GPIO_Init(W5500_SCK_PORT,
  60                     ; 15               W5500_SCK_PIN,
  60                     ; 16               GPIO_MODE_OUT_PP_HIGH_FAST);
  62  0006 4bf0          	push	#240
  63  0008 4b20          	push	#32
  64  000a ae500a        	ldw	x,#20490
  65  000d cd0000        	call	_GPIO_Init
  67  0010 85            	popw	x
  68                     ; 18     GPIO_Init(W5500_MOSI_PORT,
  68                     ; 19               W5500_MOSI_PIN,
  68                     ; 20               GPIO_MODE_OUT_PP_HIGH_FAST);
  70  0011 4bf0          	push	#240
  71  0013 4b40          	push	#64
  72  0015 ae500a        	ldw	x,#20490
  73  0018 cd0000        	call	_GPIO_Init
  75  001b 85            	popw	x
  76                     ; 22     GPIO_Init(W5500_MISO_PORT,
  76                     ; 23               W5500_MISO_PIN,
  76                     ; 24               GPIO_MODE_IN_FL_NO_IT);
  78  001c 4b00          	push	#0
  79  001e 4b80          	push	#128
  80  0020 ae500a        	ldw	x,#20490
  81  0023 cd0000        	call	_GPIO_Init
  83  0026 85            	popw	x
  84                     ; 27     GPIO_Init(W5500_CS_PORT,
  84                     ; 28               W5500_CS_PIN,
  84                     ; 29               GPIO_MODE_OUT_PP_HIGH_FAST);
  86  0027 4bf0          	push	#240
  87  0029 4b08          	push	#8
  88  002b ae5000        	ldw	x,#20480
  89  002e cd0000        	call	_GPIO_Init
  91  0031 85            	popw	x
  92                     ; 31     hal_spi_cs_high();
  94  0032 cd00ce        	call	_hal_spi_cs_high
  96                     ; 34     GPIO_Init(W5500_RST_PORT,
  96                     ; 35               W5500_RST_PIN,
  96                     ; 36               GPIO_MODE_OUT_PP_HIGH_FAST);
  98  0035 4bf0          	push	#240
  99  0037 4b20          	push	#32
 100  0039 ae5014        	ldw	x,#20500
 101  003c cd0000        	call	_GPIO_Init
 103  003f 85            	popw	x
 104                     ; 39     GPIO_Init(W5500_INT_PORT,
 104                     ; 40               W5500_INT_PIN,
 104                     ; 41               GPIO_MODE_IN_FL_NO_IT);
 106  0040 4b00          	push	#0
 107  0042 4b10          	push	#16
 108  0044 ae5019        	ldw	x,#20505
 109  0047 cd0000        	call	_GPIO_Init
 111  004a 85            	popw	x
 112                     ; 47     SPI_DeInit();
 114  004b cd0000        	call	_SPI_DeInit
 116                     ; 49     SPI_Init(
 116                     ; 50         SPI_FIRSTBIT_MSB,
 116                     ; 51         SPI_BAUDRATEPRESCALER_4,
 116                     ; 52         SPI_MODE_MASTER,
 116                     ; 53         SPI_CLOCKPOLARITY_LOW,
 116                     ; 54         SPI_CLOCKPHASE_1EDGE,
 116                     ; 55         SPI_DATADIRECTION_2LINES_FULLDUPLEX,
 116                     ; 56         SPI_NSS_SOFT,
 116                     ; 57         0x07
 116                     ; 58     );
 118  004e 4b07          	push	#7
 119  0050 4b02          	push	#2
 120  0052 4b00          	push	#0
 121  0054 4b00          	push	#0
 122  0056 4b00          	push	#0
 123  0058 4b04          	push	#4
 124  005a ae0008        	ldw	x,#8
 125  005d cd0000        	call	_SPI_Init
 127  0060 5b06          	addw	sp,#6
 128                     ; 60     SPI_Cmd(ENABLE);
 130  0062 a601          	ld	a,#1
 131  0064 cd0000        	call	_SPI_Cmd
 133                     ; 61 }
 136  0067 81            	ret
 173                     ; 63 uint8_t hal_spi_byte(uint8_t data)
 173                     ; 64 {
 174                     	switch	.text
 175  0068               _hal_spi_byte:
 177  0068 88            	push	a
 178       00000000      OFST:	set	0
 181  0069               L14:
 182                     ; 65     while (SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET);
 184  0069 a602          	ld	a,#2
 185  006b cd0000        	call	_SPI_GetFlagStatus
 187  006e 4d            	tnz	a
 188  006f 27f8          	jreq	L14
 189                     ; 67     SPI_SendData(data);
 191  0071 7b01          	ld	a,(OFST+1,sp)
 192  0073 cd0000        	call	_SPI_SendData
 195  0076               L74:
 196                     ; 69     while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET);
 198  0076 a601          	ld	a,#1
 199  0078 cd0000        	call	_SPI_GetFlagStatus
 201  007b 4d            	tnz	a
 202  007c 27f8          	jreq	L74
 203                     ; 71     return SPI_ReceiveData();
 205  007e cd0000        	call	_SPI_ReceiveData
 209  0081 5b01          	addw	sp,#1
 210  0083 81            	ret
 264                     ; 74 void hal_spi_read(uint8_t *buf, uint16_t len)
 264                     ; 75 {
 265                     	switch	.text
 266  0084               _hal_spi_read:
 268  0084 89            	pushw	x
 269  0085 89            	pushw	x
 270       00000002      OFST:	set	2
 273                     ; 78     for (i = 0; i < len; i++)
 275  0086 5f            	clrw	x
 276  0087 1f01          	ldw	(OFST-1,sp),x
 279  0089 2011          	jra	L501
 280  008b               L101:
 281                     ; 80         buf[i] = hal_spi_byte(0xFF);
 283  008b a6ff          	ld	a,#255
 284  008d add9          	call	_hal_spi_byte
 286  008f 1e03          	ldw	x,(OFST+1,sp)
 287  0091 72fb01        	addw	x,(OFST-1,sp)
 288  0094 f7            	ld	(x),a
 289                     ; 78     for (i = 0; i < len; i++)
 291  0095 1e01          	ldw	x,(OFST-1,sp)
 292  0097 1c0001        	addw	x,#1
 293  009a 1f01          	ldw	(OFST-1,sp),x
 295  009c               L501:
 298  009c 1e01          	ldw	x,(OFST-1,sp)
 299  009e 1307          	cpw	x,(OFST+5,sp)
 300  00a0 25e9          	jrult	L101
 301                     ; 82 }
 304  00a2 5b04          	addw	sp,#4
 305  00a4 81            	ret
 359                     ; 84 void hal_spi_write(const uint8_t *buf, uint16_t len)
 359                     ; 85 {
 360                     	switch	.text
 361  00a5               _hal_spi_write:
 363  00a5 89            	pushw	x
 364  00a6 89            	pushw	x
 365       00000002      OFST:	set	2
 368                     ; 88     for (i = 0; i < len; i++)
 370  00a7 5f            	clrw	x
 371  00a8 1f01          	ldw	(OFST-1,sp),x
 374  00aa 200f          	jra	L341
 375  00ac               L731:
 376                     ; 90         hal_spi_byte(buf[i]);
 378  00ac 1e03          	ldw	x,(OFST+1,sp)
 379  00ae 72fb01        	addw	x,(OFST-1,sp)
 380  00b1 f6            	ld	a,(x)
 381  00b2 adb4          	call	_hal_spi_byte
 383                     ; 88     for (i = 0; i < len; i++)
 385  00b4 1e01          	ldw	x,(OFST-1,sp)
 386  00b6 1c0001        	addw	x,#1
 387  00b9 1f01          	ldw	(OFST-1,sp),x
 389  00bb               L341:
 392  00bb 1e01          	ldw	x,(OFST-1,sp)
 393  00bd 1307          	cpw	x,(OFST+5,sp)
 394  00bf 25eb          	jrult	L731
 395                     ; 92 }
 398  00c1 5b04          	addw	sp,#4
 399  00c3 81            	ret
 423                     ; 94 void hal_spi_cs_low(void)
 423                     ; 95 {
 424                     	switch	.text
 425  00c4               _hal_spi_cs_low:
 429                     ; 96     GPIO_WriteLow(W5500_CS_PORT, W5500_CS_PIN);
 431  00c4 4b08          	push	#8
 432  00c6 ae5000        	ldw	x,#20480
 433  00c9 cd0000        	call	_GPIO_WriteLow
 435  00cc 84            	pop	a
 436                     ; 97 }
 439  00cd 81            	ret
 463                     ; 99 void hal_spi_cs_high(void)
 463                     ; 100 {
 464                     	switch	.text
 465  00ce               _hal_spi_cs_high:
 469                     ; 101     GPIO_WriteHigh(W5500_CS_PORT, W5500_CS_PIN);
 471  00ce 4b08          	push	#8
 472  00d0 ae5000        	ldw	x,#20480
 473  00d3 cd0000        	call	_GPIO_WriteHigh
 475  00d6 84            	pop	a
 476                     ; 102 }
 479  00d7 81            	ret
 492                     	xdef	_hal_spi_cs_high
 493                     	xdef	_hal_spi_cs_low
 494                     	xdef	_hal_spi_write
 495                     	xdef	_hal_spi_read
 496                     	xdef	_hal_spi_byte
 497                     	xdef	_hal_spi_init
 498                     	xref	_SPI_GetFlagStatus
 499                     	xref	_SPI_ReceiveData
 500                     	xref	_SPI_SendData
 501                     	xref	_SPI_Cmd
 502                     	xref	_SPI_Init
 503                     	xref	_SPI_DeInit
 504                     	xref	_GPIO_WriteLow
 505                     	xref	_GPIO_WriteHigh
 506                     	xref	_GPIO_Init
 507                     	xref	_CLK_PeripheralClockConfig
 526                     	end
