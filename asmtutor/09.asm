;
; my general purpose program written in assembly for maximum efficiency, none of that c bloat, we
; usin the old boyz here
;
; File Input Output
; open 5
; open file, probably something to do with fd?

; write 4
; write to stdout probably

; close 6
; close fd?

section .data
    welcome: db "Welcome to your machine, what would you like to do today?", 13, 10, "[1] Create a File", 13, 10, "[2] Spawn a Shell", 13, 10, "[3] Fork Bomb :)", 13, 10, "Enter: ", 0

    cmddata: db "Enter Command: ", 0


    filedata: db "Enter data to write to file: ", 0
    file_name: db "Enter the file name: ", 0

section .bss
    ; RESB means reserve, byte
    welcomeinput: resb 1


    cmdinput: resb 1024


    writedata: resb 1024
    fileinput: resb 1024

section .text
global _start
_start:
    call welcomeTitle


    call exit

welcomeTitle:
    push ebp
    mov ebp, esp

    mov eax, welcome
    call print

    mov eax, welcomeinput
    call userinput

    cmp byte [welcomeinput], "1"
    je fileWrite



    cmp byte [welcomeinput], "2"
    je shellSpawn
    cmp byte [welcomeinput], "3"
    je forkbomb


    call exit

    pop ebp
    ret



; this would work as shellcode as well, mov eax, 2 gives us null bytes and mov eax, 0 obviously will
forkbomb:
    push ebp
    mov ebp, esp

    xor eax, eax
    add eax, 2
    int 0x80
    jmp forkbomb

    pop ebp
    ret

shellSpawn:
    push ebp
    mov ebp, esp
    xor eax, eax
    push eax
    push 0x68732f2f
    push 0x6e69622f

    mov ebx, esp
    mov ecx, eax

    mov edx, 0

    mov eax, 11
    int 0x80

    pop ebp
    ret



fileWrite:
    push ebp
    mov ebp, esp

    mov eax, file_name
    call print

    mov eax, fileinput
    call userinput

    mov eax, filedata
    call print

    mov eax, writedata
    call userinput

    mov ecx, 0777   ; 777 chmod
    mov ebx, fileinput  ; name of file
    mov eax, 8  ; sys_create syscall 8
    int 0x80

    mov edx, 100
    mov ecx, writedata
    mov ebx, eax    ; eax holds our file descriptor, like a win32 handle
    mov eax, 4      ; write
    int 0x80

    call exit
    pop ebp
    ret

; ------------------------------------------------------- ;
userinput:
    push ebp
    mov ebp, esp

    mov ecx, eax
    mov eax, 3
    mov ebx, 1
    mov edx, 1024
    int 0x80

    pop ebp
    ret

exit:
    push ebp
    mov ebp, esp
    mov eax, 1
    mov ebx, 0
    int 0x80
    pop ebp
    ret

strlen:
    push ebp
    mov ebp, esp
    xor ecx, ecx
.loop:
    cmp byte [eax+ecx], 0
    je halt
    inc ecx
    jmp .loop
halt:
    mov eax, ecx


    pop ebp
    ret

print:
    push ebp
    mov ebp, esp
    push eax

    call strlen

    mov edx, eax
    pop ecx
    mov eax, 4
    mov ebx, 1
    int 0x80
    pop ebp
    ret
