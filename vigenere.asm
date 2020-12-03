%include "io.mac"
section .data
    iteratorPlain DD 0
    iteratorKey DD 0
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
            ;facem modulo intre pozitia pe care suntem si lungimea cheii
            push edx
            push eax
            push ecx

            mov eax, [iteratorKey]
            mov edx, 0
            mov ecx, ebx
            div ecx

            pop ecx
            pop eax
            

            push ebx
            push eax
            ;punem iteratorul in ebx
            mov ebx, [iteratorPlain]
            ;adaugam iteratorului literelor din cheie 1
            add dword [iteratorKey], 1
            
            ;punem in cheie litera corespunzatoare
            mov al, [edi + edx]
            mov [extendedKey + ebx], byte al
            pop eax
            pop ebx
            pop edx
            
            push eax
            push ebx
            push ecx

            ;punem iteratorul in ebx
            mov ebx, [iteratorPlain]
            ;punem in al din eax caracterul din cheia extinsa pe care suntem
            mov al,  [extendedKey + ebx]
            ;in al (eax) avem cate pozitii trebuie sa mergem la dreapta
            sub al, 0x41
            ; in cl avem caracterul
            mov cl, [ esi + ebx]
            ;acum trebuie sa mutam caracteurl cu al pozitii la dreapta
            add cl, al
            ;testam daca caracterul mutat este litera
            ;daca este litera sarim la dontMakeConversions
            ;daca nu este litera sarim la makeConversion unde facem loop in alfabet
            cmp cl, 0x7A
            jg makeConversion
            cmp cl, 0x41
            jb makeConversion
            cmp cl, 0x5A
            jbe dontMakeConversion
            cmp cl, 0x61
            jge dontMakeConversion
            ;scadem 26 din caracter pentru a face loop in alfabet
            makeConversion:
                sub cl, 26 

            dontMakeConversion:
            ;mutam in cipertext
            mov [edx + ebx], cl

            pop ecx
            pop ebx
            pop eax

            ;crestem iteratorul si mergem pe pozitia urmatoare
            inc word [iteratorPlain]
            cmp [iteratorPlain], ecx
            jb iterate
            je emptyString
        ;daca nu gasim o litera o punem direct in cheia extinsa si totodata si in sirul final
        found_nonletter:
            push ebx
            push eax
            mov ebx, [iteratorPlain]
            mov al, [esi + ebx]
            mov [extendedKey + ebx], byte al
            mov [edx + ebx], byte al
            pop eax
            pop ebx
            
            inc word [iteratorPlain]
            cmp [iteratorPlain], ecx
            jb iterate

;punem null pe toate pozitile ocupate din cheia extinsa
;pentru a o putea folosi la testul urmator
emptyString:
    push ebx
    mov ebx, 0
    eliminaString:
        mov [extendedKey + ebx], byte 0x00
        inc ebx
        cmp ebx, ecx
        jne eliminaString
        pop ebx

; PRINTF32 ` %s \x0`, edx
;; DO NOT MODIFY
popa
leave
ret
;; DO NOT MODIFY