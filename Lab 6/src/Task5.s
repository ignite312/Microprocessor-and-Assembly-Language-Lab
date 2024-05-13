	AREA MyData, DATA, READWRITE
	EXPORT BCD_DATA, n

n       EQU 2
BCD_DATA        DCB 0x37, 0x14  ; BCD data bytes

	AREA Code, CODE, READONLY
	EXPORT main

main
    ; Load address of BCD_DATA into R0
    LDR     R0, =BCD_DATA

    ; Initialize loop counter R1 and binary result R2 to zero
    MOV     R1, #0
    MOV     R2, #0

Loop
    ; Compare loop counter R1 with n
    CMP     R1, n
    BEQ     loop_end

    ; Load byte at address BCD_DATA[R1] into R3
    LDRB    R3, [R0, R1]

    ; Extract upper 4 bits from R3
    AND     R4, R3, #0xF0
    LSR     R4, R4, #4

    ; Extract lower 4 bits from R3
    AND     R3, R3, #0x0F

    ; Convert BCD digits to binary and accumulate into R2
    LDR     R5, =10      ; Load constant 10 into R5
    MLA     R2, R2, R5, R4  ; Multiply R4 (high-order digit) by 10 and add to R2
    MLA     R2, R2, R5, R3  ; Multiply R3 (low-order digit) by 10 and add to R2

    ; Increment loop counter R1
    ADD     R1, R1, #1
    B       Loop

loop_end

stop
    B       stop
END
