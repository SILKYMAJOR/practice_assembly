section .bss

section .data
    msg db "write", 0x0a
    msg_len equ $-msg 

section .text
    global _start

_start:
    xor rax, rax
    mov rax, 0x01
    mov rdi, 0x01
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rax, 0x3c
    xor rdi, 0x01
    syscall
