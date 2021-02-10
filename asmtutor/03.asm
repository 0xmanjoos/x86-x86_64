section .data
    msg1: db "Hello yeh chunky fecker!", 0

    ; using different method to calculate string length
    ; i guess we'll be doing this the hard way with pointer arithmetic instead of letting the assembler
    ; do it for us ;/

section .text
global _start
_start:
    mov ebx, msg1
    mov eax, ebx
    ; create two pointers that point to the same location in memory
    ; to our msg1 string or char* idk how nasm interprets this

nextChar:
    ; compare the first byte eax points to with 0, then increment
    ; this goes on until cmp byte [eax], 0 == 0, then jz will take the jump
    cmp byte [eax], 0   ; compare the byte eax is pointing to with 0. basically cmp eax, 0 just fancy
                        ; square brackets mean take result & treat as an address to a location in memory
    jz finished         ; if zero flag is set, it will jump to finished
    inc eax             ; if not finished, increment eax by 1
    jmp nextChar        ; and repeat the loop


; more labels they act like functions i guess
finished:
    sub eax, ebx        ; subtract the address in ebx with eax?

; both addresses WERE pointing to the same place in memory, to our string
; eax is being incremented by 1 byte each time, which means we can determine len of string when it ends
; when you subtract addresses with each other, you result in the number of segments between each
; || number of bytes

    ; edx is now equal to eax, so edx will hold the length of the string
    mov edx, eax    ; value of eax, ebx = [address] ; eax = eax+len(msg1)-ebx
                                     ; in this case, len() function is our nextChar label inc'ing
    mov ecx, msg1 ; point to msg
    mov eax, 4 ; write stdout
    mov ebx, 1
    int 0x80

    mov eax, 1
    mov ecx, 0
    int 0x80
    ; exit with 0
