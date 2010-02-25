	LIST	P=16F818
	INCLUDE	P16F818.INC

Main_Status		EQU	0x10		;B7:电源状态;B6:喇叭继电器;B5:音量升降标志;B4:音量直调标志
Key_Record		EQU	0x1D		;按键结果数据
Key_AD_Count	EQU	0x1E		;按键扫描次数统计
Delay_3s_Cnt	EQU	0x1F		;3秒延时计数器
Delay_Cnt0	EQU	0x20			;延时计数器0
Delay_Cnt1	EQU	0x21			;延时计数器1
LED_OutCnt	EQU	0x22			;数码管输出段码计数
LED_HalfDat	EQU	0x23			;半字节待输出数据
LED_CS		EQU 0x24			;数码管片选
LED_DataH	EQU 0x25			;数码管显示数据高位
LED_DataL	EQU 0x26			;数码管显示数据低位
LED_Data	EQU 0x27			;待显示的数码管输入数据
Volume_Data	EQU 0x28			;M62649待输出音量值
Volume_Cnt	EQU 0x29			;M62649待输出位统计

;初始化
	ORG	0x00
	BSF		STATUS,RP0
	MOVLW	B'00001111'			;x'x'x'电源电压‘功放中点’
	MOVWF	TRISA
	MOVLW	B'00000000'
	MOVWF	TRISB
	BCF		STATUS,RP0
	CLRF	PORTA
	CLRF	PORTB
    BSF		INTCON,T0IE
    BSF		INTCON,GIE

T0_OVFL_WAIT
	BTFSS	INTCON,T0IF
	GOTO	T0_OVFL_WAIT

	END