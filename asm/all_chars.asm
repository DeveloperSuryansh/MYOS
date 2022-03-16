[ORG 0x7c00]
[bits 16]

mov si,txt
call while
main:
    mov al,0x13
    call getMem
    jmp main

while:
    lp:
        mov al,[si]
        inc si
        mov ah,0eh
        int 10h
        or al,al
        jz return
        jmp lp    

return:
    ret

getMem:
    mov ah,03h
    int 21h
    ret

txt: db 'hello',0

times 510 - ($-$$) db 0
dw 0xaa55