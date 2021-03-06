; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    grade1 db 2
    grade2 db 3
    grade3 db 5
    avg db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, 11110000b
    push ax
    cmp ax, 00001111b
    pushf
    mov ah, 1
    int 21h
    pop bx
    mov ax, 4c00h
    int 21h
ends

end start ; set entry point and stop the assembler.
