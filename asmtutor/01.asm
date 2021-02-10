section .data
    msg: db "hello motherfucker", 0
; string

section .text
global _start
_start:
    xor eax, eax ; clear eax, not really needed
    mov edx, 18  ; length of string
    mov eax, 4   ; syscall for write
    mov ebx, 1   ; write to stdout
    mov ecx, msg ; next parameter, point to string
    int 0x80     ; syscall

    ; proper exit
    ; clear register
    xor eax, eax
    mov eax, 1  ; syscall for exit
    mov ebx, 0  ; status code 0
    int 0x80    ; syscall
