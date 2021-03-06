;PIC AD转换最简测压0-5V程序


;此程序是最简单的 AD转换 演示例程 
;转换结果从C口输出 非常直观 
;转换的值ADRESH在0V是0发光管全灭， 5V时全亮 
;==============================================

include <p16f73.inc> 

ORG 0X00
NOP
START 
BCF STATUS,RP0
CLRF PORTC
MOVLW B'01000001' ;D7 D6=01 AD转换时钟频率= FOSC/8
MOVWF ADCON0 ;D5 D4 D3=000 AD转换模拟通道选择RA0/AN0
;D2=0 AD已完成或未进行AD D0=0关闭ADC
BSF STATUS,RP0 
MOVLW B'10000111' ;D7=1取消上拉，D6=0 INT下降沿触发，
MOVWF OPTION_REG ;D5=0 TOCK1使用内部时钟 D4=0 TOCK1 上升沿增量
;D3=0用于TMR0 D2 D1 D0=1 TMR0 1：256分频
CLRF TRISC
MOVLW B'00001110' ;D3 D2 D1 D0 1110选择RA0为模拟口。
MOVWF ADCON1 ;D7=0左对齐 ADRESL的低六位读作0
BCF STATUS,RP0
MAIN
BTFSS INTCON,T0IF ;等待TMR0 定时溢出中断
GOTO MAIN 
BCF INTCON,T0IF ;清TMR0 定时溢出标志
BSF ADCON0,GO ;开启A/D
WAIT
BTFSS PIR1,ADIF ;等待A/D完成
GOTO WAIT
MOVF ADRES,W ;A/D值从PORTC口输出显示
MOVWF PORTC
GOTO MAIN
END
