   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  43                     ; 3 void DIO_Init(void)
  43                     ; 4 {
  45                     	switch	.text
  46  0000               _DIO_Init:
  50                     ; 9     GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
  52  0000 4be0          	push	#224
  53  0002 4b08          	push	#8
  54  0004 ae5005        	ldw	x,#20485
  55  0007 cd0000        	call	_GPIO_Init
  57  000a 85            	popw	x
  58                     ; 10     GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
  60  000b 4be0          	push	#224
  61  000d 4b04          	push	#4
  62  000f ae5005        	ldw	x,#20485
  63  0012 cd0000        	call	_GPIO_Init
  65  0015 85            	popw	x
  66                     ; 11     GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
  68  0016 4be0          	push	#224
  69  0018 4b02          	push	#2
  70  001a ae5005        	ldw	x,#20485
  71  001d cd0000        	call	_GPIO_Init
  73  0020 85            	popw	x
  74                     ; 12     GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
  76  0021 4be0          	push	#224
  77  0023 4b01          	push	#1
  78  0025 ae5005        	ldw	x,#20485
  79  0028 cd0000        	call	_GPIO_Init
  81  002b 85            	popw	x
  82                     ; 14     GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
  84  002c 4be0          	push	#224
  85  002e 4b08          	push	#8
  86  0030 ae500a        	ldw	x,#20490
  87  0033 cd0000        	call	_GPIO_Init
  89  0036 85            	popw	x
  90                     ; 15     GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
  92  0037 4be0          	push	#224
  93  0039 4b10          	push	#16
  94  003b ae500a        	ldw	x,#20490
  95  003e cd0000        	call	_GPIO_Init
  97  0041 85            	popw	x
  98                     ; 22     GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
 100  0042 4b40          	push	#64
 101  0044 4b04          	push	#4
 102  0046 ae500f        	ldw	x,#20495
 103  0049 cd0000        	call	_GPIO_Init
 105  004c 85            	popw	x
 106                     ; 23     GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 108  004d 4b40          	push	#64
 109  004f 4b08          	push	#8
 110  0051 ae500f        	ldw	x,#20495
 111  0054 cd0000        	call	_GPIO_Init
 113  0057 85            	popw	x
 114                     ; 24     GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);
 116  0058 4b40          	push	#64
 117  005a 4b10          	push	#16
 118  005c ae500f        	ldw	x,#20495
 119  005f cd0000        	call	_GPIO_Init
 121  0062 85            	popw	x
 122                     ; 25     GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT);
 124  0063 4b40          	push	#64
 125  0065 4b80          	push	#128
 126  0067 ae500f        	ldw	x,#20495
 127  006a cd0000        	call	_GPIO_Init
 129  006d 85            	popw	x
 130                     ; 31     GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST); // CS
 132  006e 4bf0          	push	#240
 133  0070 4b08          	push	#8
 134  0072 ae5000        	ldw	x,#20480
 135  0075 cd0000        	call	_GPIO_Init
 137  0078 85            	popw	x
 138                     ; 34     GPIO_Init(GPIOE, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 140  0079 4bf0          	push	#240
 141  007b 4b20          	push	#32
 142  007d ae5014        	ldw	x,#20500
 143  0080 cd0000        	call	_GPIO_Init
 145  0083 85            	popw	x
 146                     ; 40     GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
 148  0084 4be0          	push	#224
 149  0086 4b02          	push	#2
 150  0088 ae500a        	ldw	x,#20490
 151  008b cd0000        	call	_GPIO_Init
 153  008e 85            	popw	x
 154                     ; 41 }
 157  008f 81            	ret
 193                     ; 47 void Relay1_Set(uint8_t state)
 193                     ; 48 {
 194                     	switch	.text
 195  0090               _Relay1_Set:
 199                     ; 49     if(state)
 201  0090 4d            	tnz	a
 202  0091 270b          	jreq	L73
 203                     ; 50         GPIO_WriteHigh(GPIOB, GPIO_PIN_3);
 205  0093 4b08          	push	#8
 206  0095 ae5005        	ldw	x,#20485
 207  0098 cd0000        	call	_GPIO_WriteHigh
 209  009b 84            	pop	a
 211  009c 2009          	jra	L14
 212  009e               L73:
 213                     ; 52         GPIO_WriteLow(GPIOB, GPIO_PIN_3);
 215  009e 4b08          	push	#8
 216  00a0 ae5005        	ldw	x,#20485
 217  00a3 cd0000        	call	_GPIO_WriteLow
 219  00a6 84            	pop	a
 220  00a7               L14:
 221                     ; 53 }
 224  00a7 81            	ret
 260                     ; 55 void Relay2_Set(uint8_t state)
 260                     ; 56 {
 261                     	switch	.text
 262  00a8               _Relay2_Set:
 266                     ; 57     if(state)
 268  00a8 4d            	tnz	a
 269  00a9 270b          	jreq	L16
 270                     ; 58         GPIO_WriteHigh(GPIOB, GPIO_PIN_2);
 272  00ab 4b04          	push	#4
 273  00ad ae5005        	ldw	x,#20485
 274  00b0 cd0000        	call	_GPIO_WriteHigh
 276  00b3 84            	pop	a
 278  00b4 2009          	jra	L36
 279  00b6               L16:
 280                     ; 60         GPIO_WriteLow(GPIOB, GPIO_PIN_2);
 282  00b6 4b04          	push	#4
 283  00b8 ae5005        	ldw	x,#20485
 284  00bb cd0000        	call	_GPIO_WriteLow
 286  00be 84            	pop	a
 287  00bf               L36:
 288                     ; 61 }
 291  00bf 81            	ret
 327                     ; 63 void Relay3_Set(uint8_t state)
 327                     ; 64 {
 328                     	switch	.text
 329  00c0               _Relay3_Set:
 333                     ; 65     if(state)
 335  00c0 4d            	tnz	a
 336  00c1 270b          	jreq	L301
 337                     ; 66         GPIO_WriteHigh(GPIOB, GPIO_PIN_1);
 339  00c3 4b02          	push	#2
 340  00c5 ae5005        	ldw	x,#20485
 341  00c8 cd0000        	call	_GPIO_WriteHigh
 343  00cb 84            	pop	a
 345  00cc 2009          	jra	L501
 346  00ce               L301:
 347                     ; 68         GPIO_WriteLow(GPIOB, GPIO_PIN_1);
 349  00ce 4b02          	push	#2
 350  00d0 ae5005        	ldw	x,#20485
 351  00d3 cd0000        	call	_GPIO_WriteLow
 353  00d6 84            	pop	a
 354  00d7               L501:
 355                     ; 69 }
 358  00d7 81            	ret
 394                     ; 71 void Relay4_Set(uint8_t state)
 394                     ; 72 {
 395                     	switch	.text
 396  00d8               _Relay4_Set:
 400                     ; 73     if(state)
 402  00d8 4d            	tnz	a
 403  00d9 270b          	jreq	L521
 404                     ; 74         GPIO_WriteHigh(GPIOB, GPIO_PIN_0);
 406  00db 4b01          	push	#1
 407  00dd ae5005        	ldw	x,#20485
 408  00e0 cd0000        	call	_GPIO_WriteHigh
 410  00e3 84            	pop	a
 412  00e4 2009          	jra	L721
 413  00e6               L521:
 414                     ; 76         GPIO_WriteLow(GPIOB, GPIO_PIN_0);
 416  00e6 4b01          	push	#1
 417  00e8 ae5005        	ldw	x,#20485
 418  00eb cd0000        	call	_GPIO_WriteLow
 420  00ee 84            	pop	a
 421  00ef               L721:
 422                     ; 77 }
 425  00ef 81            	ret
 461                     ; 79 void Relay5_Set(uint8_t state)
 461                     ; 80 {
 462                     	switch	.text
 463  00f0               _Relay5_Set:
 467                     ; 81     if(state)
 469  00f0 4d            	tnz	a
 470  00f1 270b          	jreq	L741
 471                     ; 82         GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 473  00f3 4b08          	push	#8
 474  00f5 ae500a        	ldw	x,#20490
 475  00f8 cd0000        	call	_GPIO_WriteHigh
 477  00fb 84            	pop	a
 479  00fc 2009          	jra	L151
 480  00fe               L741:
 481                     ; 84         GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 483  00fe 4b08          	push	#8
 484  0100 ae500a        	ldw	x,#20490
 485  0103 cd0000        	call	_GPIO_WriteLow
 487  0106 84            	pop	a
 488  0107               L151:
 489                     ; 85 }
 492  0107 81            	ret
 528                     ; 87 void Relay6_Set(uint8_t state)
 528                     ; 88 {
 529                     	switch	.text
 530  0108               _Relay6_Set:
 534                     ; 89     if(state)
 536  0108 4d            	tnz	a
 537  0109 270b          	jreq	L171
 538                     ; 90         GPIO_WriteHigh(GPIOC, GPIO_PIN_4);
 540  010b 4b10          	push	#16
 541  010d ae500a        	ldw	x,#20490
 542  0110 cd0000        	call	_GPIO_WriteHigh
 544  0113 84            	pop	a
 546  0114 2009          	jra	L371
 547  0116               L171:
 548                     ; 92         GPIO_WriteLow(GPIOC, GPIO_PIN_4);
 550  0116 4b10          	push	#16
 551  0118 ae500a        	ldw	x,#20490
 552  011b cd0000        	call	_GPIO_WriteLow
 554  011e 84            	pop	a
 555  011f               L371:
 556                     ; 93 }
 559  011f 81            	ret
 583                     ; 103 uint8_t Input1_Read(void)
 583                     ; 104 {
 584                     	switch	.text
 585  0120               _Input1_Read:
 589                     ; 105     return (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2) == RESET);
 591  0120 4b04          	push	#4
 592  0122 ae500f        	ldw	x,#20495
 593  0125 cd0000        	call	_GPIO_ReadInputPin
 595  0128 5b01          	addw	sp,#1
 596  012a 4d            	tnz	a
 597  012b 2604          	jrne	L42
 598  012d a601          	ld	a,#1
 599  012f 2001          	jra	L62
 600  0131               L42:
 601  0131 4f            	clr	a
 602  0132               L62:
 605  0132 81            	ret
 629                     ; 108 uint8_t Input2_Read(void)
 629                     ; 109 {
 630                     	switch	.text
 631  0133               _Input2_Read:
 635                     ; 110     return (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3) == RESET);
 637  0133 4b08          	push	#8
 638  0135 ae500f        	ldw	x,#20495
 639  0138 cd0000        	call	_GPIO_ReadInputPin
 641  013b 5b01          	addw	sp,#1
 642  013d 4d            	tnz	a
 643  013e 2604          	jrne	L23
 644  0140 a601          	ld	a,#1
 645  0142 2001          	jra	L43
 646  0144               L23:
 647  0144 4f            	clr	a
 648  0145               L43:
 651  0145 81            	ret
 675                     ; 113 uint8_t Input3_Read(void)
 675                     ; 114 {
 676                     	switch	.text
 677  0146               _Input3_Read:
 681                     ; 115     return (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4) == RESET);
 683  0146 4b10          	push	#16
 684  0148 ae500f        	ldw	x,#20495
 685  014b cd0000        	call	_GPIO_ReadInputPin
 687  014e 5b01          	addw	sp,#1
 688  0150 4d            	tnz	a
 689  0151 2604          	jrne	L04
 690  0153 a601          	ld	a,#1
 691  0155 2001          	jra	L24
 692  0157               L04:
 693  0157 4f            	clr	a
 694  0158               L24:
 697  0158 81            	ret
 721                     ; 118 uint8_t Input4_Read(void)
 721                     ; 119 {
 722                     	switch	.text
 723  0159               _Input4_Read:
 727                     ; 120     return (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7) == RESET);
 729  0159 4b80          	push	#128
 730  015b ae500f        	ldw	x,#20495
 731  015e cd0000        	call	_GPIO_ReadInputPin
 733  0161 5b01          	addw	sp,#1
 734  0163 4d            	tnz	a
 735  0164 2604          	jrne	L64
 736  0166 a601          	ld	a,#1
 737  0168 2001          	jra	L05
 738  016a               L64:
 739  016a 4f            	clr	a
 740  016b               L05:
 743  016b 81            	ret
 756                     	xdef	_Input4_Read
 757                     	xdef	_Input3_Read
 758                     	xdef	_Input2_Read
 759                     	xdef	_Input1_Read
 760                     	xdef	_Relay6_Set
 761                     	xdef	_Relay5_Set
 762                     	xdef	_Relay4_Set
 763                     	xdef	_Relay3_Set
 764                     	xdef	_Relay2_Set
 765                     	xdef	_Relay1_Set
 766                     	xdef	_DIO_Init
 767                     	xref	_GPIO_ReadInputPin
 768                     	xref	_GPIO_WriteLow
 769                     	xref	_GPIO_WriteHigh
 770                     	xref	_GPIO_Init
 789                     	end
