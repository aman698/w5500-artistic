   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
 126                     ; 23 int command_parser_execute(const char *cmd_str, int len)
 126                     ; 24 {
 128                     	switch	.text
 129  0000               _command_parser_execute:
 131  0000 89            	pushw	x
 132  0001 5246          	subw	sp,#70
 133       00000046      OFST:	set	70
 136                     ; 26     char *cmd = NULL;
 138                     ; 27     char *value_str = NULL;
 140                     ; 29     int relay_num = 0;
 142                     ; 30     int relay_state = 0;
 144                     ; 32     if (len == 0 || len >= 64) return -1;
 146  0003 1e4b          	ldw	x,(OFST+5,sp)
 147  0005 2708          	jreq	L56
 149  0007 9c            	rvf
 150  0008 1e4b          	ldw	x,(OFST+5,sp)
 151  000a a30040        	cpw	x,#64
 152  000d 2f05          	jrslt	L36
 153  000f               L56:
 156  000f aeffff        	ldw	x,#65535
 158  0012 202e          	jra	L6
 159  0014               L36:
 160                     ; 35     strncpy(cmd_copy, cmd_str, len);
 162  0014 1e4b          	ldw	x,(OFST+5,sp)
 163  0016 89            	pushw	x
 164  0017 1e49          	ldw	x,(OFST+3,sp)
 165  0019 89            	pushw	x
 166  001a 96            	ldw	x,sp
 167  001b 1c0007        	addw	x,#OFST-63
 168  001e cd0000        	call	_strncpy
 170  0021 5b04          	addw	sp,#4
 171                     ; 36     cmd_copy[len] = '\0';
 173  0023 96            	ldw	x,sp
 174  0024 1c0003        	addw	x,#OFST-67
 175  0027 1f01          	ldw	(OFST-69,sp),x
 177  0029 1e4b          	ldw	x,(OFST+5,sp)
 178  002b 72fb01        	addw	x,(OFST-69,sp)
 179  002e 7f            	clr	(x)
 180                     ; 39     comma_pos = strchr(cmd_copy, ',');
 182  002f 4b2c          	push	#44
 183  0031 96            	ldw	x,sp
 184  0032 1c0004        	addw	x,#OFST-66
 185  0035 cd0000        	call	_strchr
 187  0038 84            	pop	a
 188  0039 1f45          	ldw	(OFST-1,sp),x
 190                     ; 40     if (!comma_pos) return -1;
 192  003b 1e45          	ldw	x,(OFST-1,sp)
 193  003d 2606          	jrne	L76
 196  003f aeffff        	ldw	x,#65535
 198  0042               L6:
 200  0042 5b48          	addw	sp,#72
 201  0044 81            	ret
 202  0045               L76:
 203                     ; 43     *comma_pos = '\0';
 205  0045 1e45          	ldw	x,(OFST-1,sp)
 206  0047 7f            	clr	(x)
 207                     ; 44     cmd = cmd_copy;
 209  0048 96            	ldw	x,sp
 210  0049 1c0003        	addw	x,#OFST-67
 211  004c 1f43          	ldw	(OFST-3,sp),x
 213                     ; 45     value_str = comma_pos + 1;
 215  004e 1e45          	ldw	x,(OFST-1,sp)
 216  0050 5c            	incw	x
 217  0051 1f45          	ldw	(OFST-1,sp),x
 219                     ; 48     if (cmd[0] == 'R' && cmd[1] >= '1' && cmd[1] <= '6' && cmd[2] == '\0') {
 221  0053 1e43          	ldw	x,(OFST-3,sp)
 222  0055 f6            	ld	a,(x)
 223  0056 a152          	cp	a,#82
 224  0058 2634          	jrne	L17
 226  005a 1e43          	ldw	x,(OFST-3,sp)
 227  005c e601          	ld	a,(1,x)
 228  005e a131          	cp	a,#49
 229  0060 252c          	jrult	L17
 231  0062 1e43          	ldw	x,(OFST-3,sp)
 232  0064 e601          	ld	a,(1,x)
 233  0066 a137          	cp	a,#55
 234  0068 2424          	jruge	L17
 236  006a 1e43          	ldw	x,(OFST-3,sp)
 237  006c 6d02          	tnz	(2,x)
 238  006e 261e          	jrne	L17
 239                     ; 49         relay_num = cmd[1] - '0';
 241  0070 1e43          	ldw	x,(OFST-3,sp)
 242  0072 e601          	ld	a,(1,x)
 243  0074 5f            	clrw	x
 244  0075 97            	ld	xl,a
 245  0076 1d0030        	subw	x,#48
 246  0079 1f43          	ldw	(OFST-3,sp),x
 248                     ; 50         relay_state = atoi(value_str);
 250  007b 1e45          	ldw	x,(OFST-1,sp)
 251  007d cd0000        	call	_atoi
 253  0080 1f45          	ldw	(OFST-1,sp),x
 255                     ; 53         relay_control_set(relay_num, relay_state);
 257  0082 7b46          	ld	a,(OFST+0,sp)
 258  0084 97            	ld	xl,a
 259  0085 7b44          	ld	a,(OFST-2,sp)
 260  0087 95            	ld	xh,a
 261  0088 cd0000        	call	_relay_control_set
 263                     ; 54         return 0;
 265  008b 5f            	clrw	x
 267  008c 20b4          	jra	L6
 268  008e               L17:
 269                     ; 57     return -1;
 271  008e aeffff        	ldw	x,#65535
 273  0091 20af          	jra	L6
 319                     ; 63 int command_parser_is_valid(const char *cmd_str, int len)
 319                     ; 64 {
 320                     	switch	.text
 321  0093               _command_parser_is_valid:
 323  0093 89            	pushw	x
 324       00000000      OFST:	set	0
 327                     ; 65     if (len < 3 || len >= 64) return 0;
 329  0094 9c            	rvf
 330  0095 1e05          	ldw	x,(OFST+5,sp)
 331  0097 a30003        	cpw	x,#3
 332  009a 2f08          	jrslt	L711
 334  009c 9c            	rvf
 335  009d 1e05          	ldw	x,(OFST+5,sp)
 336  009f a30040        	cpw	x,#64
 337  00a2 2f03          	jrslt	L511
 338  00a4               L711:
 341  00a4 5f            	clrw	x
 343  00a5 2027          	jra	L21
 344  00a7               L511:
 345                     ; 67     if (cmd_str[0] == 'R' && cmd_str[1] >= '1' && cmd_str[1] <= '6') {
 347  00a7 1e01          	ldw	x,(OFST+1,sp)
 348  00a9 f6            	ld	a,(x)
 349  00aa a152          	cp	a,#82
 350  00ac 2623          	jrne	L121
 352  00ae 1e01          	ldw	x,(OFST+1,sp)
 353  00b0 e601          	ld	a,(1,x)
 354  00b2 a131          	cp	a,#49
 355  00b4 251b          	jrult	L121
 357  00b6 1e01          	ldw	x,(OFST+1,sp)
 358  00b8 e601          	ld	a,(1,x)
 359  00ba a137          	cp	a,#55
 360  00bc 2413          	jruge	L121
 361                     ; 69         if (strchr(cmd_str, ',') != NULL) {
 363  00be 4b2c          	push	#44
 364  00c0 1e02          	ldw	x,(OFST+2,sp)
 365  00c2 cd0000        	call	_strchr
 367  00c5 84            	pop	a
 368  00c6 a30000        	cpw	x,#0
 369  00c9 2706          	jreq	L121
 370                     ; 70             return 1;
 372  00cb ae0001        	ldw	x,#1
 374  00ce               L21:
 376  00ce 5b02          	addw	sp,#2
 377  00d0 81            	ret
 378  00d1               L121:
 379                     ; 74     return 0;
 381  00d1 5f            	clrw	x
 383  00d2 20fa          	jra	L21
 396                     	xref	_atoi
 397                     	xref	_strncpy
 398                     	xref	_strchr
 399                     	xref	_relay_control_set
 400                     	xdef	_command_parser_is_valid
 401                     	xdef	_command_parser_execute
 420                     	end
