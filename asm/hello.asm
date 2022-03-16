[BITS 16]
[ORG 0x7C00]

section .text
mov al,dl
call printc
mov bx,[input]
mov al,03h
call setVideoMode
mov bl,0x04
mov bh,0x00
call clear
call clear
call welcome
jmp main

main:
    call newline
    call inPrompt
    call getInput
    call checkCom
    jmp main

inPrompt:
    mov bl,0x02
    mov si,prompt
    call print
    ret

welcome:
;===========================================Draw Starting Screen
;====================Draw Box
mov cx,21
call line
mov dh,0
mov dl,21
call setCursor

pusha
mov bl,02
mov si,title
call print
popa

mov cx,20
call line
mov dl,0
call setCursor
mov al,"|"
call printc
call newline
mov al,"|"
call printc
call newline
mov al,"|"
call printc
call newline
mov al,"|"
call printc
call newline
mov al,"|"
call printc

mov dh,1
mov dl,50
call setCursor
mov al,"|"
call printc
inc dh
call setCursor
mov al,"|"
call printc
inc dh
call setCursor
mov al,"|"
call printc
inc dh
call setCursor
mov al,"|"
call printc
call newline
mov cx,50
call line
;====================Write Text inside Box
mov bl,0x02
mov dl,8
mov dh,2
call setCursor
mov si,ver
call print
inc dh
mov dl,8
call setCursor
mov si,copyright
call print
call newline
call newline
call newline
ret

;=======================

getInput:
    mov cx,inLen
    mov di,input
    inputLoop:
        mov ah,00h
        int 16h
        stosb
        cmp al,13
        je return
        mov bl,02h
        call printc
        inc dl
        call setCursor
        cld
        rep movsb
        jmp inputLoop

checkCom:
    mov si,clearCom
    call cmpstr
    jc Comclear

    mov si,helpCom
    call cmpstr
    jc Comhelp

    mov si,rebootCom
    call cmpstr
    jc Comreboot
    ret

Comhelp:
    ret
    
Comreboot:
    int 19h
    ret

Comclear:
    mov bh,0x0
    mov bl,0x02
    call clear
    call clear
    ret

cmpstr:
    mov di,input
    ;set si = command to compare
    lp:
        mov al,[si]
        mov ah,[di]
        inc si
        add di,2
        cmp al,0
        je equal
        cmp al,ah
        je lp
        jmp not_equal
        ret

not_equal:
    clc
    ret

equal:
    stc
    ret

reboot:
    int 19h

newline:
    mov ah,02h
    inc dh
    mov dl,0
    int 10h
    ret

line:
    mov ah,0x09
    ;set bl = color
    mov al,175
    ;set cx = length of line, dl=x
    int 0x10
    mov ah,0x02
    inc dh
    int 10h
    ret

clear:
        mov ah,0x09
        ;set bl = color
        mov al,' '
        mov cx,4000
        int 0x10
        mov ah,0x02
        mov dl,0
        mov dh,0
        int 10h
        ret

printc:
        mov ah,0x09
        mov cx,1
        int 0x10
        ret

setVideoMode:
    mov ah,0
    ;set al for video mode
    int 10h
    ret

setCursor:
    ;set dh = row
    ;set dl = column
    ;set bh = page number
    mov ah,0x02
    int 10h
    ret

setPage:
    ;set al = page number
    mov ah,0x05
    int 10h
    ret

return:
    ret

print:
    nextc:
        mov al,[si]
        inc si
        or al,al
        jz return
        cmp al,13
        jz newline
        call printc
        inc dl
        mov ah,0x02
        int 10h
        jmp nextc


ver: db "Surya OS version 1.0",0
title: db "SURYA OS",0
loading: db "Loading...",0
copyright: db "Copyright Suryansh Sharma 2022-2099",0
prompt: db "Hacker@surya >",0

clearCom: db "scrclr",0
helpCom: db "help",0
rebootCom:db "reboot",0

times 510-($-$$) db 0
dw 0xaa55

section .bss
input: resb 10
inLen equ $-input