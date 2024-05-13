	AREA MYDATA, DATA, READWRITE

a dcd 7, 5, 3, 2, 1, 4, 6, 8, 9, 10, 11, 12   ; Define an array of integers

rows equ 3   ; Number of rows in the 2D array
cols equ 4   ; Number of columns in the 2D array
r equ 1      ; Row index
c equ 2    ; Column index

	AREA Task1, CODE, READONLY
	ENTRY
	EXPORT main

main
    ; Load the base address of the array 'a' into register r0
    ldr r0, =a
    
    ; Load the number of rows into register r1
    mov r1, #rows
    
    ; Load the number of columns into register r2
    mov r2, #cols
    
    ; Load the row index into register r3
    mov r3, #r
    
    ; Load the column index into register r4
    mov r4, #c
    
    ; Calculate the offset using row-major form: offset = (r * cols) + c
    mul r3, r3, r2      ; r3 = r * cols
    add r3, r3, r4      ; r3 = r * cols + c
    
    ; Multiply the offset by 4 (size of each element in bytes)
    lsl r3, r3, #2      ; r3 = r3 * 4
    
    ; Load the value of the element at the calculated offset into register r5
    ldr r5, [r0, r3]
    
stop b stop
	end
