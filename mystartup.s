				AREA 	RESET,CODE,Readonly
				ENTRY 		;the first instruction to execute follows
MAMCR			EQU		0xE01FC000
MAMTIM			EQU		0xE01FC004
VECTORS
				LDR		PC, Reset_Addr
				LDR		PC, Undef_Addr
				LDR		PC, SWI_Addr
				LDR		PC, PAbt_Addr
				LDR		PC, DAbt_Addr
				NOP
				LDR		PC, IRQ_Addr
				LDR		PC, FIQ_Addr

Reset_Addr      DCD		Reset_Handler
Undef_Addr	   	DCD		UndefHandler
SWI_Addr	  	DCD		SWIHandler
PAbt_Addr	  	DCD		PAbtHandler
DAbt_Addr	   	DCD		DAbtHandler
				DCD		0

IRQ_Addr	   	DCD		IRQHandler
FIQ_Addr	   	DCD		FIQHandler

SWIHandler		B		SWIHandler
PAbtHandler		B		PAbtHandler	
DAbtHandler		B		DAbtHandler
IRQHandler		B		IRQHandler
FIQHandler		B		FIQHandler
UndefHandler	B		UndefHandler

			;IMPORT Reset_Handler
			;GLOBAL Reset_Handler
Reset_Handler
				LDR r1, =MAMCR
				MOV r0, #0x0
				STR	r0, [r1]
				LDR r2, =MAMTIM
				MOV r0, #0x1
				STR r0, [r2]
				MOV	r0, #0x2
				STR	r0, [r1]
				B		Exp_5
				IMPORT	Exp_5
			END