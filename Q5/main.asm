;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

			mov.w #05h, R5					; give R4 and R5 initial values for testing
			mov.w #07h, R4

loop:
			; comparison loop / no action if equal
			cmp.w R5,R4   					; compare R4 with R5
			jn lessThan 					; jump to lessThan if R4 is less than R5
			jeq loop						; repeat the comparison if equal

			; R4 is greater than R5
			mov.w #01h, &2000h				; copy decimal 1-5 to successive memory locations
			mov.w #02h, &2002h
			mov.w #03h, &2004h
			mov.w #04h, &2006h
			mov.w #05h, &2008h

			sub.w #1, R4					; decrement R4 by 1
			jmp loop						; repeat the comparison loop

lessThan:
			; R4 is less than R5
			mov.w #0Ah, &2000h				; copy decimal 10-6 to successive memory locations
			mov.w #09h, &2002h
			mov.w #08h, &2004h
			mov.w #07h, &2006h
			mov.w #06h, &2008h

			sub.w #1, R4					; decrement R4 by 1
			jmp loop						; repeat the comparison loop
			nop

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
