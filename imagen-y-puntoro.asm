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
	   
	mov ah,02h
	mov dh,0ch
	mov dl,28h
	int 10h 
	mov ah, 2ch
	int 21h
	
	mov hor,ch
	mov min,cl
	mov sec,dh
	
	;imprimir horas
	mov al, hor
	aam
	mov bh, ah
	mov bl, al
    mov al, bl
    add al, 30h
    mov ah, 02h
    int 21h
    mov al, bh
    mov ah, 02h
    int 21h
    
    ;imprimir minutos
	mov al, min
	aam
	mov bh, ah
	mov bl, al
    mov al, bl
    add al, 30h
    mov ah, 02h
    int 21h
    mov al, bh
    mov ah, 02h
    int 21h 
    
    ;imprimir segundos
	mov al, sec
	aam
	mov bh, ah
	mov bl, al
    mov al, bl
    add al, 30h
    mov ah, 02h
    int 21h
    mov al, bh
    mov ah, 02h
    int 21h
	
	mov ah,0eh
	mov bx,007h
	mov al,2ah
	
	mov al,50h 
    mov bl,5h
    mov cx,3 
    mov ah,09h 
     
    
    
    int 10h

end ; finaliza directiva