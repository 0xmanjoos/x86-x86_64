section .data

    ; assemblers dont interpret \n characters so we just insert a 13, 10 and calc the len of msg

    msg: db "hello you fat fuck", 13, 10, "how are yeh today?", 13, 10
    len equ $ - msg     ; length of string

section .text
global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

