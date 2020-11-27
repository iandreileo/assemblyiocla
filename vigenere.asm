%include "io.mac"
section .data
    iterator DD 0
section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
    xor ebx, ebx
    keyToExtendedKey:
        PRINTF32 `Equal %s    %s\x0`, esi, edi

        ;iteram prin plaintext
        xor eax, eax
        mov al, byte [edx + ebx]
        ;comparam al cu A
        cmp al, 0x41
        ; daca e mai mic sarim la urmatorul caracter              
        jl next_char
        ;comparam al cu Z               
        cmp al, 0x5A               
        ;daca al e intre A si Z am gasit o litera
        jle found_letter           
        ;compara al cu a
        cmp al, 0x61               
        ;sarim la urmatorul caracter
        jl next_char
        ;comparam al cu z               
        cmp al, 0x7A               
        ;daca e peste Z sarim la urmatorul caracter
        jg next_char              
        ;daca nu inseamna ca e intre a si z


        found_letter:
            ;prelucram litera
        
        next_char:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY