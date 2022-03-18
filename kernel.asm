org 0x7e00
jmp 0x0000:start

data:
    mensagem db 'Digite uma palavra', 0
    palavra db 'batata', 0
    X times 10 db 0

    putchar:    ;Printa um caractere na tela, pega o valor salvo em al
        mov ah, 0x0e
        int 10h
    ret
    
    getchar:    ;Pega o caractere lido no teclado e salva em al
        mov ah, 0x00
        int 16h
    ret

    delchar:    ;Deleta um caractere lido no teclado
        mov al, 0x08          ; backspace
        call putchar
        mov al, ' '
        call putchar
        mov al, 0x08          ; backspace
        call putchar
    ret
  
    endl:       ;Pula uma linha, printando na tela o caractere que representa o /n
        mov al, 0x0a          ; line feed
        call putchar
        mov al, 0x0d          ; carriage return
        call putchar
    ret

    gets:                 ; mov di, string, salva na string apontada por di, cada caractere lido na linha   
        xor cx, cx          ; zerar contador
        .loop1:
            call getchar
            cmp al, 0x08      ; backspace
            je .backspace
                cmp al, 0x0d      ; carriage return
            je .done
                cmp cl, 10        ; string limit checker
            je .loop1
    
        stosb
        inc cl
        call putchar
    
        jmp .loop1
        .backspace:
        cmp cl, 0       ; is empty?
        je .loop1
            dec di
            dec cl
            mov byte[di], 0
            call delchar
        jmp .loop1
        .done:
            mov al, 0
            stosb
            call endl
    ret

    cmpzinho:
        lodsb
        cmp al, byte[di]
        jne .notequal
        cmp al, byte[di]
        je .equal
        inc di
        .notequal:
            clc
            ret
        .equal:
            stc
    ret



    print_string_color:
        .loop:
            lodsb           ; bota character apontado por si em al 
            cmp al, 0       ; 0 é o valor atribuido ao final de uma string
            je .endloop     ; Se for o final da string, acaba o loop
            call cmpzinho   ; compara caractere
            je .certo
            mov ah, 09h
            mov bl, 4
            int 10h
            jmp .loop
            .certo:
                mov ah, 09h
                mov bl, 2
                int 10h
            jmp .loop       ; volta para o inicio do loop
        .endloop:
    ret

    strcmp:
        .loop1:
            lodsb
            cmp al, byte[di]
            je .equal
            jne .notequal
            cmp al, 0   ; 0 é o valor atribuido ao final de uma string
            je .finish
            inc di
            jmp .loop1
        .notequal:
            mov ah, 09h
            mov bl, 4
            int 10h
            clc
        ret
        .equal:
            mov ah, 09h
            mov bl, 2
            int 10h
        ret
        .finish:
            call endl
            stc
    ret

    prints:
        .loop:
            lodsb           ; bota character apontado por si em al 
            cmp al, 0       ; 0 é o valor atribuido ao final de uma string
            je .endloop     ; Se for o final da string, acaba o loop
            call putchar    ; printa o caractere
            jmp .loop       ; volta para o inicio do loop
        .endloop:
    ret

    clear:
        ; set the cursor to top left-most corner of screen
        mov dx, 0 
        mov bh, 0      
        mov ah, 0x2
        int 0x10

        ; print 2000 blank chars to clean  
        mov cx, 2000 
        mov bh, 0
        mov al, 0x20 ; blank char
        mov ah, 0x9
        int 0x10
        
        ; reset cursor to top left-most corner of screen
        mov dx, 0 
        mov bh, 0      
        mov ah, 0x2
        int 0x10
    ret

start:
    xor ax, ax    ;limpando ax
    mov ds, ax    ;limpando ds
    mov es, ax    ;limpando es

    ;Imprimindo na tela a mensagem declarada em data
    mov si, mensagem    ;si aponta para o começo do endereço onde está mensagem
    call prints         ;Como só é impresso um caractere por vez, pegamos uma string com N caracteres e printamos um por um em ordem até chegar ao caractere de valor 0 que é o fim da string, assim prints pega a string para qual o ponteiro si aponta e a imprime na tela até o seu final
    call endl           ;Pula uma linha, assim o próximo caractere imprimido estará na linha de baixo

.leitura:
    ;Lendo o valor de X
    mov di, X           ;di aponta para o começo do endereço onde está X
    call gets           ;gets salva no endereço apontado por di cada caractere lido do teclado até o enter
    call endl

    mov si, X
    mov di, palavra
    call print_string_color
    je done             ;se for igual, ganhou (não entrou no notequal)

    call endl
    jmp .leitura        ;se não for igual, tenta dnv

done:
    jmp $