; read numbers 1-10 from a for loop in assembly, probably gonna be full of cmp's and jz's

section .data
    msg: db "Numbers 1-10:  ", 13, 10, 0


section .text
global _start
; ----------------------------------
; OUR OLD FUNCTIONS USED HERE FOR THE SAKE OF NOT WANTING TO REINVENT THE WHEEL
slen:
    push ebx
    mov ebx, eax
nextChar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextChar
finished:
    sub eax, ebx
    pop ebx
    ret
sprint:
    push edx
    push ecx
    push ebx
    push eax
    call slen

    mov edx, eax
    pop eax

    mov ecx, eax
    mov ebx, 1
    mov eax, 4
    int 0x80

    pop ebx
    pop ecx
    pop edx
    ret

sprintLF:
    call sprint

    push eax
    mov eax, 0x0A
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret
; ---------------------------------------------

_start:
    ; change counter register to 0
    mov ecx, 0

nextVal:
    ; increment
    inc ecx

    mov eax, ecx   ; set address to our counter value
    add eax, 48    ; convert our number value inside eax into ascii, itoa();

    push eax       ; push eax, to save value
    mov eax, esp   ; get address of character on the stack

    call sprintLF  ; print value

    pop eax        ; restore the value of eax/itoa(counter);
    cmp ecx, 10    ; compare it with the value 10
    jne nextVal    ; if not 10, jump to nextVal

    ; exit
    mov eax, 1
    mov ebx, 0
    int 0x80
