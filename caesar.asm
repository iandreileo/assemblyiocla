%include "io.mac"

section .data
    iterator DD 0

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher
    xor ebx, ebx
iterate:
    ;initializam cu 0 registrul eax
    xor eax, eax
    ;punem in al caracterul din plaintext
    mov al, byte [esi + ebx]

    ;testam daca al este litera
    mov dword [iterator], 0
    cmp al, 0x41               ; compare al with "A"
    jl next_char               ; jump to next character if less
    cmp al, 0x5A               ; compare al with "Z"
    jle found_letter           ; if al is >= "A" && <= "Z" -> found a letter
    cmp al, 0x61               ; compare al with "a"
    jl next_char               ; jump to next character if less (since it's between "Z" & "a")
    cmp al, 0x7A               ; compare al with "z"
    jg next_char               ; above "Z" -> not a character


found_letter:
    ;setam iteratorul la 0
    mov dword [iterator], 0
    cmp edi, 0
    jle next_char
iterateLetter:
    ;crestem iteratorul
    add dword [iterator], 1
    ;testam daca suntem pe z
    cmp al, 0x7A
    je noCapsLetter

    ;testam daca suntem pe Z
    cmp al, 0x5a
    je capsLetter

    jmp final
        
    final:
        inc al
        cmp dword [iterator], edi
        jb iterateLetter
        jle next_char

    capsLetter:
        mov al, 0x41 
        ;comparam iteratorul cu numarul din key
        cmp dword [iterator], edi
        jb iterateLetter

    noCapsLetter:
        mov al, 0x61
        ;comparam iteratorul cu numarul din key
        cmp dword [iterator], edi
        jb iterateLetter

     
next_char:

    ;punem litera in ciphertext
    mov [edx + ebx], byte al
    ;incrementam contorul
    inc     ebx
    ;testam daca am ajuns la length
    cmp     ebx, ecx
    ;facem un jump conditionat de cmp-ul de mai sus
    jne     iterate

    PRINTF32 `%s\x0`, edx
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY