; elaborating and going further into the concept of subroutines or functions in assembly

%include "functions.asm"

section .data
    msg1 db "Hello there yeh cunt", 13, 10, 0x0A, 0x00
    msg2 db "recycled!", 0x0A, 0x00

section .text
global _start
_start:
    ; so simple and easy, we just call functions from our external lib
    mov eax, msg1
    call sprint

    mov eax, msg2
    call sprint

    call quit


; it outputs weird jarble for some reason, i might need to debug this darn thing
