%include "io.mac"
section .data
    iterator DD 0
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
            mov edx, [esi + eax]

            ;eliberam ecx-ul in stiva
            push ecx
            
            ;mutam primul caracter din needle in ecx
            mov ecx, [ebx + 0]

            ;afisam pentru debug
            PRINTF32 `%c \x0`, edx

            ;scoatem ecx-ul din stiva
            pop ecx
            ;scoatem edx-ul din stiva
            pop edx

            inc eax
            mov [iterator], eax

            ;comparam iteratorul cu len stringului mare
            cmp eax, ecx

            ;jump daca nu s egale
            jne iterate

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
