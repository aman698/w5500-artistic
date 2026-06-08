   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  50                     ; 7 void main(void)
  50                     ; 8 {
  52                     	switch	.text
  53  0000               _main:
  57                     ; 9     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  59  0000 4f            	clr	a
  60  0001 cd0000        	call	_CLK_HSIPrescalerConfig
  62                     ; 11     CLK_PeripheralClockConfig(
  62                     ; 12         CLK_PERIPHERAL_SPI,
  62                     ; 13         ENABLE);
  64  0004 ae0101        	ldw	x,#257
  65  0007 cd0000        	call	_CLK_PeripheralClockConfig
  67                     ; 15     W5500_GPIO_Init();
  69  000a cd0000        	call	_W5500_GPIO_Init
  71                     ; 17     W5500_SPI_Init();
  73  000d cd0000        	call	_W5500_SPI_Init
  75                     ; 19     W5500_Hardware_Reset();
  77  0010 cd0000        	call	_W5500_Hardware_Reset
  79                     ; 21     W5500_Init();
  81  0013 cd0000        	call	_W5500_Init
  83                     ; 23     version = W5500_ReadReg(VERSIONR);
  85  0016 ae0039        	ldw	x,#57
  86  0019 cd0000        	call	_W5500_ReadReg
  88  001c b700          	ld	_version,a
  89  001e               L12:
  91  001e 20fe          	jra	L12
 115                     	xdef	_main
 116                     	switch	.ubsct
 117  0000               _version:
 118  0000 00            	ds.b	1
 119                     	xdef	_version
 120                     	xref	_W5500_ReadReg
 121                     	xref	_W5500_Init
 122                     	xref	_W5500_Hardware_Reset
 123                     	xref	_W5500_SPI_Init
 124                     	xref	_W5500_GPIO_Init
 125                     	xref	_CLK_HSIPrescalerConfig
 126                     	xref	_CLK_PeripheralClockConfig
 146                     	end
