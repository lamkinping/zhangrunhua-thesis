	LIST	P=16F716
	INCLUDE	P16F716.INC
	ORG	0x00
	NOP
;初始化
	ORG	0x00
	BSF		STATUS,RP0
	MOVLW	B'00001111'
	MOVWF	TRISA
	MOVLW	B'00000000'
	MOVWF	TRISB
	BCF		STATUS,RP0
	CLRF	PORTA
	CLRF	PORTB
;----------------------------------------------------------
;函数名称：Read_Now_Vol
;功能描述：读当前音量到VOL_NOW。
;----------------------------------------------------------
Read_Now_Vol
;写AD转换控制字
	BSF		STATUS,RP0			;体1
	MOVLW	B'00001110'			;D3 D2 D1 D0 1110选择RA0为模拟口。
	MOVWF	ADCON1				;D7=0左对齐 ADRESL的低六位读作0
	BCF		STATUS,RP0			;体0
	MOVLW	B'01000001'			;D7 D6=01 AD转换时钟频率= FOSC/8
	MOVWF	ADCON0				;D5 D4 D3=000 AD转换模拟通道选择RA0/AN0
	BSF		ADCON0,2			;开启A/D
WAIT
	BTFSS	PIR1,6				;等待A/D完成
	GOTO	WAIT
	MOVF	ADRES,W				;A/D值从PORTB口输出显示
	MOVWF	Volume_Now			;音量值到Volume_Now
	RETURN
	END