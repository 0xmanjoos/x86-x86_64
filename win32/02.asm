bits 32

extern ExitProcess
extern GetStdHandle
extern WriteFile

section .data
    msg: db "Jotaro kujo", 0
    msglen equ $ - msg
section .text
global _start
_start:
; establish and save stack frame, allocate memory on stack
    push ebp
    mov ebp, esp

    push -11    ; std_output_handle
    call GetStdHandle
    push 0
    push 0

    push msglen
    push msg
    push eax
    call WriteFile

    push 0
    call ExitProcess
    xor eax, eax
    pop ebp
    ret
