; THIS IS ONE THAT HAS NULL BYTES, FUCK!

global _start

; i wish to learn shellcode because i figured itd help me with my asm skills and help me obtain an
; important skill, so killing two birds with one stone.

; nasm -f elf32 01.asm -o 01.o
; ld -m elf_i386 01.o -o 01
; alternatively, just use nasm -f elf64 and you can skip the whole -m elf_i386 part

section .text
_start:
    mov eax, 11    ; syscall for execve
    mov ebx, shell ; next argument for the syscall
    mov ecx, 0     ; nothing here, we dont need this so null
    int 0x80       ; syscall works just fine, but old men do old things

    mov eax, 1     ; syscall for exit
    mov ebx, 0     ; no errors, return status 0
    int 0x80

section .data
    shell db "/bin/sh" ;stores the bin sh string for execve
                       ;i was wondering if this had to be little endian, but i guess thats just the stack
