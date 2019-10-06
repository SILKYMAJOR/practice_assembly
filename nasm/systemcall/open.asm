section .bss

section .data
    FILE db "/tmp/file.txt", 0x00
    
    ERROR_OPEN  db "open error", 0x0a, 0x00

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
    
    jmp _close

_error_open:
    mov rax, 0x01 ;write
    mov rdi, 0x02 ;stderror
    mov rsi, ERROR_OPEN
    mov rdx, 0x0d
    syscall

    jmp _exit 

_close:
    mov rax, 0x03 ;close
    pop rdi       ;fd
    syscall

    jmp _exit

_exit:
    mov rax, 0x3c
    mov rdi, 0x00
    syscall

