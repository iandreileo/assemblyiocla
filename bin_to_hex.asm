%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex
    PRINTF32 `%s \x0`, esi

    ; mov ax, word ecx
    mov bx, 4
    div bx
    PRINTF32 `%u \x0`, ebx    

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY