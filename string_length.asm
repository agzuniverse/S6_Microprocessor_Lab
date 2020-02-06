ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	prompt1 DB 0AH,0DH,"Enter string: $"
	prompt2 DB 0AH,0DH,"Length of string is : $"
DATA ENDS

CODE SEGMENT
start:
	MOV AX,DATA
	MOV DS,AX

	LEA DX,prompt1
	MOV AH,09H
	INT 21H

	MOV CX,0000H
	MOV AH,01H
	repeat:
		INT 21H
		INC CX ;Store length of string in CX
		CMP AL,0DH ;Break on carriage return
		JNZ repeat

	DEC CX ;Don't count carriage return character
	MOV AX,CX
	MOV CX,0000H

	;Convert length from hex to BCD
	divide:
		MOV BX,000AH
		MOV DX,0000H
		DIV BX
		PUSH DX
		INC CX
		CMP AX,0000H
		JNZ divide

	LEA DX,prompt2
	MOV AH,09H
	INT 21H

	MOV AH,02H
	reminder:
		POP DX
		ADD DL,30H
		INT 21H
		LOOP reminder

	MOV AH,4CH
	INT 21H
CODE ENDS
END START