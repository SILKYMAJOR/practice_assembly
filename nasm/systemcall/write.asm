section .bss

section .data
    msg db "write", 0x0a
    msg_len equ $-msg 
    ERROR_WRITE db "write error", 0x0a, 0x00

section .text
    global _start

_start:
    xor rax, rax
    mov rax, 0x01 ;write
    mov rdi, 0x01 ;stdout
    mov rsi, msg
    mov rdx, msg_len
    syscall
    
    test rax, rax
    js _error_write

    jmp _exit

_error_write:
    mov rax, 0x01 ;write
    mov rdi, 0x02 ;stderror
    mov rsi, ERROR_WRITE
    mov rdx, 0x0d
    syscall

    jmp _exit

_exit:
    mov rax, 0x3c
    xor rdi, 0x01
    syscall
