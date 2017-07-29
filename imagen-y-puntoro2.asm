.model small ; el tamanio del programa
.stack 0h ; donde iniciara
.data ; declara variables

	hor db ?
    min db ?
    sec db ?
    cont db 08h 
    
.code
	mov ax,@data
	mov ds,ax
INICIO :      
    MOV AH,06H ;LIMPIEZA 1
	MOV AL,00H
	MOV BH,90D ;COLOR AMARILLO
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
	
	and ax,0000h
	mov al,sec
	aam  
	mov bl,ah
	and ax,00ffh
	push ax
    mov al,bl
    and ax,00ffh
	push ax
	push 03ah
	          
	and ax,0000h
	mov al,min
	aam  
	mov bl,ah
	and ax,00ffh
	push ax
    mov al,bl
    and ax,00ffh
	push ax
	push 03ah 
	
	and ax,0000h
	mov al,hor
	aam  
	mov bl,ah
	and ax,00ffh
	push ax
    mov al,bl
    and ax,00ffh
	push ax
	
    jmp IMP	
	
IMP:
	pop dx
	and dx,00ffh
	cmp dl,09h 
	jbe IMPN
	ja IMPS
	
IMPN:
    mov al,dl
    add al,30h
    jmp IMPC

IMPS:
    mov al,58
    jmp IMPC
IMPC:
	
	
	mov ah,02h
	int 21h
	dec cont
	cmp cont,0h
	ja IMP

	
	mov ah,0eh
	mov bx,007h
	mov al,2ah
	
	mov al,50h 
    mov bl,5h
    mov cx,3 
    mov ah,09h          
    
    int 10h

end ; finaliza directiva