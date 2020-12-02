%include "io.mac"
section .data
    iteratorPlain DW 0
    iteratorKey DW 0
    extendedKey times 10000 resb ''
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
    keyToExtendedKey:
        mov word [iteratorPlain], 0
        mov word [iteratorKey], 0

        ;ingul
        push ebx
        mov ebx, 0
        eliminaString:
            mov [extendedKey + ebx], byte 0x00
            ; PRINTF32 `%d %d, elimin\x0`, ebx, ecx
            inc ebx
            cmp ebx, ecx
            jne eliminaString
        pop ebx

        iterate:
        ;iteram prin plaintext
        ;eax il facem 0
        xor eax, eax
 
        ;punem ebx in stiva
        push ebx
 
        ;punem in ebx iteratorul
        mov ebx, [iteratorPlain]

        ;punem in al caracterul pe care suntem in plaintext
        mov al, byte [esi + ebx]

        ;debug
        ; PRINTF32 `%c\x0`, eax

        ;scoatem ebx din stiva
        pop ebx

        ;comparam al cu A
        cmp al, 0x41
        ; daca e mai mic sarim la urmatorul caracter              
        jl found_nonletter
        ;comparam al cu Z               
        cmp al, 0x5A               
        ;daca al e intre A si Z am gasit o litera
        jle found_letter           
        ;compara al cu a
        cmp al, 0x61               
        ;sarim la urmatorul caracter
        jl found_nonletter
        ;comparam al cu z               
        cmp al, 0x7A               
        ;daca e peste Z sarim la urmatorul caracter
        jg found_nonletter              
        ;daca nu inseamna ca e intre a si z

        found_letter:
            ;punem in extended key pe pozitia iteratorPlain caracterul din key+iteratorKey
            push ebx
            push eax
            push ecx

            mov ebx, [iteratorPlain]
            mov ecx, [iteratorKey]
            mov al, [edi + ecx]
            mov [extendedKey + ebx], byte al

            pop ecx
            pop eax
            pop ebx

            inc word [iteratorKey]
            cmp [iteratorKey], ebx
            jne continue
            
            mov word [iteratorKey], 0

            continue:
            inc word [iteratorPlain]
            cmp [iteratorPlain], ecx
            jb iterate
            je final

        found_nonletter:
            inc word [iteratorPlain]
            cmp [iteratorPlain], ecx
            jb iterate

final:
; mov [extendedKey + ecx], byte 0x00
 PRINTF32 ` %s %d\x0`, extendedKey, ecx
 
;; DO NOT MODIFY
popa
leave
ret
;; DO NOT MODIFY