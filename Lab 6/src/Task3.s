	AREA MYDATA,DATA,READWRITE
a DCD 13, 3, 1, 2, 22, 11
a_size EQU 6
	
	AREA MYCODE,CODE,READONLY
	ENTRY
	EXPORT main

main
    LDR r0, =a
    MOV r1, #a_size

    ; Insertion sort algorithm
    MOV r2, #0                  ; r2: outer loop index (i)

Outer_loop
    CMP r2, r1                  ; Compare outer loop index with array size
    BEQ Loop_end                ; If index reaches array size, exit outer loop

    MOV r4, r2                  ; Set inner loop index (j) to current outer loop index (i)

Inner_loop
    SUBS r4, r4, #1            ; Decrement inner loop index (j)
    ADDS r6, r4, #1            ; Calculate index for the next element (j+1)
    CMP r4, #0                 ; Check if reached the beginning of the array
    BLT out_of_inner           ; If inner loop index is negative, exit inner loop

    LDR r3, [r0, r4, LSL #2]  ; Load current element (a[j])
    LDR r5, [r0, r6, LSL #2]  ; Load next element (a[j+1])

    CMP r3, r5                 ; Compare current and next elements
    IT GT                      ; Conditional execution for greater than
    STRGT r3, [r0, r6, LSL #2] ; Swap if current element is greater
    STRGT r5, [r0, r4, LSL #2] ;

    BLE out_of_inner           ; If not greater, exit inner loop

    B Inner_loop

out_of_inner
    ADDS r2, r2, #1
    B Outer_loop

Loop_end

STOP B STOP
END