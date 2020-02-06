ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	prompt1 DB 0AH,0DH,"Enter string: $"
	prompt2 DB 0AH,0DH,"String is a palindrome$"
	prompt3 DB 0AH,0DH,"String is not a palindrome$"
	str DB 50 DUP("$") ;Reserve 50 bytes and fill with $
DATA ENDS

CODE SEGMENT
start:
	MOV AX,DATA
	MOV DS,AX

	LEA DX,prompt1
	MOV AH,09H
	INT 21H

	LEA SI,str ;Load starting address of string in SI

	MOV AH,01H
	MOV CX,0000H
	repeat:
		INT 21H
		INC CX
		MOV DH,00H
		MOV DL,AL
		PUSH DX ;Store character in stack
		MOV [SI],DL ;Store string in location pointed to by SI
		INC SI
		CMP AL,0DH
		JNZ repeat
	
	DEC CX
	POP DX ;Remove carriage return character
	LEA SI,str
	
	MOV AH,02H
	print:
		POP DX
		CMP DL,[SI]
		JNZ fail
		INC SI
		LOOP print
	success:
		LEA DX,prompt2
		MOV AH,09H
		INT 21H
		JMP stop

	fail:
		LEA DX,prompt3
		MOV AH,09H
		INT 21H

	stop:
		MOV AH,4CH
		INT 21H
CODE ENDS
END START