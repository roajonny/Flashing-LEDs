

;0xFF00 puts 1 at pins 8-15 (turns off - negative logic)
;0x0	puts 0 at pins 8-15 (turns on)
;5500	alternates the lights
lights_on	EQU			0x5500			;put value of whatever lights to turn on
;IO0PIN		EQU			0xE0028000
output_on	EQU			0xFF00
;IO0DIR		EQU			0xE0028008
PINSEL0		EQU			0xE002C000
;IO0SET		EQU			0xE0028004
;IO0CLR		EQU			0xE002800C

;------------------------------------
;USING A BASE AND OFFSETS TO ACCESS THE CONTROL REGISTERS
IO0_BASE	EQU			0xE0028000
IO0PIN		EQU			0
IO0DIR		EQU			0x8
IO0SET		EQU			0x4
IO0CLR		EQU			0xC
;can use pre-index addressing with these

			GLOBAL		Reset_Handler
			AREA		Reset_Handler, CODE, READONLY
ResetHandler
			MOV r0, #0
			LDR r1, =PINSEL0
			STR r0, [r1] ;register is shotgunned 
			; makes pins 8-15 to be GPIO
			
			;-----------------------------
			
			MOV	r2, #output_on
			LDR r3, =IO0_BASE
			STR	r2, [r3, #IO0DIR] ;makes pins 8-15 outputs using pre-index addressing
			
			;-----------------------------------------------------------------------
			;test code to turn on 8 & 9
			;LEDs turn on when 0 is applied to output
			;MOV r4, #lights_on
			;LDR r5, =IO0PIN					;PREVIOUS METHOD TO SET PINS
			;STR r4, [r5]
			;-----------------------------------------------------------------------
			
			;write a delay
			;one delay for when the LEDs are on
			;another delay for when they are off
			;have each loop branch to the other loop
			
turn_on		LDR r5, =0x00000005 ;delay
			LDR	r0, =0x0	;change this to clear corresponding bit in IO0PIN
			STR	r0, [r3, #IO0PIN] ;turns on LEDs
			
			;r0 is not getting stored properly to IO0CLR address**********************************************
on_delay	CMP 	r5, #0		
			NOP
			SUBGT	r5,	r5, #1
			BGT		on_delay
			
turn_off	LDR r5, =0x000000005
			LDR	r0, =0xFF00	;change this to set corresponding bit in IO0PIN
			STR	r0, [r3, #IO0SET] ;turns off_ LEDs

off_delay	CMP 	r5, #0		;LED_OFF Delay
			NOP
			SUBGT	r5,	r5, #1
			BGT		off_delay
			B		turn_on		
stop		B		stop
			;IMPORT task_1
			END
