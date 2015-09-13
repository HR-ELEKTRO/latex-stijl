;	ledcopy.asm  -  Simply copies switches to LEDs
;
;	Author:		<your name>
;	Date:		<date>
;	AVR type:	ATmega32
;	Target:		STK 500 (AVR development board)

.include "m32def.inc"

		LDI		R16,0x00 
		OUT		DDRA,R16		; configure Port A as 8 inputs
		LDI		R16,0xFF
		OUT		DDRB,R16		; configure Port B as 8 outputs

LOOP:	IN		R0,PINA			; read Port A (switches)
		OUT		PORTB,R0		; output to Port B (leds)
		RJMP	LOOP			; and again