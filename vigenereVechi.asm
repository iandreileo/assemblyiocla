%include "io.mac"
section .data
    iteratorPlain DW 0
    iteratorKey DW 0
    extendedKey times 10000 resb ""
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

        ;golim stringul
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

        cmp [iteratorPlain], ebx
        ;adaugam in extendedKey din key cu bucla
        jge addCharToKey
        ;adaugam in extendedKey ce e in chei
        jmp noAddChar
 
        addCharToKey:
 
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
                ;eliberam registrii
                push ebx
                push ecx
                push eax
 
                ;punem in ecx pozitia din cheie
                mov ecx, [iteratorKey]
 
                ;punem in ebx pozitia din plainText
                mov ebx, [iteratorPlain]
 
                ;punem in al caracterul de care avem nevoie din cheie
                mov al, [edi + ecx]
 
                PRINTF32 `%d \x0`, ebx
                ;punem in extendedKey pe pozitia curenta al-ul
                mov [extendedKey + ebx], byte al
                ; PRINTF32 `Inauntru: %c \x0`,  [extendedKey + ebx]
 
                pop eax
                pop ecx
                pop ebx

                ;mutam iterator key
                ; inc word [iteratorKey]
                cmp [iteratorKey], ebx

                je iteratorKeyJump0
                jne continueIteratorKey

                iteratorKeyJump0:
                mov word [iteratorKey], 0
    

                continueIteratorKey:
                mov word [iteratorKey], 0
                inc word [iteratorPlain]
                cmp [iteratorPlain], ecx
                jb iterate
 
            next_char:
                ; PRINTF32 `%d \x0`, [iteratorPlain]   
                push ebx
                push ecx
                push eax
 
                ;punem in ecx pozitia din cheie
                mov ecx, [iteratorKey]
 
                ;punem in ebx pozitia din plainText
                mov ebx, [iteratorPlain]
 
                ;punem in al caracterul de care avem nevoie din cheie
                mov al, [esi + ebx]
 
                PRINTF32 `%d \x0`, ebx
                ;punem in extendedKey pe pozitia curenta al-ul
                mov [extendedKey + ebx], byte al
                ; PRINTF32 `Inauntru: %c \x0`,  [extendedKey + ebx]
 
                pop eax
                pop ecx
                pop ebx
                inc word [iteratorPlain]
                cmp [iteratorPlain], ecx
                jb iterate
 
        noAddChar:
            ; PRINTF32 `Cpoiem din key%d \x0`, [iteratorPlain]

            push ebx
            push eax

            mov ebx, [iteratorPlain]
            mov al, [edi + ebx]
            mov [extendedKey + ebx], byte al

            pop eax
            pop ebx

            inc word [iteratorPlain]
            cmp [iteratorPlain], ecx
            jb iterate


mov [extendedKey + ecx], byte 0x00
 PRINTF32 `%s %d\x0`, extendedKey, ecx
 
;; DO NOT MODIFY
popa
leave
ret
;; DO NOT MODIFY