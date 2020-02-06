ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	prompt1 DB 0AH,0DH,"Enter string: $"
	prompt2 DB 0AH,0DH,"Character found$"
	prompt3 DB 0AH,0DH,"Character not found$"
	prompt4 DB 0AH,0DH,"Enter character to search: $"
	str DB 50 DUP("$")
DATA ENDS

CODE SEGMENT
start:
	MOV AX,DATA
	MOV DS,AX

	LEA DX,prompt1
	MOV AH,09H
	INT 21H

	LEA SI,str

	MOV AH,01H
	repeat:
		INT 21H
		MOV [SI],AL
		INC SI
		CMP AL,0DH
		JNZ repeat

	LEA DX,prompt4		
	MOV AH,09H
	INT 21H
	MOV AH,01H
	INT 21H

	LEA SI,str
	
	print:
		CMP AL,[SI]
		JZ success
		INC SI
		LOOP print
	fail:
		LEA DX,prompt3
		MOV AH,09H
		INT 21H
		JMP stop

	success:
		LEA DX,prompt2
		MOV AH,09H
		INT 21H

	stop:
		MOV AH,4CH
		INT 21H
CODE ENDS
END START