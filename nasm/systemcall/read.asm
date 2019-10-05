section .bss
    len equ 0x400 
    buffer resb 0x400

section .data
    FILE db "/tmp/file.txt", 0x00
    
    ERROR_OPEN  db "Cannot open", 0x0a, 0x00
    ERROR_READ  db "Cannot read", 0x0a, 0x00
    ERROR_WRITE db "Cannot write", 0x0a, 0x00

section .text
    global _start

_start:
    xor rax, rax
    mov rax, 0x02 ;open
    mov rdi, FILE
    mov rsi, 0x00 ;O_RDONLY
    syscall
    
    test rax, rax 
    js _error_open
    
    mov rdi, rax
    push rax
    mov rax, 0x00 ;read
    mov rsi, buffer
    mov rdx, len
    syscall

    test rax, rax
    js _error_read

    mov rax, 0x01 ;write
    mov rdi, 0x01 ;stdout
    mov rsi, buffer
    mov rdx, len
    syscall

    test rax, rax
    js _error_write

    jmp _close

_error_open:
    mov rax, 0x01 ;write
    mov rdi, 0x02 ;stderror
    mov rsi, ERROR_OPEN
    mov rdx, 0x0d
    syscall

    jmp _exit 

_error_read:
    mov rax, 0x01 ;write
    mov rdi, 0x02 ;stderror
    mov rsi, ERROR_READ
    mov rdx, 0x0d
    syscall

    jmp _close
 
_error_write:
    mov rax, 0x01 ;write
    mov rdi, 0x02 ;stderror
    mov rsi, ERROR_WRITE
    mov rdx, 0x0e
    syscall

    jmp _close 

_close:
    mov rax, 0x03 ;close
    pop rdi       ;fd
    syscall

    jmp _exit

_exit:
    mov rax, 0x3c
    mov rdi, 0x00
    syscall
