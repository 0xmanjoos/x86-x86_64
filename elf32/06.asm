; get user input in assembly, read stdin probably

; SECTION .bss
; variableName1:      RESB    1       ; reserve space for 1 byte
; variableName2:      RESW    1       ; reserve space for 1 word
; variableName3:      RESD    1       ; reserve space for 1 double word
; variableName4:      RESQ    1       ; reserve space for 1 double precision float (quad word)
; variableName5:      REST    1       ; reserve space for 1 extended precision float

section .data

    msg2: db "Hello, ", 0
    len2 equ $ - msg2

    msg1: db "Please enter your name: ", 0
    len1 equ $ - msg1


section .bss
    input: resb 255     ; reserve 255 bytes for input string


section .text
global _start
_start:
    ; print msg1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; save from stdin into the input: 255 byte buffer
    mov edx, 255    ; size
    mov ecx, input  ; store buffer
    mov ebx, 0      ; stdin
    mov eax, 3      ; sys_read
    int 0x80

    ; print out the seconde message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; print out their input, their name
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, 255
    int 0x80

    ; exit process 0
    mov eax, 1
    mov ebx, 0
    int 0x80


