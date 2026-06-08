   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  43                     ; 5 void W5500_Select(void)
  43                     ; 6 {
  45                     	switch	.text
  46  0000               _W5500_Select:
  50                     ; 7     GPIO_WriteLow(W5500_CS_PORT,W5500_CS_PIN);
  52  0000 4b08          	push	#8
  53  0002 ae5000        	ldw	x,#20480
  54  0005 cd0000        	call	_GPIO_WriteLow
  56  0008 84            	pop	a
  57                     ; 8 }
  60  0009 81            	ret
  84                     ; 10 void W5500_Unselect(void)
  84                     ; 11 {
  85                     	switch	.text
  86  000a               _W5500_Unselect:
  90                     ; 12     GPIO_WriteHigh(W5500_CS_PORT,W5500_CS_PIN);
  92  000a 4b08          	push	#8
  93  000c ae5000        	ldw	x,#20480
  94  000f cd0000        	call	_GPIO_WriteHigh
  96  0012 84            	pop	a
  97                     ; 13 }
 100  0013 81            	ret
 137                     ; 15 uint8_t W5500_SendByte(uint8_t data)
 137                     ; 16 {
 138                     	switch	.text
 139  0014               _W5500_SendByte:
 143                     ; 17     SPI_SendData(data);
 145  0014 cd0000        	call	_SPI_SendData
 148  0017               L15:
 149                     ; 19     while(SPI_GetFlagStatus(SPI_FLAG_RXNE)==RESET);
 151  0017 a601          	ld	a,#1
 152  0019 cd0000        	call	_SPI_GetFlagStatus
 154  001c 4d            	tnz	a
 155  001d 27f8          	jreq	L15
 156                     ; 21     return SPI_ReceiveData();
 158  001f cd0000        	call	_SPI_ReceiveData
 162  0022 81            	ret
 187                     ; 24 void W5500_GPIO_Init(void)
 187                     ; 25 {
 188                     	switch	.text
 189  0023               _W5500_GPIO_Init:
 193                     ; 26     GPIO_Init(GPIOC,
 193                     ; 27               GPIO_PIN_5,
 193                     ; 28               GPIO_MODE_OUT_PP_HIGH_FAST);
 195  0023 4bf0          	push	#240
 196  0025 4b20          	push	#32
 197  0027 ae500a        	ldw	x,#20490
 198  002a cd0000        	call	_GPIO_Init
 200  002d 85            	popw	x
 201                     ; 30     GPIO_Init(GPIOC,
 201                     ; 31               GPIO_PIN_6,
 201                     ; 32               GPIO_MODE_OUT_PP_HIGH_FAST);
 203  002e 4bf0          	push	#240
 204  0030 4b40          	push	#64
 205  0032 ae500a        	ldw	x,#20490
 206  0035 cd0000        	call	_GPIO_Init
 208  0038 85            	popw	x
 209                     ; 34     GPIO_Init(GPIOC,
 209                     ; 35               GPIO_PIN_7,
 209                     ; 36               GPIO_MODE_IN_FL_NO_IT);
 211  0039 4b00          	push	#0
 212  003b 4b80          	push	#128
 213  003d ae500a        	ldw	x,#20490
 214  0040 cd0000        	call	_GPIO_Init
 216  0043 85            	popw	x
 217                     ; 38     GPIO_Init(GPIOA,
 217                     ; 39               GPIO_PIN_3,
 217                     ; 40               GPIO_MODE_OUT_PP_HIGH_FAST);
 219  0044 4bf0          	push	#240
 220  0046 4b08          	push	#8
 221  0048 ae5000        	ldw	x,#20480
 222  004b cd0000        	call	_GPIO_Init
 224  004e 85            	popw	x
 225                     ; 42     GPIO_Init(GPIOE,
 225                     ; 43               GPIO_PIN_5,
 225                     ; 44               GPIO_MODE_OUT_PP_HIGH_FAST);
 227  004f 4bf0          	push	#240
 228  0051 4b20          	push	#32
 229  0053 ae5014        	ldw	x,#20500
 230  0056 cd0000        	call	_GPIO_Init
 232  0059 85            	popw	x
 233                     ; 46     GPIO_WriteHigh(GPIOA,GPIO_PIN_3);
 235  005a 4b08          	push	#8
 236  005c ae5000        	ldw	x,#20480
 237  005f cd0000        	call	_GPIO_WriteHigh
 239  0062 84            	pop	a
 240                     ; 47 }
 243  0063 81            	ret
 269                     ; 49 void W5500_SPI_Init(void)
 269                     ; 50 {
 270                     	switch	.text
 271  0064               _W5500_SPI_Init:
 275                     ; 51     SPI_DeInit();
 277  0064 cd0000        	call	_SPI_DeInit
 279                     ; 53     SPI_Init(
 279                     ; 54         SPI_FIRSTBIT_MSB,
 279                     ; 55         SPI_BAUDRATEPRESCALER_8,
 279                     ; 56         SPI_MODE_MASTER,
 279                     ; 57         SPI_CLOCKPOLARITY_LOW,
 279                     ; 58         SPI_CLOCKPHASE_1EDGE,
 279                     ; 59         SPI_DATADIRECTION_2LINES_FULLDUPLEX,
 279                     ; 60         SPI_NSS_SOFT,
 279                     ; 61         0x07);
 281  0067 4b07          	push	#7
 282  0069 4b02          	push	#2
 283  006b 4b00          	push	#0
 284  006d 4b00          	push	#0
 285  006f 4b00          	push	#0
 286  0071 4b04          	push	#4
 287  0073 ae0010        	ldw	x,#16
 288  0076 cd0000        	call	_SPI_Init
 290  0079 5b06          	addw	sp,#6
 291                     ; 63     SPI_Cmd(ENABLE);
 293  007b a601          	ld	a,#1
 294  007d cd0000        	call	_SPI_Cmd
 296                     ; 64 }
 299  0080 81            	ret
 336                     .const:	section	.text
 337  0000               L02:
 338  0000 00007530      	dc.l	30000
 339  0004               L22:
 340  0004 0000ea60      	dc.l	60000
 341                     ; 66 void W5500_Hardware_Reset(void)
 341                     ; 67 {
 342                     	switch	.text
 343  0081               _W5500_Hardware_Reset:
 345  0081 5204          	subw	sp,#4
 346       00000004      OFST:	set	4
 349                     ; 70     GPIO_WriteLow(GPIOE,GPIO_PIN_5);
 351  0083 4b20          	push	#32
 352  0085 ae5014        	ldw	x,#20500
 353  0088 cd0000        	call	_GPIO_WriteLow
 355  008b 84            	pop	a
 356                     ; 72     for(i=0;i<30000;i++);
 358  008c ae0000        	ldw	x,#0
 359  008f 1f03          	ldw	(OFST-1,sp),x
 360  0091 ae0000        	ldw	x,#0
 361  0094 1f01          	ldw	(OFST-3,sp),x
 364  0096 2009          	jra	L711
 365  0098               L311:
 369  0098 96            	ldw	x,sp
 370  0099 1c0001        	addw	x,#OFST-3
 371  009c a601          	ld	a,#1
 372  009e cd0000        	call	c_lgadc
 375  00a1               L711:
 378  00a1 96            	ldw	x,sp
 379  00a2 1c0001        	addw	x,#OFST-3
 380  00a5 cd0000        	call	c_ltor
 382  00a8 ae0000        	ldw	x,#L02
 383  00ab cd0000        	call	c_lcmp
 385  00ae 25e8          	jrult	L311
 386                     ; 74     GPIO_WriteHigh(GPIOE,GPIO_PIN_5);
 388  00b0 4b20          	push	#32
 389  00b2 ae5014        	ldw	x,#20500
 390  00b5 cd0000        	call	_GPIO_WriteHigh
 392  00b8 84            	pop	a
 393                     ; 76     for(i=0;i<60000;i++);
 395  00b9 ae0000        	ldw	x,#0
 396  00bc 1f03          	ldw	(OFST-1,sp),x
 397  00be ae0000        	ldw	x,#0
 398  00c1 1f01          	ldw	(OFST-3,sp),x
 401  00c3 2009          	jra	L721
 402  00c5               L321:
 406  00c5 96            	ldw	x,sp
 407  00c6 1c0001        	addw	x,#OFST-3
 408  00c9 a601          	ld	a,#1
 409  00cb cd0000        	call	c_lgadc
 412  00ce               L721:
 415  00ce 96            	ldw	x,sp
 416  00cf 1c0001        	addw	x,#OFST-3
 417  00d2 cd0000        	call	c_ltor
 419  00d5 ae0004        	ldw	x,#L22
 420  00d8 cd0000        	call	c_lcmp
 422  00db 25e8          	jrult	L321
 423                     ; 77 }
 426  00dd 5b04          	addw	sp,#4
 427  00df 81            	ret
 473                     ; 79 void W5500_WriteReg(uint16_t addr,uint8_t data)
 473                     ; 80 {
 474                     	switch	.text
 475  00e0               _W5500_WriteReg:
 477  00e0 89            	pushw	x
 478       00000000      OFST:	set	0
 481                     ; 81     W5500_Select();
 483  00e1 cd0000        	call	_W5500_Select
 485                     ; 83     W5500_SendByte(addr >> 8);
 487  00e4 7b01          	ld	a,(OFST+1,sp)
 488  00e6 cd0014        	call	_W5500_SendByte
 490                     ; 84     W5500_SendByte(addr & 0xFF);
 492  00e9 7b02          	ld	a,(OFST+2,sp)
 493  00eb a4ff          	and	a,#255
 494  00ed cd0014        	call	_W5500_SendByte
 496                     ; 87     W5500_SendByte(0x04);
 498  00f0 a604          	ld	a,#4
 499  00f2 cd0014        	call	_W5500_SendByte
 501                     ; 89     W5500_SendByte(data);
 503  00f5 7b05          	ld	a,(OFST+5,sp)
 504  00f7 cd0014        	call	_W5500_SendByte
 506                     ; 91     W5500_Unselect();
 508  00fa cd000a        	call	_W5500_Unselect
 510                     ; 92 }
 513  00fd 85            	popw	x
 514  00fe 81            	ret
 560                     ; 94 uint8_t W5500_ReadReg(uint16_t addr)
 560                     ; 95 {
 561                     	switch	.text
 562  00ff               _W5500_ReadReg:
 564  00ff 89            	pushw	x
 565  0100 88            	push	a
 566       00000001      OFST:	set	1
 569                     ; 98     W5500_Select();
 571  0101 cd0000        	call	_W5500_Select
 573                     ; 100     W5500_SendByte(addr >> 8);
 575  0104 7b02          	ld	a,(OFST+1,sp)
 576  0106 cd0014        	call	_W5500_SendByte
 578                     ; 101     W5500_SendByte(addr & 0xFF);
 580  0109 7b03          	ld	a,(OFST+2,sp)
 581  010b a4ff          	and	a,#255
 582  010d cd0014        	call	_W5500_SendByte
 584                     ; 104     W5500_SendByte(0x00);
 586  0110 4f            	clr	a
 587  0111 cd0014        	call	_W5500_SendByte
 589                     ; 106     value = W5500_SendByte(0xFF);
 591  0114 a6ff          	ld	a,#255
 592  0116 cd0014        	call	_W5500_SendByte
 594  0119 6b01          	ld	(OFST+0,sp),a
 596                     ; 108     W5500_Unselect();
 598  011b cd000a        	call	_W5500_Unselect
 600                     ; 110     return value;
 602  011e 7b01          	ld	a,(OFST+0,sp)
 605  0120 5b03          	addw	sp,#3
 606  0122 81            	ret
 609                     	switch	.const
 610  0008               L771_mac:
 611  0008 00            	dc.b	0
 612  0009 08            	dc.b	8
 613  000a dc            	dc.b	220
 614  000b 11            	dc.b	17
 615  000c 22            	dc.b	34
 616  000d 33            	dc.b	51
 617  000e               L102_ip:
 618  000e c0            	dc.b	192
 619  000f a8            	dc.b	168
 620  0010 64            	dc.b	100
 621  0011 34            	dc.b	52
 622  0012               L302_sn:
 623  0012 ff            	dc.b	255
 624  0013 ff            	dc.b	255
 625  0014 ff            	dc.b	255
 626  0015 00            	dc.b	0
 627  0016               L502_gw:
 628  0016 c0            	dc.b	192
 629  0017 a8            	dc.b	168
 630  0018 64            	dc.b	100
 631  0019 01            	dc.b	1
 704                     ; 113 void W5500_Init(void)
 704                     ; 114 {
 705                     	switch	.text
 706  0123               _W5500_Init:
 708  0123 5213          	subw	sp,#19
 709       00000013      OFST:	set	19
 712                     ; 117     uint8_t mac[6] =
 712                     ; 118     {
 712                     ; 119         0x00,0x08,0xDC,
 712                     ; 120         0x11,0x22,0x33
 712                     ; 121     };
 714  0125 96            	ldw	x,sp
 715  0126 1c0001        	addw	x,#OFST-18
 716  0129 90ae0008      	ldw	y,#L771_mac
 717  012d a606          	ld	a,#6
 718  012f cd0000        	call	c_xymov
 720                     ; 123     uint8_t ip[4] =
 720                     ; 124     {
 720                     ; 125         192,168,100,52
 720                     ; 126     };
 722  0132 96            	ldw	x,sp
 723  0133 1c0007        	addw	x,#OFST-12
 724  0136 90ae000e      	ldw	y,#L102_ip
 725  013a a604          	ld	a,#4
 726  013c cd0000        	call	c_xymov
 728                     ; 128     uint8_t sn[4] =
 728                     ; 129     {
 728                     ; 130         255,255,255,0
 728                     ; 131     };
 730  013f 96            	ldw	x,sp
 731  0140 1c000b        	addw	x,#OFST-8
 732  0143 90ae0012      	ldw	y,#L302_sn
 733  0147 a604          	ld	a,#4
 734  0149 cd0000        	call	c_xymov
 736                     ; 133     uint8_t gw[4] =
 736                     ; 134     {
 736                     ; 135         192,168,100,1
 736                     ; 136     };
 738  014c 96            	ldw	x,sp
 739  014d 1c000f        	addw	x,#OFST-4
 740  0150 90ae0016      	ldw	y,#L502_gw
 741  0154 a604          	ld	a,#4
 742  0156 cd0000        	call	c_xymov
 744                     ; 138     W5500_WriteReg(MR,0x80);
 746  0159 4b80          	push	#128
 747  015b 5f            	clrw	x
 748  015c ad82          	call	_W5500_WriteReg
 750  015e 84            	pop	a
 751                     ; 140     for(i=0;i<4;i++)
 753  015f 0f13          	clr	(OFST+0,sp)
 755  0161               L542:
 756                     ; 141         W5500_WriteReg(GAR+i,gw[i]);
 758  0161 96            	ldw	x,sp
 759  0162 1c000f        	addw	x,#OFST-4
 760  0165 9f            	ld	a,xl
 761  0166 5e            	swapw	x
 762  0167 1b13          	add	a,(OFST+0,sp)
 763  0169 2401          	jrnc	L23
 764  016b 5c            	incw	x
 765  016c               L23:
 766  016c 02            	rlwa	x,a
 767  016d f6            	ld	a,(x)
 768  016e 88            	push	a
 769  016f 7b14          	ld	a,(OFST+1,sp)
 770  0171 5f            	clrw	x
 771  0172 97            	ld	xl,a
 772  0173 5c            	incw	x
 773  0174 cd00e0        	call	_W5500_WriteReg
 775  0177 84            	pop	a
 776                     ; 140     for(i=0;i<4;i++)
 778  0178 0c13          	inc	(OFST+0,sp)
 782  017a 7b13          	ld	a,(OFST+0,sp)
 783  017c a104          	cp	a,#4
 784  017e 25e1          	jrult	L542
 785                     ; 143     for(i=0;i<4;i++)
 787  0180 0f13          	clr	(OFST+0,sp)
 789  0182               L352:
 790                     ; 144         W5500_WriteReg(SUBR+i,sn[i]);
 792  0182 96            	ldw	x,sp
 793  0183 1c000b        	addw	x,#OFST-8
 794  0186 9f            	ld	a,xl
 795  0187 5e            	swapw	x
 796  0188 1b13          	add	a,(OFST+0,sp)
 797  018a 2401          	jrnc	L43
 798  018c 5c            	incw	x
 799  018d               L43:
 800  018d 02            	rlwa	x,a
 801  018e f6            	ld	a,(x)
 802  018f 88            	push	a
 803  0190 7b14          	ld	a,(OFST+1,sp)
 804  0192 5f            	clrw	x
 805  0193 97            	ld	xl,a
 806  0194 1c0005        	addw	x,#5
 807  0197 cd00e0        	call	_W5500_WriteReg
 809  019a 84            	pop	a
 810                     ; 143     for(i=0;i<4;i++)
 812  019b 0c13          	inc	(OFST+0,sp)
 816  019d 7b13          	ld	a,(OFST+0,sp)
 817  019f a104          	cp	a,#4
 818  01a1 25df          	jrult	L352
 819                     ; 146     for(i=0;i<6;i++)
 821  01a3 0f13          	clr	(OFST+0,sp)
 823  01a5               L162:
 824                     ; 147         W5500_WriteReg(SHAR+i,mac[i]);
 826  01a5 96            	ldw	x,sp
 827  01a6 1c0001        	addw	x,#OFST-18
 828  01a9 9f            	ld	a,xl
 829  01aa 5e            	swapw	x
 830  01ab 1b13          	add	a,(OFST+0,sp)
 831  01ad 2401          	jrnc	L63
 832  01af 5c            	incw	x
 833  01b0               L63:
 834  01b0 02            	rlwa	x,a
 835  01b1 f6            	ld	a,(x)
 836  01b2 88            	push	a
 837  01b3 7b14          	ld	a,(OFST+1,sp)
 838  01b5 5f            	clrw	x
 839  01b6 97            	ld	xl,a
 840  01b7 1c0009        	addw	x,#9
 841  01ba cd00e0        	call	_W5500_WriteReg
 843  01bd 84            	pop	a
 844                     ; 146     for(i=0;i<6;i++)
 846  01be 0c13          	inc	(OFST+0,sp)
 850  01c0 7b13          	ld	a,(OFST+0,sp)
 851  01c2 a106          	cp	a,#6
 852  01c4 25df          	jrult	L162
 853                     ; 149     for(i=0;i<4;i++)
 855  01c6 0f13          	clr	(OFST+0,sp)
 857  01c8               L762:
 858                     ; 150         W5500_WriteReg(SIPR+i,ip[i]);
 860  01c8 96            	ldw	x,sp
 861  01c9 1c0007        	addw	x,#OFST-12
 862  01cc 9f            	ld	a,xl
 863  01cd 5e            	swapw	x
 864  01ce 1b13          	add	a,(OFST+0,sp)
 865  01d0 2401          	jrnc	L04
 866  01d2 5c            	incw	x
 867  01d3               L04:
 868  01d3 02            	rlwa	x,a
 869  01d4 f6            	ld	a,(x)
 870  01d5 88            	push	a
 871  01d6 7b14          	ld	a,(OFST+1,sp)
 872  01d8 5f            	clrw	x
 873  01d9 97            	ld	xl,a
 874  01da 1c000f        	addw	x,#15
 875  01dd cd00e0        	call	_W5500_WriteReg
 877  01e0 84            	pop	a
 878                     ; 149     for(i=0;i<4;i++)
 880  01e1 0c13          	inc	(OFST+0,sp)
 884  01e3 7b13          	ld	a,(OFST+0,sp)
 885  01e5 a104          	cp	a,#4
 886  01e7 25df          	jrult	L762
 887                     ; 151 }
 890  01e9 5b13          	addw	sp,#19
 891  01eb 81            	ret
 904                     	xdef	_W5500_SendByte
 905                     	xdef	_W5500_Unselect
 906                     	xdef	_W5500_Select
 907                     	xdef	_W5500_WriteReg
 908                     	xdef	_W5500_ReadReg
 909                     	xdef	_W5500_Init
 910                     	xdef	_W5500_Hardware_Reset
 911                     	xdef	_W5500_SPI_Init
 912                     	xdef	_W5500_GPIO_Init
 913                     	xref	_SPI_GetFlagStatus
 914                     	xref	_SPI_ReceiveData
 915                     	xref	_SPI_SendData
 916                     	xref	_SPI_Cmd
 917                     	xref	_SPI_Init
 918                     	xref	_SPI_DeInit
 919                     	xref	_GPIO_WriteLow
 920                     	xref	_GPIO_WriteHigh
 921                     	xref	_GPIO_Init
 922                     	xref.b	c_x
 941                     	xref	c_xymov
 942                     	xref	c_lcmp
 943                     	xref	c_ltor
 944                     	xref	c_lgadc
 945                     	end
