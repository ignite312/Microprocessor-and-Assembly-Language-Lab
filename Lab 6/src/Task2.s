	AREA MYDATA, DATA, READWRITE

; Matrix A Data
rA EQU 2
cA EQU 3
matA DCD 3, 2, 5, 7, 2, 3
	
; Matrix B Data
rB EQU 3
cB EQU 2
matB DCD 1, 2, 3, 4, 5, 6

;Matrix C Data
rC EQU rA
cC EQU cB
matC DCD 0, 0, 0, 0 ; Ans Should be 34, 44, 28, 40

	AREA TASK2, CODE, READONLY
	ENTRY
	EXPORT main

main
    MOV R0, #cA
	MOV R1, #rB
    CMP R0, R1
    BNE MatrixMultiplicationNotPossible  ;Column of Matrix A should Be Equals to Rows of Matrix B
	
	LDR R1, =matC
	LDR R9, =matA
	LDR R10,=matB
	
	LDR R2, =0  ;R2 = i = 0
	
Loop1
	LDR R3, =0  ;R3 = j = 0

Loop2
	; offset = col * i + j
	LDR R6, =cC
	MLA R7, R2, R6, R3
	
	; Loading data in R5
	LDR R5, [R1, R7, LSL #2]
	
	; R4 = k = 0
	LDR R4, =0
	
Loop3
	; A[i][k] Data Loading
	LDR R8, =cA
	MLA R11, R2, R8, R4
	LDR R12, [R9, R11, LSL #2]
	
	
	;B[k][j] Data Loading
	LDR R8, =cB
	MLA R11, R4, R8, R3
	LDR R0, [R10, R11, LSL #2]
	
	
	; C[i][j] Data Loading
	LDR R5, [R1, R7, LSL #2]
	
	; Calculating C[i][j] = C[i][j] + A[i][k] * B[k][j]
	MLA R5, R0, R12, R5
	STR R5, [R1, R7, LSL #2]
	

	ADD R4, R4, #1 	;k++
	; k < cA
	CMP R4, #cA
	BNE Loop3
	
	
	ADD R3, R3, #1  ;j++
	; j < cA
	CMP R3, #cC
	BNE Loop2
	
	
	ADD R2, R2, #1 ;i++
	; i < rA
	CMP R2, #rC
	BNE Loop1
	
MatrixMultiplicationNotPossible

STOP B STOP
	END 