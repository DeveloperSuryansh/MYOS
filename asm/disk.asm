[BITS 16]
[ORG 0x7C00]

mov ah,0eh
mov al,'-'
int 10h
mov [BOOT],dl
mov bx,0x1000
mov dh,1
mov dl,[BOOT]
call disk_load
mov ah,0eh
mov al,'-'
int 10h
jmp $


disk_load:
    pusha
    push dx

    mov ah, 0x02 ; read mode
    mov al, dh   ; read dh number of sectors
    mov cl, 0x02 ; start from sector 2
                 ; (as sector 1 is our boot sector)
    mov ch, 0x00 ; cylinder 0
    mov dh, 0x00 ; head 0

    ; dl = drive number is set as input to disk_load
    ; es:bx = buffer pointer is set as input as well

    int 0x13      ; BIOS interrupt
    jc disk_error ; check carry bit for error

    pop dx     ; get back original number of sectors to read
    cmp al, dh ; BIOS sets 'al' to the # of sectors actually read
               ; compare it to 'dh' and error out if they are !=
    jne sectors_error
    popa
    ret

disk_error:
    mov ah,0eh
    mov al,'D'
    int 10h
    ret

sectors_error:
    mov ah,0eh
    mov al,'S'
    int 10h
    ret

disk_loop:
    jmp $

BOOT: db 0

times 510-($-$$) db 0
dw 0xaa55