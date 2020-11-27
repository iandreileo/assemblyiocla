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
        mov dword [iterator], 1
        iterate:
            xor eax, eax
            ;punem in eax iteratorul
            mov eax, [iterator]
            ;punem in ah caracteru curent
            ;eliberam edx-ul punandu l in stiva
            push edx
            ;mutam caracterul in edx
            mov edx, [esi + eax]

            ;eliberam ecx-ul in stiva
            push ecx
            ;mutam primul caracter din needle in ecx
            mov ecx, [ebx + 0]

            cmp edx, ecx

            je isEqual
            jne notEqual

            isEqual:
                PRINTF32 `%c aaa\x0`, ecx

            notEqual:
                ;urmatorul caracter
                inc dword [iterator]
                PRINTF32 `%d aaa\x0`, [iterator]
            
            ; PRINTF32 `%c \x0`, edx
            pop edx
            pop ecx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
