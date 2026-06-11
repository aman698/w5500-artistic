   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  45                     ; 15 void hal_gpio_init(void)
  45                     ; 16 {
  47                     	switch	.text
  48  0000               _hal_gpio_init:
  52                     ; 20     GPIO_Init(DI1_PORT, DI1_PIN, GPIO_MODE_IN_PU_NO_IT);
  54  0000 4b40          	push	#64
  55  0002 4b01          	push	#1
  56  0004 ae5005        	ldw	x,#20485
  57  0007 cd0000        	call	_GPIO_Init
  59  000a 85            	popw	x
  60                     ; 21     GPIO_Init(DI2_PORT, DI2_PIN, GPIO_MODE_IN_PU_NO_IT);
  62  000b 4b40          	push	#64
  63  000d 4b02          	push	#2
  64  000f ae5005        	ldw	x,#20485
  65  0012 cd0000        	call	_GPIO_Init
  67  0015 85            	popw	x
  68                     ; 22     GPIO_Init(DI3_PORT, DI3_PIN, GPIO_MODE_IN_PU_NO_IT);
  70  0016 4b40          	push	#64
  71  0018 4b04          	push	#4
  72  001a ae5005        	ldw	x,#20485
  73  001d cd0000        	call	_GPIO_Init
  75  0020 85            	popw	x
  76                     ; 23     GPIO_Init(DI4_PORT, DI4_PIN, GPIO_MODE_IN_PU_NO_IT);
  78  0021 4b40          	push	#64
  79  0023 4b08          	push	#8
  80  0025 ae5005        	ldw	x,#20485
  81  0028 cd0000        	call	_GPIO_Init
  83  002b 85            	popw	x
  84                     ; 26     GPIO_Init(RELAY1_PORT, RELAY1_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  86  002c 4bf0          	push	#240
  87  002e 4b02          	push	#2
  88  0030 ae500a        	ldw	x,#20490
  89  0033 cd0000        	call	_GPIO_Init
  91  0036 85            	popw	x
  92                     ; 27     GPIO_Init(RELAY2_PORT, RELAY2_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  94  0037 4bf0          	push	#240
  95  0039 4b04          	push	#4
  96  003b ae500a        	ldw	x,#20490
  97  003e cd0000        	call	_GPIO_Init
  99  0041 85            	popw	x
 100                     ; 28     GPIO_Init(RELAY3_PORT, RELAY3_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 102  0042 4bf0          	push	#240
 103  0044 4b08          	push	#8
 104  0046 ae500a        	ldw	x,#20490
 105  0049 cd0000        	call	_GPIO_Init
 107  004c 85            	popw	x
 108                     ; 29     GPIO_Init(RELAY4_PORT, RELAY4_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 110  004d 4bf0          	push	#240
 111  004f 4b10          	push	#16
 112  0051 ae500a        	ldw	x,#20490
 113  0054 cd0000        	call	_GPIO_Init
 115  0057 85            	popw	x
 116                     ; 30     GPIO_Init(RELAY5_PORT, RELAY5_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 118  0058 4bf0          	push	#240
 119  005a 4b01          	push	#1
 120  005c ae500f        	ldw	x,#20495
 121  005f cd0000        	call	_GPIO_Init
 123  0062 85            	popw	x
 124                     ; 31     GPIO_Init(RELAY6_PORT, RELAY6_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 126  0063 4bf0          	push	#240
 127  0065 4b02          	push	#2
 128  0067 ae500f        	ldw	x,#20495
 129  006a cd0000        	call	_GPIO_Init
 131  006d 85            	popw	x
 132                     ; 34     hal_relay_set(1, 1);
 134  006e ae0101        	ldw	x,#257
 135  0071 ad33          	call	_hal_relay_set
 137                     ; 35     hal_relay_set(2, 1);
 139  0073 ae0201        	ldw	x,#513
 140  0076 ad2e          	call	_hal_relay_set
 142                     ; 36     hal_relay_set(3, 1);
 144  0078 ae0301        	ldw	x,#769
 145  007b ad29          	call	_hal_relay_set
 147                     ; 37     hal_relay_set(4, 1);
 149  007d ae0401        	ldw	x,#1025
 150  0080 ad24          	call	_hal_relay_set
 152                     ; 38     hal_relay_set(5, 1);
 154  0082 ae0501        	ldw	x,#1281
 155  0085 ad1f          	call	_hal_relay_set
 157                     ; 39     hal_relay_set(6, 1);
 159  0087 ae0601        	ldw	x,#1537
 160  008a ad1a          	call	_hal_relay_set
 162                     ; 42     GPIO_Init(HARDRST_PORT, HARDRST_PIN, GPIO_MODE_IN_PU_NO_IT);
 164  008c 4b40          	push	#64
 165  008e 4b04          	push	#4
 166  0090 ae500f        	ldw	x,#20495
 167  0093 cd0000        	call	_GPIO_Init
 169  0096 85            	popw	x
 170                     ; 45     GPIO_Init(W5500_RST_PORT, W5500_RST_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 172  0097 4bf0          	push	#240
 173  0099 4b20          	push	#32
 174  009b ae5014        	ldw	x,#20500
 175  009e cd0000        	call	_GPIO_Init
 177  00a1 85            	popw	x
 178                     ; 46     hal_w5500_reset_high();
 180  00a2 cd0218        	call	_hal_w5500_reset_high
 182                     ; 47 }
 185  00a5 81            	ret
 417                     ; 53 void hal_relay_set(uint8_t relay_num, uint8_t state)
 417                     ; 54 {
 418                     	switch	.text
 419  00a6               _hal_relay_set:
 421  00a6 89            	pushw	x
 422  00a7 5204          	subw	sp,#4
 423       00000004      OFST:	set	4
 426                     ; 57     BitStatus bit_state = (state == 0) ? SET : RESET;
 428  00a9 9f            	ld	a,xl
 429  00aa 4d            	tnz	a
 430  00ab 2605          	jrne	L01
 431  00ad ae0001        	ldw	x,#1
 432  00b0 2001          	jra	L21
 433  00b2               L01:
 434  00b2 5f            	clrw	x
 435  00b3               L21:
 436  00b3 01            	rrwa	x,a
 437  00b4 6b01          	ld	(OFST-3,sp),a
 438  00b6 02            	rlwa	x,a
 440                     ; 59     switch (relay_num) {
 442  00b7 7b05          	ld	a,(OFST+1,sp)
 444                     ; 66         default: return;
 445  00b9 4a            	dec	a
 446  00ba 2711          	jreq	L12
 447  00bc 4a            	dec	a
 448  00bd 2719          	jreq	L32
 449  00bf 4a            	dec	a
 450  00c0 2721          	jreq	L52
 451  00c2 4a            	dec	a
 452  00c3 2729          	jreq	L72
 453  00c5 4a            	dec	a
 454  00c6 2731          	jreq	L13
 455  00c8 4a            	dec	a
 456  00c9 2739          	jreq	L33
 457  00cb               L53:
 460  00cb 205a          	jra	L41
 461  00cd               L12:
 462                     ; 60         case 1: port = RELAY1_PORT; pin = RELAY1_PIN; break;
 464  00cd ae500a        	ldw	x,#20490
 465  00d0 1f02          	ldw	(OFST-2,sp),x
 469  00d2 a602          	ld	a,#2
 470  00d4 6b04          	ld	(OFST+0,sp),a
 474  00d6 2035          	jra	L371
 475  00d8               L32:
 476                     ; 61         case 2: port = RELAY2_PORT; pin = RELAY2_PIN; break;
 478  00d8 ae500a        	ldw	x,#20490
 479  00db 1f02          	ldw	(OFST-2,sp),x
 483  00dd a604          	ld	a,#4
 484  00df 6b04          	ld	(OFST+0,sp),a
 488  00e1 202a          	jra	L371
 489  00e3               L52:
 490                     ; 62         case 3: port = RELAY3_PORT; pin = RELAY3_PIN; break;
 492  00e3 ae500a        	ldw	x,#20490
 493  00e6 1f02          	ldw	(OFST-2,sp),x
 497  00e8 a608          	ld	a,#8
 498  00ea 6b04          	ld	(OFST+0,sp),a
 502  00ec 201f          	jra	L371
 503  00ee               L72:
 504                     ; 63         case 4: port = RELAY4_PORT; pin = RELAY4_PIN; break;
 506  00ee ae500a        	ldw	x,#20490
 507  00f1 1f02          	ldw	(OFST-2,sp),x
 511  00f3 a610          	ld	a,#16
 512  00f5 6b04          	ld	(OFST+0,sp),a
 516  00f7 2014          	jra	L371
 517  00f9               L13:
 518                     ; 64         case 5: port = RELAY5_PORT; pin = RELAY5_PIN; break;
 520  00f9 ae500f        	ldw	x,#20495
 521  00fc 1f02          	ldw	(OFST-2,sp),x
 525  00fe a601          	ld	a,#1
 526  0100 6b04          	ld	(OFST+0,sp),a
 530  0102 2009          	jra	L371
 531  0104               L33:
 532                     ; 65         case 6: port = RELAY6_PORT; pin = RELAY6_PIN; break;
 534  0104 ae500f        	ldw	x,#20495
 535  0107 1f02          	ldw	(OFST-2,sp),x
 539  0109 a602          	ld	a,#2
 540  010b 6b04          	ld	(OFST+0,sp),a
 544  010d               L371:
 545                     ; 69     if (bit_state == SET) {
 547  010d 7b01          	ld	a,(OFST-3,sp)
 548  010f a101          	cp	a,#1
 549  0111 260b          	jrne	L571
 550                     ; 70         GPIO_WriteHigh(port, pin);  /* Set HIGH = relay off */
 552  0113 7b04          	ld	a,(OFST+0,sp)
 553  0115 88            	push	a
 554  0116 1e03          	ldw	x,(OFST-1,sp)
 555  0118 cd0000        	call	_GPIO_WriteHigh
 557  011b 84            	pop	a
 559  011c 2009          	jra	L771
 560  011e               L571:
 561                     ; 72         GPIO_WriteLow(port, pin); /* Set LOW = relay on */
 563  011e 7b04          	ld	a,(OFST+0,sp)
 564  0120 88            	push	a
 565  0121 1e03          	ldw	x,(OFST-1,sp)
 566  0123 cd0000        	call	_GPIO_WriteLow
 568  0126 84            	pop	a
 569  0127               L771:
 570                     ; 74 }
 571  0127               L41:
 574  0127 5b06          	addw	sp,#6
 575  0129 81            	ret
 642                     ; 79 uint8_t hal_relay_get(uint8_t relay_num)
 642                     ; 80 {
 643                     	switch	.text
 644  012a               _hal_relay_get:
 646  012a 5203          	subw	sp,#3
 647       00000003      OFST:	set	3
 650                     ; 85     switch (relay_num) {
 653                     ; 92         default: return 0;
 654  012c 4a            	dec	a
 655  012d 2712          	jreq	L102
 656  012f 4a            	dec	a
 657  0130 271a          	jreq	L302
 658  0132 4a            	dec	a
 659  0133 2722          	jreq	L502
 660  0135 4a            	dec	a
 661  0136 272a          	jreq	L702
 662  0138 4a            	dec	a
 663  0139 2732          	jreq	L112
 664  013b 4a            	dec	a
 665  013c 273a          	jreq	L312
 666  013e               L512:
 669  013e 4f            	clr	a
 671  013f 2055          	jra	L42
 672  0141               L102:
 673                     ; 86         case 1: port = RELAY1_PORT; pin = RELAY1_PIN; break;
 675  0141 ae500a        	ldw	x,#20490
 676  0144 1f01          	ldw	(OFST-2,sp),x
 680  0146 a602          	ld	a,#2
 681  0148 6b03          	ld	(OFST+0,sp),a
 685  014a 2035          	jra	L552
 686  014c               L302:
 687                     ; 87         case 2: port = RELAY2_PORT; pin = RELAY2_PIN; break;
 689  014c ae500a        	ldw	x,#20490
 690  014f 1f01          	ldw	(OFST-2,sp),x
 694  0151 a604          	ld	a,#4
 695  0153 6b03          	ld	(OFST+0,sp),a
 699  0155 202a          	jra	L552
 700  0157               L502:
 701                     ; 88         case 3: port = RELAY3_PORT; pin = RELAY3_PIN; break;
 703  0157 ae500a        	ldw	x,#20490
 704  015a 1f01          	ldw	(OFST-2,sp),x
 708  015c a608          	ld	a,#8
 709  015e 6b03          	ld	(OFST+0,sp),a
 713  0160 201f          	jra	L552
 714  0162               L702:
 715                     ; 89         case 4: port = RELAY4_PORT; pin = RELAY4_PIN; break;
 717  0162 ae500a        	ldw	x,#20490
 718  0165 1f01          	ldw	(OFST-2,sp),x
 722  0167 a610          	ld	a,#16
 723  0169 6b03          	ld	(OFST+0,sp),a
 727  016b 2014          	jra	L552
 728  016d               L112:
 729                     ; 90         case 5: port = RELAY5_PORT; pin = RELAY5_PIN; break;
 731  016d ae500f        	ldw	x,#20495
 732  0170 1f01          	ldw	(OFST-2,sp),x
 736  0172 a601          	ld	a,#1
 737  0174 6b03          	ld	(OFST+0,sp),a
 741  0176 2009          	jra	L552
 742  0178               L312:
 743                     ; 91         case 6: port = RELAY6_PORT; pin = RELAY6_PIN; break;
 745  0178 ae500f        	ldw	x,#20495
 746  017b 1f01          	ldw	(OFST-2,sp),x
 750  017d a602          	ld	a,#2
 751  017f 6b03          	ld	(OFST+0,sp),a
 755  0181               L552:
 756                     ; 95     bit_state = GPIO_ReadInputPin(port, pin);
 758  0181 7b03          	ld	a,(OFST+0,sp)
 759  0183 88            	push	a
 760  0184 1e02          	ldw	x,(OFST-1,sp)
 761  0186 cd0000        	call	_GPIO_ReadInputPin
 763  0189 5b01          	addw	sp,#1
 764  018b 6b03          	ld	(OFST+0,sp),a
 766                     ; 97     return (bit_state == RESET) ? 1 : 0;
 768  018d 0d03          	tnz	(OFST+0,sp)
 769  018f 2604          	jrne	L02
 770  0191 a601          	ld	a,#1
 771  0193 2001          	jra	L22
 772  0195               L02:
 773  0195 4f            	clr	a
 774  0196               L22:
 776  0196               L42:
 778  0196 5b03          	addw	sp,#3
 779  0198 81            	ret
 836                     ; 103 uint8_t hal_di_read(uint8_t di_num)
 836                     ; 104 {
 837                     	switch	.text
 838  0199               _hal_di_read:
 840  0199 5203          	subw	sp,#3
 841       00000003      OFST:	set	3
 844                     ; 108     switch (di_num) {
 847                     ; 113         default: return 0;
 848  019b 4a            	dec	a
 849  019c 270c          	jreq	L752
 850  019e 4a            	dec	a
 851  019f 2714          	jreq	L162
 852  01a1 4a            	dec	a
 853  01a2 271c          	jreq	L362
 854  01a4 4a            	dec	a
 855  01a5 2724          	jreq	L562
 856  01a7               L762:
 859  01a7 4f            	clr	a
 861  01a8 203d          	jra	L43
 862  01aa               L752:
 863                     ; 109         case 1: port = DI1_PORT; pin = DI1_PIN; break;
 865  01aa ae5005        	ldw	x,#20485
 866  01ad 1f01          	ldw	(OFST-2,sp),x
 870  01af a601          	ld	a,#1
 871  01b1 6b03          	ld	(OFST+0,sp),a
 875  01b3 201f          	jra	L323
 876  01b5               L162:
 877                     ; 110         case 2: port = DI2_PORT; pin = DI2_PIN; break;
 879  01b5 ae5005        	ldw	x,#20485
 880  01b8 1f01          	ldw	(OFST-2,sp),x
 884  01ba a602          	ld	a,#2
 885  01bc 6b03          	ld	(OFST+0,sp),a
 889  01be 2014          	jra	L323
 890  01c0               L362:
 891                     ; 111         case 3: port = DI3_PORT; pin = DI3_PIN; break;
 893  01c0 ae5005        	ldw	x,#20485
 894  01c3 1f01          	ldw	(OFST-2,sp),x
 898  01c5 a604          	ld	a,#4
 899  01c7 6b03          	ld	(OFST+0,sp),a
 903  01c9 2009          	jra	L323
 904  01cb               L562:
 905                     ; 112         case 4: port = DI4_PORT; pin = DI4_PIN; break;
 907  01cb ae5005        	ldw	x,#20485
 908  01ce 1f01          	ldw	(OFST-2,sp),x
 912  01d0 a608          	ld	a,#8
 913  01d2 6b03          	ld	(OFST+0,sp),a
 917  01d4               L323:
 918                     ; 116     return (GPIO_ReadInputPin(port, pin) == SET) ? 1 : 0;
 920  01d4 7b03          	ld	a,(OFST+0,sp)
 921  01d6 88            	push	a
 922  01d7 1e02          	ldw	x,(OFST-1,sp)
 923  01d9 cd0000        	call	_GPIO_ReadInputPin
 925  01dc 5b01          	addw	sp,#1
 926  01de a101          	cp	a,#1
 927  01e0 2604          	jrne	L03
 928  01e2 a601          	ld	a,#1
 929  01e4 2001          	jra	L23
 930  01e6               L03:
 931  01e6 4f            	clr	a
 932  01e7               L23:
 934  01e7               L43:
 936  01e7 5b03          	addw	sp,#3
 937  01e9 81            	ret
 972                     ; 122 uint8_t hal_di_read_all(void)
 972                     ; 123 {
 973                     	switch	.text
 974  01ea               _hal_di_read_all:
 976  01ea 88            	push	a
 977       00000001      OFST:	set	1
 980                     ; 124     uint8_t result = 0;
 982  01eb 0f01          	clr	(OFST+0,sp)
 984                     ; 125     result |= (hal_di_read(1) << 0);
 986  01ed a601          	ld	a,#1
 987  01ef ada8          	call	_hal_di_read
 989  01f1 1a01          	or	a,(OFST+0,sp)
 990  01f3 6b01          	ld	(OFST+0,sp),a
 992                     ; 126     result |= (hal_di_read(2) << 1);
 994  01f5 a602          	ld	a,#2
 995  01f7 ada0          	call	_hal_di_read
 997  01f9 48            	sll	a
 998  01fa 1a01          	or	a,(OFST+0,sp)
 999  01fc 6b01          	ld	(OFST+0,sp),a
1001                     ; 127     result |= (hal_di_read(3) << 2);
1003  01fe a603          	ld	a,#3
1004  0200 ad97          	call	_hal_di_read
1006  0202 48            	sll	a
1007  0203 48            	sll	a
1008  0204 1a01          	or	a,(OFST+0,sp)
1009  0206 6b01          	ld	(OFST+0,sp),a
1011                     ; 128     result |= (hal_di_read(4) << 3);
1013  0208 a604          	ld	a,#4
1014  020a ad8d          	call	_hal_di_read
1016  020c 48            	sll	a
1017  020d 48            	sll	a
1018  020e 48            	sll	a
1019  020f 1a01          	or	a,(OFST+0,sp)
1020  0211 6b01          	ld	(OFST+0,sp),a
1022                     ; 129     return result;
1024  0213 7b01          	ld	a,(OFST+0,sp)
1027  0215 5b01          	addw	sp,#1
1028  0217 81            	ret
1053                     ; 135 void hal_w5500_reset_high(void)
1053                     ; 136 {
1054                     	switch	.text
1055  0218               _hal_w5500_reset_high:
1059                     ; 137     GPIO_WriteHigh(W5500_RST_PORT, W5500_RST_PIN);
1061  0218 4b20          	push	#32
1062  021a ae5014        	ldw	x,#20500
1063  021d cd0000        	call	_GPIO_WriteHigh
1065  0220 84            	pop	a
1066                     ; 138 }
1069  0221 81            	ret
1094                     ; 143 void hal_w5500_reset_low(void)
1094                     ; 144 {
1095                     	switch	.text
1096  0222               _hal_w5500_reset_low:
1100                     ; 145     GPIO_WriteLow(W5500_RST_PORT, W5500_RST_PIN);
1102  0222 4b20          	push	#32
1103  0224 ae5014        	ldw	x,#20500
1104  0227 cd0000        	call	_GPIO_WriteLow
1106  022a 84            	pop	a
1107                     ; 146 }
1110  022b 81            	ret
1134                     ; 151 uint8_t hal_hardrst_read(void)
1134                     ; 152 {
1135                     	switch	.text
1136  022c               _hal_hardrst_read:
1140                     ; 153     return (GPIO_ReadInputPin(HARDRST_PORT, HARDRST_PIN) == SET) ? 1 : 0;
1142  022c 4b04          	push	#4
1143  022e ae500f        	ldw	x,#20495
1144  0231 cd0000        	call	_GPIO_ReadInputPin
1146  0234 5b01          	addw	sp,#1
1147  0236 a101          	cp	a,#1
1148  0238 2604          	jrne	L64
1149  023a a601          	ld	a,#1
1150  023c 2001          	jra	L05
1151  023e               L64:
1152  023e 4f            	clr	a
1153  023f               L05:
1156  023f 81            	ret
1169                     	xdef	_hal_hardrst_read
1170                     	xdef	_hal_w5500_reset_low
1171                     	xdef	_hal_w5500_reset_high
1172                     	xdef	_hal_di_read_all
1173                     	xdef	_hal_di_read
1174                     	xdef	_hal_relay_get
1175                     	xdef	_hal_relay_set
1176                     	xdef	_hal_gpio_init
1177                     	xref	_GPIO_ReadInputPin
1178                     	xref	_GPIO_WriteLow
1179                     	xref	_GPIO_WriteHigh
1180                     	xref	_GPIO_Init
1199                     	end
