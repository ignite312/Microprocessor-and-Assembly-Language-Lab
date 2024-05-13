	AREA MYDATA, DATA, READWRITE
	
	AREA TASK6, CODE, READONLY
	ENTRY
	EXPORT main

main
	LDR R1, =0 ;10s place digit
	LDR R2, =0 ; 1s place digit

	LDR R0, =5 ; Delay 5 just to check, we can set 1000000 for 1 sec delay
Loop
	;Check if the 1's place value reach 10 or not, if not reach then go to Start delay 
	CMP R2, #10
	BNE Start_Delay
	
	;  Increase the 10's value
	MOV R2, #0
	ADD R1, R1, #1
	
	; if the 10s place digit becomes 10, then return back to 0.
	CMP R1, #10
	MOVEQ R1, #0
	
Start_Delay
	LDR R10, =0
Delay_Running

	CMP R10, R0
	BEQ End_Delay
	
	ADD R10, R10, #1
	B Delay_Running
	
End_Delay
	; increasing 1's value by 1
	ADD R2, R2, #1
	B Loop

STOP B STOP
	END 