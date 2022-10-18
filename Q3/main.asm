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

			mov.w #0000h, R4				; initialize values for R4, R5, and R9
			mov.w #0001h, R5
			mov.w #0000h, R9

			mov.w #0001h, &2000h			; fill memory 2000h with ...00001
			mov.w &2000h, R8				; move 2000h to R8 for operations

			mov.w &2000h, R6				; move 2000h to R6 for operations
			mov.w &2000h, R7				; move 2000h to R7 for operations
			and.w R4, R6					; and R4 and ...00001 so if LSB of R4=1 LSB of R6=1
			and.w R5, R7					; and R5 and ...00001 so if LSB of R5=1 LSB of R7=1

			and.w R6, R7					; if LSB of R4 and R5 are 1, R7's LSB will be 1
			cmp R7, R8
			jeq andLSB1

			mov.w &2000h, R7				; move 2000h to R7 for operations
			and.w R5, R7					; and R5 and ...00001 so if LSB of R5=1 LSB of R7=1

			xor.w R6, R7					; xor the LSB of R4 and R5
			cmp R7, R8						; compare the result to ...00001
			jeq orLSB1						; if equal, the LSB of R4 or R5 was 1, but not both


andLSB1:
			mov.w #0FF0h, R9				; assign R9 the necessaray value

orLSB1:
			mov.w #0FFFFh, R10				; fill R10 with binary ...11111
			xor.w R9, R10					; this will save the 1s complement of R9 to R10

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
            
