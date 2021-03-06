; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    array db 20 dup(?) ;pocetna niza
    numarray db 20 dup(?) ;zavrshna niza
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers: 
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
            
    mov bx, offset array
    mov cl, '$'
    mov [bx], cl
    inc bx
    
    input:
    mov ah, 01d
    int 21h
    cmp al, cl ; if(char == '$') break
    je doneinput
    
    mov [bx], al
    inc bx
    jmp input;all OK
    
    doneinput:
    
    mov cl, '$'
    mov ch, 0d
    push cx
    
    
    mov dx, offset numarray  
    
    isNum:
    mov cl, '$'
    cmp [bx], cl ;dali imame stignato do krajot na nizata
    je endArray
    
    mov cl, 30h
    cmp [bx], cl
    jae isAboveO
    dec bx   ;naredna memory lokacija
    jmp isNum
    
    isAboveO: ;Znachi  deka e pogolemo ili ednakvo od 0
    mov cl, 39h
    cmp [bx], cl
    jbe isBetween
    dec bx
    jmp isNum
    
    isBetween:
    push [bx]
    dec bx
    jmp isNum
    
    
    endArray:
    
    mov cl, '$'
    
    mov bx, offset array
    
    stck:
    pop bx
    cmp bl, cl
    je done
    mov dl, bl
    mov ah, 02h
    int 21h
    jmp stck    
    
    done:
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
