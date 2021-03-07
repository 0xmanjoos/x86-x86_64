slen:
    push ebp
    mov ebp, esp

nextChar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextChar

finished:
    sub eax, ebx
    pop ebx
    ret
; END


; void sprint();
; takes a string parameter or a pointer to one
sprint:
    ; save register state so we dont mess it up
    push edx
    push ecx
    push ebx
    push eax

    call slen
    mov edx, eax    ; edx == string length
    pop eax         ; restore the original value of eax

    ; ecx len??
    mov ecx, eax
    mov eax, 4  ; write stdout
    mov ebx, 1
    int 0x80

    pop ebx
    pop ecx
    pop edx
    ret         ; return execution
; END


quit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    ret         ; END
