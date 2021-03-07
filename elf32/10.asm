; HOW COMMAND LINE ARGS WORK
; when you do ./a.out arg1 arg2 arg3
; the stack:
;
; +-------+
; |   4   |
; +-------+
; |./a.out|
; +-------+
; | arg1  |
; +-------+
; | arg2  |
; +-------+
; | arg3  |
; +-------+
;
; remember how we access cmd args in c/c++?
; int main(int argc, char** argv, char** envp) {}
;
; the first value pushed on the stack is argc, the count of arguments
; the next values on the stack are pointers to the args(remember how **argv is a pointer to an array)
;
section .text
global _start:
_start:
    pop ecx ; the first value on the stack is the number of arguments, (int argc)
    pop edx ; next value on the stack is the program name, (./a.out) || argv[0]
    ; ecx was holding the number of arguments
    dec ecx ; dec ecx by one (number of arguments without the program name)
    xor edx, edx    ; init our data register to hold values for addition
nextArg:
    cmp ecx, 0  ; check
    je noargs
    pop eax     ; pop the next argument off the stack and into eax
    call atoi
    add edx, eax    ; perform addition
    dec ecx         ; decrement counter for number of values in argv
    jmp nextArg

noargs:
    mov eax, edx    ; mov the total into our eax register, it is currently stored in edx
    call intprint
    call exit

print:
    ; the order in which registers are pushed on to the stack are important
    push edx
    push ecx
    push ebx
    push eax    ; last in first out, eax will be on the top of the stack
        ; so eax will be the first value popped off

    call strlen ; call strlen function
        ; eax == length of string
        ; mov edx, eax because edx will contain the len
        ; pop eax to restore value on the top of the stack

    mov edx, eax ; len

    pop eax ; we will mov eax, msg
            ; then push that on to the stack last, which means it will be on the top of the stack
        ; when we pop eax and restore the value, it will equal the string we want to print

    mov ecx, eax ; pointer to string in data

    ; write stdout
    mov eax, 4
    mov ebx, 1
    int 0x80

    ; values are restored in corresponding reversed order to when they were pushed
    pop ebx
    pop ecx
    pop edx
    ret

printNL:
    call print
    push eax    ; preserve eax
    mov eax, 0x0A ; null terminating string, basically 13, 10, or a \n
    push eax        ; push \n on the top of the stack
    mov eax, esp    ; change eax to stack pointer, pointer to the \n or the top of the stack
    call print      ; call print
    pop eax         ; remove \n from the stack
    pop eax         ; restore eax og value
    ret             ; end, return to our main program

intprint:
    ; preserve values of registers
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0  ; counter for our loop

; the div and idiv work by multiplying the provided register with eax. idiv ebx == ebx % eax
; values will be stored by the quotient being left in EAX and the remainder put into EDX
; EDX was originally used as a register for holding data, but those darn kids now use it for anything

divLoop:
    inc ecx ; increment instruction counter
    xor edx, edx ; empty edx
    mov esi, 10
    idiv esi    ; divide esi with eax
    add edx, 48 ; convert edx to ascii representation of integer?
    ; edx holds remainder of div instruction, rememeber!!

    push edx    ; save
    cmp eax, 0  ; can the integer be divided anymore?
    jne divLoop

printLoop:
    dec ecx         ; decrement counter
    mov eax, esp    ; mov stack pointer into eax for printing?
    call print      ; call print func
    pop eax         ; remove last char from stack to move esp forward
    cmp ecx, 0      ; have we printed all bytes pushed on to stack?
    jne printLoop   ; jump to if NOT equals

    pop esi
    pop edx
    pop ecx
    pop eax
    ret         ; restore values from the start

exit:
    push ebp
    mov ebp, esp
    mov eax, 1
    mov ebx, 0
    int 0x80
    pop ebp
    ret

atoi:
    push ebp
    mov ebp, esp

    ; save state of registers
    push ebx
    push ecx
    push edx
    push esi

    mov esi, eax    ; eax will be pointing to our number in memory
    ; clear
    xor eax, eax
    xor ecx, ecx

.loop:
    xor ebx, ebx
    ; the reason we use 8 bit registers to hold our integer value is because we only want a single byte
    ; which is 8 bits, we only need to represent one ascii byte, so if we were to use 32/64 bit registers
    ; it would have copied 8 bits of data into 32 bits of space, which leaves us with junk
    ; only the first 8 bits would be meaningful for our calculator, so we use an 8 bit register
    mov bl, [esi+ecx] ; esi points to our string, as we ecx++/inc ecx, we will iterate through the
                    ; values provided by our "mov esi, eax"

    cmp bl, 48  ; check if within integer ascii range?
    jl .halt    ; jump less than
    cmp bl, 57  ; check
    jg .halt    ; jump greater than

    sub bl, 48  ; change value into decimal representation
    add eax, ebx ; ebx == 0???, what is the purpose of this, there is no reason for this to be here
    mov ebx, 10
    mul ebx ; multiply with eax to get place value
    inc ecx ; inc > add
    jmp .loop

.halt:
    cmp ecx, 0  ; check if no more arguments
    je .restore
    mov ebx, 10
    div ebx

.restore:
    pop esi
    pop edx
    pop ecx
    pop ebx

    pop ebp
    ret

strlen:
    push ebp
    mov ebp, esp

    push ebx ; ebx points to string in memory
    mov ebx, eax
next:
    cmp byte [eax], 0   ; check if reached end of string
    je finished
    inc eax     ; iterate to next char in string
    jmp next
finished:
    sub eax, ebx
    pop ebx
    pop ebp
    ret

