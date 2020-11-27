%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher
    ; PRINTF32 `%s %s %s %s \x0` , edx, edx, esi, edi
    ;initializam cu 0 storage-ul pentru iterator
    xor ebx, ebx
    ;aici e eticheta de iterator
    iterate:
        ;initializam cu 0 registrul eax
        xor eax, eax
        ;punem in al caracterul din plaintext
        mov al, byte [esi + ebx]
        ;punem in ah caracterul din key
        mov ah, byte [edi + ebx]
        ;facem xor intre caractere
        xor al, ah
        ;punem xor-ul in ciphertext
        mov [edx + ebx], byte al
        ;incrementam contorul
        inc     ebx
        ;testam daca am ajuns la length
        cmp     ebx, ecx
        ;facem un jump conditionat de cmp-ul de mai sus
        jne     iterate
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY