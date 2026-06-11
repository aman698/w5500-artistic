   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  14                     	bsct
  15  0000               L3_systick_ms:
  16  0000 00000000      	dc.l	0
  17  0004               L5_user_callback:
  18  0004 0000          	dc.w	0
  49                     ; 15 void tim4_tick(void)
  49                     ; 16 {
  51                     	switch	.text
  52  0000               _tim4_tick:
  56                     ; 17     systick_ms += TIMER_TICK_MS;
  58  0000 ae0000        	ldw	x,#L3_systick_ms
  59  0003 a60a          	ld	a,#10
  60  0005 cd0000        	call	c_lgadc
  62                     ; 18     if (user_callback) {
  64  0008 be04          	ldw	x,L5_user_callback
  65  000a 2703          	jreq	L52
  66                     ; 19         user_callback();
  68  000c 92cd04        	call	[L5_user_callback.w]
  70  000f               L52:
  71                     ; 21 }
  74  000f 81            	ret
 102                     ; 39 void hal_timer_init(void)
 102                     ; 40 {
 103                     	switch	.text
 104  0010               _hal_timer_init:
 108                     ; 42     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 110  0010 ae0401        	ldw	x,#1025
 111  0013 cd0000        	call	_CLK_PeripheralClockConfig
 113                     ; 49     TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125);
 115  0016 ae077d        	ldw	x,#1917
 116  0019 cd0000        	call	_TIM4_TimeBaseInit
 118                     ; 52     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 120  001c a601          	ld	a,#1
 121  001e cd0000        	call	_TIM4_ClearFlag
 123                     ; 55     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 125  0021 ae0101        	ldw	x,#257
 126  0024 cd0000        	call	_TIM4_ITConfig
 128                     ; 58     enableInterrupts();
 131  0027 9a            rim
 133                     ; 59 }
 137  0028 81            	ret
 161                     ; 64 void hal_timer_start(void)
 161                     ; 65 {
 162                     	switch	.text
 163  0029               _hal_timer_start:
 167                     ; 66     TIM4_Cmd(ENABLE);
 169  0029 a601          	ld	a,#1
 170  002b cd0000        	call	_TIM4_Cmd
 172                     ; 67 }
 175  002e 81            	ret
 199                     ; 72 void hal_timer_stop(void)
 199                     ; 73 {
 200                     	switch	.text
 201  002f               _hal_timer_stop:
 205                     ; 74     TIM4_Cmd(DISABLE);
 207  002f 4f            	clr	a
 208  0030 cd0000        	call	_TIM4_Cmd
 210                     ; 75 }
 213  0033 81            	ret
 237                     ; 80 unsigned long hal_get_millis(void)
 237                     ; 81 {
 238                     	switch	.text
 239  0034               _hal_get_millis:
 243                     ; 82     return systick_ms;
 245  0034 ae0000        	ldw	x,#L3_systick_ms
 246  0037 cd0000        	call	c_ltor
 250  003a 81            	ret
 294                     ; 88 void hal_delay_ms(unsigned int ms)
 294                     ; 89 {
 295                     	switch	.text
 296  003b               _hal_delay_ms:
 298  003b 89            	pushw	x
 299  003c 5208          	subw	sp,#8
 300       00000008      OFST:	set	8
 303                     ; 90     unsigned long start = hal_get_millis();
 305  003e adf4          	call	_hal_get_millis
 307  0040 96            	ldw	x,sp
 308  0041 1c0005        	addw	x,#OFST-3
 309  0044 cd0000        	call	c_rtol
 313  0047               L511:
 314                     ; 91     while ((hal_get_millis() - start) < ms);
 316  0047 adeb          	call	_hal_get_millis
 318  0049 96            	ldw	x,sp
 319  004a 1c0005        	addw	x,#OFST-3
 320  004d cd0000        	call	c_lsub
 322  0050 96            	ldw	x,sp
 323  0051 1c0001        	addw	x,#OFST-7
 324  0054 cd0000        	call	c_rtol
 327  0057 1e09          	ldw	x,(OFST+1,sp)
 328  0059 cd0000        	call	c_uitolx
 330  005c 96            	ldw	x,sp
 331  005d 1c0001        	addw	x,#OFST-7
 332  0060 cd0000        	call	c_lcmp
 334  0063 22e2          	jrugt	L511
 335                     ; 92 }
 338  0065 5b0a          	addw	sp,#10
 339  0067 81            	ret
 377                     ; 97 void hal_timer_set_callback(timer_callback_t callback)
 377                     ; 98 {
 378                     	switch	.text
 379  0068               _hal_timer_set_callback:
 383                     ; 99     user_callback = callback;
 385  0068 bf04          	ldw	L5_user_callback,x
 386                     ; 100 }
 389  006a 81            	ret
 424                     	xdef	_tim4_tick
 425                     	xdef	_hal_timer_set_callback
 426                     	xdef	_hal_delay_ms
 427                     	xdef	_hal_get_millis
 428                     	xdef	_hal_timer_stop
 429                     	xdef	_hal_timer_start
 430                     	xdef	_hal_timer_init
 431                     	xref	_TIM4_ClearFlag
 432                     	xref	_TIM4_ITConfig
 433                     	xref	_TIM4_Cmd
 434                     	xref	_TIM4_TimeBaseInit
 435                     	xref	_CLK_PeripheralClockConfig
 454                     	xref	c_lcmp
 455                     	xref	c_lsub
 456                     	xref	c_uitolx
 457                     	xref	c_rtol
 458                     	xref	c_ltor
 459                     	xref	c_lgadc
 460                     	end
