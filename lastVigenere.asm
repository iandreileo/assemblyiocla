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
            push ebx
            push eax
            push ecx

            ;punem in ebx iteratorul
            mov ebx, [iteratorPlain]
            ;punem in ecx iteratorul key
            mov ecx, [iteratorKey]
            ;punem in al caracterul din key
            mov al, [edi + ecx]

            ;punem in extendekey 
            mov [extendedKey + ebx], byte al

            pop ecx
            pop eax
            pop ebx
            
            ;crestem iteratorul pe keye
            inc word [iteratorKey]

            PRINTF32 `ebx: %d i_k: %d %d\x0`, ebx, [iteratorKey], [iteratorPlain]

            cmp [iteratorKey], ebx
            je resetIteratorKey
            jne continueIteratorKey

            resetIteratorKey:
                mov word [iteratorKey], 0
                PRINTF32 `Am ajuns\x0`,
            continueIteratorKey:
                inc word [iteratorPlain]
                cmp [iteratorPlain], ecx
                jb iterate
 
        found_nonletter:
            ; push ebx
            ; push eax
            
            ; ;punem in al caracterul din plaintext
            ; mov ebx, [iteratorPlain]
            ; mov al, [esi + ebx]
            ; mov [extendedKey + ebx], byte al
            
            ; pop eax
            ; pop ebx
            PRINTF32 `Nu trebuie aici\x0`
            inc word [iteratorPlain]
            cmp [iteratorPlain], ecx
            jb iterate

mov [extendedKey + ecx], byte 0x00
 PRINTF32 ` %s %d\x0`, extendedKey, ecx
 
;; DO NOT MODIFY
popa
leave
ret
;; DO NOT MODIFY