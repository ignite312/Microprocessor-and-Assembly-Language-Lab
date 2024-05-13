	AREA Mydata, DATA, READWRITE

; Define the array of records (byte triplets)
a       DCD 0xefab12, 0xefab12, 0x123456
b       equ 1         ; Second array to store the largest bytes
n       equ 3         ; Number of records (byte triplets)

	AREA Task8, CODE, READONLY
	ENTRY
	EXPORT main

main
    LDR r0, =a
    MOV r1, #b
    MOV r2, #n
    LSL r2, r2, #2      ; Multiply by 4 to get the total number of bytes


    ; Initialize loop index
    MOV r3, #0

loop_start
    ; Load bytes from the current record
    LDR r4, [r0, r3]    ; Load the triplet
    LDRB r5, [r4]       ; Load the first byte
    LDRB r6, [r4, #1]   ; Load the second byte
    LDRB r7, [r4, #2]   ; Load the third byte

    ; Find the largest byte
    CMP r5, r6          ; Compare the first and second bytes
    MOVGT r5, r6        ; If r6 is greater, set r5 to r6
    CMP r5, r7          ; Compare the largest byte so far with the third byte
    MOVGT r5, r7        ; If r7 is greater, set r5 to r7

    ; Store the largest byte in the second array
    STRB r5, [r1, r3]   ; Store the largest byte at the current index in the second array

    ; Increment the loop index
    ADD r3, r3, #4      ; Move to the next record (each record is 4 bytes)

    ; Check if the end of the array is reached
    CMP r3, r2
    BLT loop_start      ; If not, continue looping


STOP  B main

	END