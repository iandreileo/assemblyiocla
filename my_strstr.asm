%include "io.mac"

section .data
    iterator DD 0
    currentInNeedle DD 0
section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

iterateThroughHaystack:
    mov dword [iterator], 0
iterate:
    ;setam eax cu 0
    xor eax, eax

    ;punem in eax iteratorul
    mov eax, [iterator]

    ;eliberam edx-ul punandu l in stiva
    push edx

    ;mutam caracterul in edx
    mov dl, [esi + eax]

    ;eliberam ecx-ul in stiva
    push ecx

    ;eliberam edi ca sa punem currentNeedle
    push edi
            
    ;punem in edi currentInNeedle
    mov edi, [currentInNeedle]

    ;mutam caracterul curent din needle in cl
    mov cl, [ebx + edi]

    ;afisam pentru debug
    ; PRINTF32 `!!! :%d :%d %c %c it:%d cin:%d !!\x0`, ecx, edx, ecx, edx, [iterator], [currentInNeedle]

    ;comparam cele 2 caractere
    cmp ecx, edx

    ; je caractereEgale
    jne caractereNeegale

caractereEgale:
    ;scoatem din stiva
    ;pop edi
    pop edi
    ;scoatem ecx-ul din stiva
    pop ecx
    ;scoatem edx-ul din stiva
    pop edx

    ;daca currentInNeedle e 0 punem adresa in edi
    cmp word [currentInNeedle], 0
    je movNeedleInEdi
    jne dontMovInEdi

movNeedleInEdi:
    ;bagam edx in stiva
    push edx
    ;punem in edx iteratorul
    mov edx, [iterator] 
    ;mutam in edi iteratorul
    mov dword [edi], edx
    ;scoatem edx din stiva
    pop edx

dontMovInEdi:
    ;crestem currentInNeedle
    inc word [currentInNeedle]
    ;testam daca currentInNeedle este egal cu edx
    cmp [currentInNeedle], edx
    je substrGasit

    ;continuam loop-ul
    inc eax
    mov [iterator], eax

    ;comparam iteratoru cu len string
    cmp eax, ecx

    ;jne
    jne iterate

caractereNeegale:
    ;scoatem din stiva
    ;pop edi
    pop edi
    ;scoatem ecx-ul din stiva
    pop ecx
    ;scoatem edx-ul din stiva
    pop edx
    ;setam currentInNeedle cu 0
    mov word [currentInNeedle], 0

    ;crestem iteratorul
    inc eax
    mov [iterator], eax

    ;comparam iteratoru cu len string
    cmp eax, ecx

    ;jne
    jne iterate

substrNegasit:
    ;crestem length ul cu 1
    inc ecx
    ;il punem in edi
    mov dword [edi], ecx


substrGasit:
    ;am gasit substringul

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
