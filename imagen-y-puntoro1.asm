.model small ; el tamanio del programa
.stack 0h ; donde iniciara
.data ; declara variables

	hor db ?
    min db ?
    sec db ?
.code
	mov ax,@data
	mov ds,ax
INICIO :      
MOV AH,06H ;LIMPIEZA 1
	   MOV AL,00H
	   MOV BH,100D ;COLOR AMARILLO
	   MOV CX,0000H ;PUNTO DE INICIO
	   MOV DX,244fH ;PUNTO DE FINAL
	   INT 10H
PLOP:   
	mov ah,02h
	mov dh,0ch
	mov dl,28h
	int 10h 
	mov ah, 2ch
	int 21h
	
	mov hor,ch
	mov min,cl
	mov sec,dh
	
	;one sec delay
	MOV     CX, 0FH
    MOV     DX, 4240H
    MOV     AH, 86H ;wait
    INT     15H ;pases the 
	; end of on sec delay 
	jmp PLOP      
	      
	mov ah,0eh
	mov bx,007h
	mov al,2ah
	
	mov al,50h 
    mov bl,5h
    mov cx,3 
    mov ah,09h 
    int 10h

end ; finaliza directiva