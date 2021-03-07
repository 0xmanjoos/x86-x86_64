bits 32
;
; nasm -f win32 01.asm
; golink 01.obj kernel32.dll user32.dll /entry:_start
;
[SECTION .drctve info align=8]
db "kernel32.dll", 0x20
db "user32.dll", 0x20   ; space terminated strings


extern ExitProcess
extern MessageBoxA

section .data
    caption: db "you done got hacked now!!!", 0
    message: db "Hello World!", 0


section .text
global _start

; i dont like how everything in windowws x86 is a dword
; cant they just use bytes liek the rest of us
_start:
    push DWORD 0
    push DWORD caption
    push DWORD message
    push DWORD 0
    call MessageBoxA

    push DWORD 0
    call ExitProcess
