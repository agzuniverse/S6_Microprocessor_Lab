ASSUME DS:DATA,CS:CODE

DATA SEGMENT
prompt1 DB 0AH,0DH,"ENTER FIRST NUMBER:$"
prompt2 DB 0AH,0DH,"ENTER SECOND NUMBER:$"
prompt3 DB 0AH,0DH,"THE ANSWER IS:$"
DATA ENDS

;0AH,0DH is used for a newline after the prompt
;"$" is used as line end

CODE SEGMENT
start:
	MOV AX,DATA ;load data segment into ds
	MOV DS,AX

	LEA DX,prompt1 ;Addres of the string to be written to stdout must be stored in DX
	MOV AH,09H ;09 before int 21 is used to write STRING to stdout
	INT 21H

	MOV AH,01H ;01 before int 21 is used to read CHARACTER from stdin
	INT 21H
	MOV CL,AL

	LEA DX,prompt2
	MOV AH,09H
	INT 21H

	MOV AH,01H
	INT 21H
	MOV BL,AL
	
	LEA DX,	prompt3
	MOV AH,09H
	INT 21H

	MOV AH,00H ;AH must be cleared before AAA
	ADD BL,CL
	MOV AL,BL  ;AAA works on what is loaded into AL
	AAA	   ;Convert result of ASCII operand addition to number
	ADD AH,30H ;add 30 to result to obtain the ASCII code of the number to print it out
	MOV BH,AH
	ADD AL,30H ;Do for both AH and AL
	MOV BL,AL

	MOV DL,BH  ;Character to be printed is stored in DL
	MOV AH,02H ;02 before int 21 is used to write CHARACTER to stdout
	INT 21H

	MOV DL,BL
	MOV AH,02H ;Printing the second digit
	INT 21H

	MOV AH,4CH ;4C before int 21 is used to exit program
	INT 21H

CODE ENDS
END START