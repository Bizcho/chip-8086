.model small      ;tamano del programa

.stack 0h         ;En dondeiniciara

.data             ;Declarar variables

    cont db 0h  
    vmul dw 01h 
    valor dw ?
    valorbin dw ?
    valorhex dw ?
    valoroct dw ?
    valorgre dw ?
    valorgre2 dw ? 
    temp dw ? 
    temp8 db ?
    cos16 dw ?
    resi16 dw ?     
    cos db ?
    resi db ?
    cont2 db 0h 
 
.code             ;Escribir codigo

    mov ax, @data
    mov ds, ax
    

INICIO:            ;Etiqueta
    mov ah,01h
    int 21h
    cmp al,0dh ;al se igual que el enter
    je ENTER
    and ax,0ffh
    push ax
    inc cont
    jmp INICIO  
    
ENTER:
    
    mov ah, 02h 
    ;dx = 01 00 h = (0,1)
    mov dh, 01h  ;renglones
    mov dl, 00h  ;columnas
    int 10h
    jmp CONV
    
    
CONV:
    pop dx   
    mov temp,dx 
    sub temp,30h
    mov ax,temp
    mul vmul 
    add valor,ax
    
    
    
                 
    cmp cont,01
    je ALM
    mov ax,10
    mul vmul
    mov vmul,ax
    dec cont
    jmp CONV  
      
     
      
ALM:
    mov ax,01
    mul valor
    mov valorbin,ax
    mov ax,01 
    mul valor
    mov valorhex,ax
    mov ax,01 
    mul valor
    mov valoroct,ax
    mov ax,01 
    mul valor
    mov valorgre,ax
    mov ax,0000h
    mov cont,0h  
    mov ax,valorBin 




CONBIN: 
     
    mov cx,0002
    div cx
    
    mov cos16,ax    
    cmp ah,80h
    jae LIM
    jmp CONTI
LIM:
    sub ah,80h
CONTI:          
           
    push dx  
    inc cont2 
    
    cmp cos16,0001 
    jb IMPBIN
    jmp CONBIN

IMPBIN:      
    pop dx
    add dl,30h
    mov ah,02h
    
    cmp cont2,0h
    je ENTEROCT    
    dec cont2
    int 21h
    jmp IMPBIN  

ENTEROCT:
    
    mov ah, 02h 
    ;dx = 01 00 h = (0,1)
    mov dh, 02h  ;renglones
    mov dl, 00h  ;columnas
    int 10h 
    mov cont,0h
    mov temp,0h 
    and dx,0000h
    mov ax,valoroct
    jmp CONOCT     

CONOCT: 
    
      
    mov cx,0008
    div cx
    
    mov cos16,aX 
    cmp ah,20h
    jae LIMOCT       
    
    jmp CONTIOCT
LIMOCT:
    and ah,0fh 
    mov cos16,ax
CONTIOCT: 
    
    push dx  
    inc temp 
    
    cmp cos16,01 
    jb IMPOCT
    jmp CONOCT
        

IMPOCT:
    mov ax,0h 
    mov dx,0h
    mov bx,0h
    mov cx,0h     
    pop dx
    add dl,30h
    mov ah,02h
    
    cmp temp,0h
    je ENTERHEX    
    
    int 21h 
    
    dec temp
    jmp IMPOCT 

ENTERHEX:
    
    mov ah, 02h 
    ;dx = 01 00 h = (0,1)
    mov dh, 03h  ;renglones
    mov dl, 00h  ;columnas
    int 10h 
    mov cont,0h
    mov temp,0h 
    mov ax,valorhex 
    mov dx,0000h
    jmp CONVHEX    
    
CONVHEX:
      
    mov cx,10h
    div cx
    mov cos16,ax    
    cmp ah,20h
    jae LIMHEX       
    
    jmp CONTIHEX
LIMHEX:
    and ah,0fh 
    mov cos16,ax
CONTIHEX:
    
    push dx  
    inc temp 
    
    cmp cos16,01 
    jb IMPHEX1
    jmp CONVHEX 
    
    
IMPHEX1:
    mov ax,0h 
    mov dx,0h
    mov bx,0h
    mov cx,0h     
    pop dx     
    
    cmp dl,09h
    ja LETRAS 
    add dl,30h 
    JMP IMPHEX2    
LETRAS:
    add dl,55
    jmp IMPHEX2

IMPHEX2:    
    
    mov ah,02h
    cmp temp,0h
    je ENTERGRE    
    int 21h 
    dec temp
    jmp IMPHEX1
    
ENTERGRE:
    
    mov ah, 02h 
    ;dx = 01 00 h = (0,1)
    mov dh, 04h  ;renglones
    mov dl, 00h  ;columnas
    int 10h 
    mov cont,0h
    mov temp,0h 
    
    mov dx,0000h
    jmp CONGRE 
           

CONGRE:     
    mov bx,valorgre
    mov valorgre2,bx
    shr valorgre2,01h
    mov bx, valorgre2 
    xor valorgre,bx 
    mov ax,valorgre
    

BINGRE:
    mov cx,0002
    div cx
    
    mov cos16,ax    
    cmp ah,80h
    jae LIMGRE
    jmp CONTIGRE
LIMGRE:
    sub ah,80h
CONTIGRE:          
           
    push dx  
    inc cont2 
    
    cmp cos16,0001 
    jb IMPGRE
    jmp BINGRE

IMPGRE:      
    pop dx
    add dl,30h
    mov ah,02h
    
    cmp cont2,0h
    je FIN    
    dec cont2
    int 21h
    jmp IMPGRE 
    
FIN: 
     
    mov ah,4ch
    int 21h
    
end               ;Finalizar directiva