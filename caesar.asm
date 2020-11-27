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
    ;setam iteratorul la 0
    mov dword [iterator], 0
    ;vedem daca cheia este 0
    cmp edi, 0
    ;daca cheia e 0 sarim la urmatorul caracter
    jle next_char
iterateLetter:
    ;crestem iteratorul
    add dword [iterator], 1
    ;testam daca suntem pe z
    cmp al, 0x7A
    ;daca suntem pe z sarim pe cazul z-ului mic
    je noCapsLetter

    ;testam daca suntem pe Z
    cmp al, 0x5a
    ;daca suntem pe Z sarim pe cazul Z-ului mare
    je capsLetter

    ;daca suntem intermediar, iteram normal
    jmp final
        
;eticheta de iterat normal
final:
    ;crestem al cu 1
    inc al
    ;comparam iteratorul cu cheia
    cmp dword [iterator], edi
    ;vedem daca iteram pentru acest caracter sau sarim la urmatorul caracter
    jb iterateLetter
    jle next_char
    
;eticheta pentru iterat Z
capsLetter:
    ;punem in al A
    mov al, 0x41 
    ;comparam iteratorul cu numarul din key
    cmp dword [iterator], edi
    ;intram in bucla din nou
    jb iterateLetter

;eticheta pentru iterat z
noCapsLetter:
    ;punem in al a
    mov al, 0x61
    ;comparam iteratorul cu numarul din key
    cmp dword [iterator], edi
    ;intram in bucla din nou
    jb iterateLetter

;trecem la urmatorul char
next_char:

    ;punem litera in ciphertext
    mov [edx + ebx], byte al
    ;incrementam contorul
    inc     ebx
    ;testam daca am ajuns la length
    cmp     ebx, ecx
    ;facem un jump conditionat de cmp-ul de mai sus
    jne     iterate

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY