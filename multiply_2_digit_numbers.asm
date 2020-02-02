ASSUME DS:DATA,CS:CODE

DATA SEGMENT
	prompt1 DB 0AH,0DH,"Enter first number: $"
	prompt2 DB 0AH,0DH,"Enter second number: $"
	prompt3 DB 0AH,0DH,"Result is: $"
DATA ENDS

CODE SEGMENT
	start:
		MOV AX,DATA
		MOV DS,AX

		LEA DX,prompt1
		MOV AH,09H
		INT 21H

		MOV AH,01H
		INT 21H
		SUB AL,30H ;Subtract 30 to convert from ASCII to number
		MOV BH,AL
		INT 21H
		SUB AL,30H
		MOV BL,AL ;BX has first number

		LEA DX,prompt2
		MOV AH,09H
		INT 21H

		MOV AH,01H
		INT 21H
		SUB AL,30H
		MOV CH,AL
		INT 21H
		SUB AL,30H
		MOV CL,AL ;CX has second number

        ;MUL with an 8 bit operand stores results in AX=AL*operand
        ;MUL with a 16 bit operand stores result in DX AX = AX*operand

		MOV AL,0AH;To convert to hex, multiply MSB by 0AH and add LSB
		MUL BH; Result will be in AX, but for upto 9*0AH it will stay in AL
		ADD AL,BL
		MOV BL,AL ;BL now has the hex value of first input number

		MOV AL,0AH
		MUL CH
		ADD AL,CL
		MOV CL,AL ;CL now has the hex value of second input number
        
        MOV AL,CL
		MUL BL ;AX now has the multiplication result

		MOV CX,0000H

        ;DIV with 8 bit operand does AX/operand and reminder is stored in AH and quotient in AL
        ;DIV with 16 bit operand does DX AX/operand and reminder is stored in DX and quotient in AX

		divide:
			MOV BX,000AH ;To convert hex back to BCD, keep dividing by 0AH till quotient is 0
			MOV DX,0000H			
			DIV BX
			PUSH DX ;The reminder after each division is pushed into stack
			INC CX ;Use CX to keep track of number of digits in answer
			CMP AX,0000H ;Break loop once quotient is 0
			JNZ divide

        LEA DX,prompt3
		MOV AH,09H
		INT 21H

		reminder:
			POP DX
			ADD DL,30H ;Add 30 to convert BCD to ASCII
			MOV AH,02H
			INT 21H
			LOOP reminder		

        MOV AH,4CH
		INT 21H
CODE ENDS
END START