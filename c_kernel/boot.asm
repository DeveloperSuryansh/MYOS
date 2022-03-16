MAGIC equ 0x1BADB002
FLAGS equ 0x3
CHECK equ -(MAGIC+FLAGS)

dd MAGIC
dd FLAGS
dd CHECK
align 4

global start
extern main
start:
    call main
    jmp $