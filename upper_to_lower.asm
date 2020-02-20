ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	prompt1 DB 0AH,0DH,"Enter string: $"
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
	MOV CX,0000H	

	MOV AH,01H
	repeat:
		INT 21H
		MOV [SI],AL
		INC SI
		INC CX
		CMP AL,0DH
		JNZ repeat

	DEC CX
	LEA SI,str

	MOV AH,02H
	loopthrough:
		MOV DL,[SI]
		CMP DL,61H ;If ASCII is greater than or equal to 61, it is already lowercase
		JGE islowercase
		ADD DL,20H ;Add 20 to convert upper to lowercase
		islowercase:
			INT 21H
			INC SI
			LOOP loopthrough

	MOV AH,4CH
	INT 21H
CODE ENDS
END START