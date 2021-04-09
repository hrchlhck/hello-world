[BITS 16]               ; Operating with 16 bit values? 
[ORG 0x7c00]            ; Memory address where the code will be started

start:
    mov si, message     ; Moves the address of 'message' into si
    call print          ; Call print
    jmp $               ; Eternally repeat start

print:
    mov bx, 0 

.loop:
    lodsb               ; Load a char into AL
    cmp al, 0           ; Compare if it's empty
    je .done            ; if empty, jump to done
    call print_char     ; else, call print_char
    jmp .loop           ; Repeat until reach null terminator of 'message'

.done:
    ret                 ; Pop address from stack

print_char:
    mov ah, 0eh         ; Print function code
    int 0x10            ; Call BIOS
    ret                 ; Pop address from stack

message: db 'Hello, world!', 0 ; Creates a label to 'Hello, world' bytes and ends with a null terminator (0)

times 510-($ - $$) db 0    ; Fills the rest of the sector with 0
dw 0xaa55                  ; Means that the code is bootable
