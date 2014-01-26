[BITS 32]

EXTERN scrollup, print
EXTERN kX, kattr
GLOBAL _start

_start:

    mov  eax, 25
    push eax
    call scrollup

    mov eax, kX
    mov [eax], dword 1

    mov eax, kattr
    mov [eax], dword 0x4E

    mov  eax, msg
    push eax
    call print
    pop  eax

end:
    jmp end

msg  db 'The kernel has started', 10, 0

