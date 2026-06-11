   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  14                     	bsct
  15  0000               L5_uart_rx_head:
  16  0000 0000          	dc.w	0
  17  0002               L7_uart_rx_tail:
  18  0002 0000          	dc.w	0
  19  0004               L11_uart_rx_count:
  20  0004 0000          	dc.w	0
  67                     ; 31 void hal_uart_init(uint32_t baudrate)
  67                     ; 32 {
  69                     	switch	.text
  70  0000               _hal_uart_init:
  72       00000000      OFST:	set	0
  75                     ; 34     CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
  77  0000 ae0301        	ldw	x,#769
  78  0003 cd0000        	call	_CLK_PeripheralClockConfig
  80                     ; 43     UART1_Init(
  80                     ; 44     baudrate,
  80                     ; 45     UART1_WORDLENGTH_8D,
  80                     ; 46     UART1_STOPBITS_1,
  80                     ; 47     UART1_PARITY_NO,
  80                     ; 48     UART1_SYNCMODE_CLOCK_DISABLE,
  80                     ; 49     (UART1_Mode_TypeDef)(UART1_MODE_TX_ENABLE | UART1_MODE_RX_ENABLE)
  80                     ; 50 );
  82  0006 4b0c          	push	#12
  83  0008 4b80          	push	#128
  84  000a 4b00          	push	#0
  85  000c 4b00          	push	#0
  86  000e 4b00          	push	#0
  87  0010 1e0a          	ldw	x,(OFST+10,sp)
  88  0012 89            	pushw	x
  89  0013 1e0a          	ldw	x,(OFST+10,sp)
  90  0015 89            	pushw	x
  91  0016 cd0000        	call	_UART1_Init
  93  0019 5b09          	addw	sp,#9
  94                     ; 53     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
  96  001b 4b01          	push	#1
  97  001d ae0255        	ldw	x,#597
  98  0020 cd0000        	call	_UART1_ITConfig
 100  0023 84            	pop	a
 101                     ; 56     UART1_Cmd(ENABLE);
 103  0024 a601          	ld	a,#1
 104  0026 cd0000        	call	_UART1_Cmd
 106                     ; 59     uart_rx_head = 0;
 108  0029 5f            	clrw	x
 109  002a bf00          	ldw	L5_uart_rx_head,x
 110                     ; 60     uart_rx_tail = 0;
 112  002c 5f            	clrw	x
 113  002d bf02          	ldw	L7_uart_rx_tail,x
 114                     ; 61     uart_rx_count = 0;
 116  002f 5f            	clrw	x
 117  0030 bf04          	ldw	L11_uart_rx_count,x
 118                     ; 62 }
 121  0032 81            	ret
 157                     ; 67 void hal_uart_send_byte(uint8_t byte)
 157                     ; 68 {
 158                     	switch	.text
 159  0033               _hal_uart_send_byte:
 161  0033 88            	push	a
 162       00000000      OFST:	set	0
 165  0034               L16:
 166                     ; 70     while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 168  0034 ae0080        	ldw	x,#128
 169  0037 cd0000        	call	_UART1_GetFlagStatus
 171  003a 4d            	tnz	a
 172  003b 27f7          	jreq	L16
 173                     ; 73     UART1_SendData8(byte);
 175  003d 7b01          	ld	a,(OFST+1,sp)
 176  003f cd0000        	call	_UART1_SendData8
 179  0042               L76:
 180                     ; 76     while (UART1_GetFlagStatus(UART1_FLAG_TC) == RESET);
 182  0042 ae0040        	ldw	x,#64
 183  0045 cd0000        	call	_UART1_GetFlagStatus
 185  0048 4d            	tnz	a
 186  0049 27f7          	jreq	L76
 187                     ; 77 }
 190  004b 84            	pop	a
 191  004c 81            	ret
 245                     ; 82 void hal_uart_send(const uint8_t *data, uint16_t len)
 245                     ; 83 {
 246                     	switch	.text
 247  004d               _hal_uart_send:
 249  004d 89            	pushw	x
 250  004e 89            	pushw	x
 251       00000002      OFST:	set	2
 254                     ; 85     for (i = 0; i < len; i++) {
 256  004f 5f            	clrw	x
 257  0050 1f01          	ldw	(OFST-1,sp),x
 260  0052 200f          	jra	L521
 261  0054               L121:
 262                     ; 86         hal_uart_send_byte(data[i]);
 264  0054 1e03          	ldw	x,(OFST+1,sp)
 265  0056 72fb01        	addw	x,(OFST-1,sp)
 266  0059 f6            	ld	a,(x)
 267  005a add7          	call	_hal_uart_send_byte
 269                     ; 85     for (i = 0; i < len; i++) {
 271  005c 1e01          	ldw	x,(OFST-1,sp)
 272  005e 1c0001        	addw	x,#1
 273  0061 1f01          	ldw	(OFST-1,sp),x
 275  0063               L521:
 278  0063 1e01          	ldw	x,(OFST-1,sp)
 279  0065 1307          	cpw	x,(OFST+5,sp)
 280  0067 25eb          	jrult	L121
 281                     ; 88 }
 284  0069 5b04          	addw	sp,#4
 285  006b 81            	ret
 309                     ; 93 uint16_t hal_uart_available(void)
 309                     ; 94 {
 310                     	switch	.text
 311  006c               _hal_uart_available:
 315                     ; 95     return uart_rx_count;
 317  006c be04          	ldw	x,L11_uart_rx_count
 320  006e 81            	ret
 359                     ; 101 uint8_t hal_uart_read_byte(void)
 359                     ; 102 {
 360                     	switch	.text
 361  006f               _hal_uart_read_byte:
 363  006f 88            	push	a
 364       00000001      OFST:	set	1
 367                     ; 103     uint8_t byte = 0;
 369  0070 0f01          	clr	(OFST+0,sp)
 371                     ; 105     if (uart_rx_count > 0) {
 373  0072 be04          	ldw	x,L11_uart_rx_count
 374  0074 271b          	jreq	L751
 375                     ; 107         disableInterrupts();
 378  0076 9b            sim
 380                     ; 109         byte = uart_rx_buffer[uart_rx_tail];
 383  0077 be02          	ldw	x,L7_uart_rx_tail
 384  0079 e600          	ld	a,(L3_uart_rx_buffer,x)
 385  007b 6b01          	ld	(OFST+0,sp),a
 387                     ; 110         uart_rx_tail = (uart_rx_tail + 1) % UART_RX_BUFFER_SIZE;
 389  007d be02          	ldw	x,L7_uart_rx_tail
 390  007f 5c            	incw	x
 391  0080 01            	rrwa	x,a
 392  0081 a4ff          	and	a,#255
 393  0083 5f            	clrw	x
 394  0084 b703          	ld	L7_uart_rx_tail+1,a
 395  0086 9f            	ld	a,xl
 396  0087 b702          	ld	L7_uart_rx_tail,a
 397                     ; 111         uart_rx_count--;
 399  0089 be04          	ldw	x,L11_uart_rx_count
 400  008b 1d0001        	subw	x,#1
 401  008e bf04          	ldw	L11_uart_rx_count,x
 402                     ; 113         enableInterrupts();
 405  0090 9a            rim
 408  0091               L751:
 409                     ; 116     return byte;
 411  0091 7b01          	ld	a,(OFST+0,sp)
 414  0093 5b01          	addw	sp,#1
 415  0095 81            	ret
 470                     ; 122 uint16_t hal_uart_read(uint8_t *data, uint16_t len)
 470                     ; 123 {
 471                     	switch	.text
 472  0096               _hal_uart_read:
 474  0096 89            	pushw	x
 475  0097 89            	pushw	x
 476       00000002      OFST:	set	2
 479                     ; 124     uint16_t i = 0;
 481  0098 5f            	clrw	x
 482  0099 1f01          	ldw	(OFST-1,sp),x
 485  009b 200f          	jra	L312
 486  009d               L702:
 487                     ; 127         data[i] = hal_uart_read_byte();
 489  009d add0          	call	_hal_uart_read_byte
 491  009f 1e03          	ldw	x,(OFST+1,sp)
 492  00a1 72fb01        	addw	x,(OFST-1,sp)
 493  00a4 f7            	ld	(x),a
 494                     ; 128         i++;
 496  00a5 1e01          	ldw	x,(OFST-1,sp)
 497  00a7 1c0001        	addw	x,#1
 498  00aa 1f01          	ldw	(OFST-1,sp),x
 500  00ac               L312:
 501                     ; 126     while (i < len && uart_rx_count > 0) {
 503  00ac 1e01          	ldw	x,(OFST-1,sp)
 504  00ae 1307          	cpw	x,(OFST+5,sp)
 505  00b0 2404          	jruge	L712
 507  00b2 be04          	ldw	x,L11_uart_rx_count
 508  00b4 26e7          	jrne	L702
 509  00b6               L712:
 510                     ; 131     return i;
 512  00b6 1e01          	ldw	x,(OFST-1,sp)
 515  00b8 5b04          	addw	sp,#4
 516  00ba 81            	ret
 545                     ; 137 void hal_uart_clear_rx_buffer(void)
 545                     ; 138 {
 546                     	switch	.text
 547  00bb               _hal_uart_clear_rx_buffer:
 551                     ; 139     disableInterrupts();
 554  00bb 9b            sim
 556                     ; 140     uart_rx_head = 0;
 559  00bc 5f            	clrw	x
 560  00bd bf00          	ldw	L5_uart_rx_head,x
 561                     ; 141     uart_rx_tail = 0;
 563  00bf 5f            	clrw	x
 564  00c0 bf02          	ldw	L7_uart_rx_tail,x
 565                     ; 142     uart_rx_count = 0;
 567  00c2 5f            	clrw	x
 568  00c3 bf04          	ldw	L11_uart_rx_count,x
 569                     ; 143     enableInterrupts();
 572  00c5 9a            rim
 574                     ; 144 }
 578  00c6 81            	ret
 617                     ; 150 void uart_rx_handler(void)
 617                     ; 151 {
 618                     	switch	.text
 619  00c7               _uart_rx_handler:
 621  00c7 88            	push	a
 622       00000001      OFST:	set	1
 625                     ; 155     if (UART1_GetFlagStatus(UART1_FLAG_RXNE) != RESET) {
 627  00c8 ae0020        	ldw	x,#32
 628  00cb cd0000        	call	_UART1_GetFlagStatus
 630  00ce 4d            	tnz	a
 631  00cf 2725          	jreq	L742
 632                     ; 156         byte = UART1_ReceiveData8();
 634  00d1 cd0000        	call	_UART1_ReceiveData8
 636  00d4 6b01          	ld	(OFST+0,sp),a
 638                     ; 159         if (uart_rx_count < UART_RX_BUFFER_SIZE) {
 640  00d6 be04          	ldw	x,L11_uart_rx_count
 641  00d8 a30100        	cpw	x,#256
 642  00db 2419          	jruge	L742
 643                     ; 160             uart_rx_buffer[uart_rx_head] = byte;
 645  00dd 7b01          	ld	a,(OFST+0,sp)
 646  00df be00          	ldw	x,L5_uart_rx_head
 647  00e1 e700          	ld	(L3_uart_rx_buffer,x),a
 648                     ; 161             uart_rx_head = (uart_rx_head + 1) % UART_RX_BUFFER_SIZE;
 650  00e3 be00          	ldw	x,L5_uart_rx_head
 651  00e5 5c            	incw	x
 652  00e6 01            	rrwa	x,a
 653  00e7 a4ff          	and	a,#255
 654  00e9 5f            	clrw	x
 655  00ea b701          	ld	L5_uart_rx_head+1,a
 656  00ec 9f            	ld	a,xl
 657  00ed b700          	ld	L5_uart_rx_head,a
 658                     ; 162             uart_rx_count++;
 660  00ef be04          	ldw	x,L11_uart_rx_count
 661  00f1 1c0001        	addw	x,#1
 662  00f4 bf04          	ldw	L11_uart_rx_count,x
 663  00f6               L742:
 664                     ; 165 }
 667  00f6 84            	pop	a
 668  00f7 81            	ret
 720                     	switch	.ubsct
 721  0000               L3_uart_rx_buffer:
 722  0000 000000000000  	ds.b	256
 723                     	xdef	_uart_rx_handler
 724                     	xdef	_hal_uart_clear_rx_buffer
 725                     	xdef	_hal_uart_read
 726                     	xdef	_hal_uart_read_byte
 727                     	xdef	_hal_uart_available
 728                     	xdef	_hal_uart_send
 729                     	xdef	_hal_uart_send_byte
 730                     	xdef	_hal_uart_init
 731                     	xref	_UART1_GetFlagStatus
 732                     	xref	_UART1_SendData8
 733                     	xref	_UART1_ReceiveData8
 734                     	xref	_UART1_ITConfig
 735                     	xref	_UART1_Cmd
 736                     	xref	_UART1_Init
 737                     	xref	_CLK_PeripheralClockConfig
 757                     	end
