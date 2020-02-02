ASSUME DS:DATA,CS:CODE

DATA SEGMENT
    prompt1 DB 0AH,0DH,"Enter string: $"
    prompt2 DB 0AH,0DH,"Length of string is: $"
DATA ENDS

CODE SEGMENT
    start:
        MOV AX,DATA
        MOV DS,AX

        LEA DX,prompt1
        MOV AH,09H
        INT 21H

        MOV CX,0000H ;Clear CX to use it as counter for the length

        MOV AH,01H
        repeat:
            INT 21H
            INC CX
            CMP AL,0DH ;Break on encountering carriage return
            JNZ repeat

        DEC CX ;Don't count the new line character

        ADD CL,30H
        MOV DL,CL
        MOV AH,02H
        INT 21H

        MOV AH,4CH
        INT 21H
CODE ENDS
END START