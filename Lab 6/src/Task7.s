	
	AREA MYDATA, DATA, READWRITE
src  dcd 0xABCDEFAB, 0x12345678   ; Define an array 'src' with four 32-bit values
dest dcb 0                        ; Define an array 'dest' with a single byte initialized to 0

	AREA Task7, CODE, READONLY
	ENTRY
	EXPORT main

main 
    ldr r0, =src        ; Load the base address of the source array 'src' into register r0
    ldr r1, =dest       ; Load the base address of the destination array 'dest' into register r1
    
    mov r2, #8          ; Set the transfer size to 8 bytes
    mov r4, #0          ; Initialize a counter register r4 to 0
    
loop 
    cmp r4, r2          ; Compare the value of counter r4 with the transfer size r2
    beq loop_end        ; Branch to 'loop_end' if the counter equals the transfer size
    
    ldrb r5, [r0, r4]   ; Load a byte from the source array using indexed addressing mode
    strb r5, [r1, r4]   ; Store the byte in the corresponding position in the destination array using indexed addressing mode
    
    add r4, r4, #1      ; Increment the counter register to move to the next byte in the arrays
    
    b loop

loop_end

STOP B STOP
	END
