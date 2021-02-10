; subroutines, we will be utilizing our functions from 03.asm but in a slightly more complicated manner
; this should help us understand the stack and the push pop call ret registers better
; they are functions, pieces of reusable code called by program to perform various tasks
; declared using labels, we use call to call them instead of jmp
; the difference between jmp and call is that call resumes where it left off
; example: jmp functionOne, it will change eip to address of functionOne, execute, and exit
; jmp will not return to where it was called, in the case of call you can call printf(); in a c program
; and it wont just kill the process at printf();, it will continue until int main() is finished

; like push and pop, call and ret both use the stack
; when you CALL a function, the address that was called is PUSH ed onto the stack
; the address is then POP 'ped off the stack with RET and thats how the program resumes execution

section .data
    msg: db "muetherfUckEr!", 13, 10, "small cunteh!!"

section .text
global _start
_start:
    mov eax, msg
    call strlen     ; call our string len function || subroutine

    mov edx, eax    ; edx == eax == length of our string
    mov ecx, msg
    mov eax, 4      ; write stdout
    mov ebx, 1
    int 0x80

    mov eax, 1  ; exit 0
    mov ebx, 0
    int 0x80


; strlen called, it will continue execution to nextChar:
strlen:
    push ebx        ; save stack frame, we will later pop ebx
    mov ebx, eax    ; address of string

; see 03.asm for explanation

; after strlen, execution will pass to nextChar, then redirect to finished with jz ; jmp
nextChar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextChar

; after execution passed here, restore stack frame and ret to _start:
finished:
    sub eax, ebx ; eax is now strlen(msg)
    pop ebx      ; restore stack frame
    ret          ; return program execution
