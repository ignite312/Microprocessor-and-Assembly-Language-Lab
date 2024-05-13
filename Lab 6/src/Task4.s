	AREA MYDATA,DATA,READWRITE

a dcb 0xAF, 0xFF , 0xBF, 0xFF ; 4 byte declaration
a_size equ 4

	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT main

; Procedure to calculate sum and carry
sum_with_carry PROC
    ; Inputs:
    ; r0 = address of array
    ; r1 = array size
    ; Outputs:
    ; r4 = sum
    ; r5 = carry

    mov r4, #0          ; Initialize sum to 0
    mov r5, #0          ; Initialize carry to 0

    mov r2, #0          ; Initialize index to 0
	
loop
    cmp r2, r1          ; Compare index with array size
    beq Loop_end        ; If index equals array size, exit the loop
    ldrb r7, [r0, r2]   ; Load byte from array at index into r7
    add r4, r4, r7      ; Add byte to sum
    mov r8, r4          ; Copy sum to r8
    lsr r8, r8, #8      ; Shift sum right by 8 bits to get carry
    add r5, r5, r8      ; Add carry to carry accumulator
    and r4, r4, #0xFF   ; Clear upper bits of sum to keep only lower 8 bits

    add r2, r2, #1

    b loop

Loop_end
    bx lr
    ENDP

main 
    ldr r0, =a 
    mov r1, #a_size

    bl sum_with_carry

STOP B STOP
	END
