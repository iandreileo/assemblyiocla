%include "io.mac"
section .data
;daca nu merge schimba dw
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

            ;aici ar trebui sa prelucram literele conform cerintei
            
            push eax
            push ebx
            push ecx

            mov ebx, [iteratorPlain]
            mov al,  [extendedKey + ebx]
            ;in al (eax) avem cate pozitii trebuie sa mergem la dreapta
            sub al, 0x41
            ; PRINTF32 `%d \x0`, eax
            ; in cl avem caracterul
            mov cl, [ esi + ebx]
            ;acum trebuie sa mutam caracteurl cu al pozitii la dreapta
            add cl, al
            ; PRINTF32 ` cl:%c \x0`, ecx
            ; cmp cl, 0x7A
            ; ja makeConversion
            ; jmp dontMakeConversion

            cmp cl, 0x7A
            jg makeConversion
            cmp cl, 0x41
            jb makeConversion
            cmp cl, 0x5A
            jbe dontMakeConversion
            cmp cl, 0x61
            jge dontMakeConversion
            makeConversion:
                sub cl, 26 


            dontMakeConversion:
            ;mutam in plaintext
            mov [edx + ebx], cl
            ; PRINTF32 `%s \x0`, esi

            pop ecx
            pop ebx
            pop eax

            ;crestem iteratorul si mergem pe pozitia urmatoare
            inc word [iteratorPlain]
            cmp [iteratorPlain], ecx
            jb iterate
            je final
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
 
final:
mov [esi + ecx], byte 0x00

 
emptyString:
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

; PRINTF32 ` %s \x0`, edx
;; DO NOT MODIFY
popa
leave
ret
;; DO NOT MODIFY