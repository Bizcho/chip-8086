.model small 
.stack 0h 
.data 

	hour    db 00h
    minute  db 00h 
    second  db 00h
    counter db 08h
.code
	mov ax, @data
	mov ds, ax
INICIO : ;start of the code
;set carret ;dx = 01 00 h = (0,1)
	mov ah, 02h 
    mov dh, 0ah  ;renglones
    mov dl, 30h  ;columnas
    int 10h
;get the time
	mov ah,  2ch
	int 21h
;insert into vars	
	mov hour, ch
	mov minute, cl
	mov second, dh

;printing code
;add seconds to stack
	and ax, 0000h
	mov al, second
	aam  
	mov bl, ah
	and ax, 00ffh
	push ax
    mov al, bl
    and ax, 00ffh
	push ax
	push 03ah ; add a ":"
;add minutes to stack
	and ax, 0000h
	mov al, minute
	aam  
	mov bl, ah
	and ax, 00ffh
	push ax
    mov al, bl
    and ax, 00ffh
	push ax
	push 03ah ; add a ":"
;add hours to stack
	and ax, 0000h
	mov al, hour
	aam  
	mov bl, ah
	and ax, 00ffh
	push ax
    mov al, bl
    and ax, 00ffh
	push ax
	
    jmp IMP	
	
IMP:
	pop dx
	and dx, 00ffh
	cmp dl, 09h 
	jbe IMPN ;jump to print number
	ja IMPC ;jump to print caracter
	
IMPN:
    ;mov al, dl
    add dl, 30h
    jmp IMPC

IMPS:
    mov al, 58
    jmp IMPC

IMPC:
	mov ah, 02h
	int 21h
	dec counter
	cmp counter, 0h
	ja IMP

;reset counter
	mov counter, 08h

;one sec delay
	mov     cx,  01h
    mov     dx,  5f90h ; 015f90h = 900,000
    mov     ah,  86h ;wait
    int     15h ;pases the 
; end of on sec delay 
	jmp INICIO

end