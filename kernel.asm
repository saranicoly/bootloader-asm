org 0x7e00
jmp 0x0000:start

data:
  mensagem db 'Digite uma palavra de 6 letras: ', 0
  mensagem_numero db 'Escolha um numero de 1 a 5: ', 0
  letras_certas db '______', 0
  sucesso db 'Parabens!! Voce conseguiu :)', 0
  falha db 'Ops, nao foi dessa vez! :/', 0
  acertos db 'Progresso: ', 0

  palavra1 db 'batata', 0
  palavra2 db 'jujuba', 0
  palavra3 db 'rodada', 0
  palavra4 db 'rodape', 0
  palavra5 db 'amigos', 0

  X times 8 db 0
  numero times 5 db 0

putchar:
  mov ah, 0x0e
  int 10h
  ret
  
getchar:
  mov ah, 0x00
  int 16h
  ret
  
delchar:
  mov al, 0x08          ; backspace
  call putchar
  mov al, ' '
  call putchar
  mov al, 0x08          ; backspace
  call putchar
  ret
  
endl:
  mov al, 0x0a          ; line feed
  call putchar
  mov al, 0x0d          ; carriage return
  call putchar
  ret

prints:             ; mov si, string
  .loop:
    lodsb           ; bota character em al 
    cmp al, 0
    je .endloop
    call putchar
    jmp .loop
  .endloop:
  ret
  
gets:                 ; mov di, string
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
  
strcmp:              ; mov si, string1, mov di, string2
  .loop1:
    lodsb
    cmp al, byte[di]
    jne .notequal
    cmp al, 0
    je .equal
    inc di
    jmp .loop1
  .notequal:
    clc
    ret
  .equal:
    stc
    ret

charcmp:
  xor bx, bx
  mov bx, 0
  .loop:
    lodsb
    cmp al, 0 ; se a palavra acabou
    je .acabou
    cmp al, byte[di]
    je .equal

    mov al, '_'
    mov byte[letras_certas+bx], al

    .equal:
      mov byte[letras_certas+bx], al
    inc di
    inc bx
    jmp .loop
  .acabou:
    stc
ret


start:
    xor ax, ax    ;limpando ax
    mov ds, ax    ;limpando ds
    mov es, ax    ;limpando es

  .escolha_numero:
      mov si, mensagem_numero
      call prints

      mov di, numero
      call gets
      call endl
      cmp byte[numero], '5'
      jg .escolha_numero ; se for maior que 5
      cmp byte[numero], '1'
      jl .escolha_numero ; se for menor que 1

      cmp byte[numero], '1'
      je .p1
      cmp byte[numero], '2'
      je .p2
      cmp byte[numero], '3'
      je .p3
      cmp byte[numero], '4'
      je .p4
      cmp byte[numero], '5'
      je .p5

 .p1:
    ;Imprimindo na tela a mensagem declarada em data
    mov si, mensagem    ;si aponta para o começo do endereço onde está mensagem
    call prints         ;Como só é impresso um caractere por vez, pegamos uma string com N caracteres e printamos um por um em ordem até chegar ao caractere de valor 0 que é o fim da string, assim prints pega a string para qual o ponteiro si aponta e a imprime na tela até o seu final

    ;Lendo o valor de X
    mov di, X           ;di aponta para o começo do endereço onde está X
    call gets           ;gets salva no endereço apontado por di cada caractere lido do teclado até o enter
    call endl

    mov si, X

    mov di, palavra1
    call strcmp
    je .sucesso
    mov si, falha
    call prints
    call endl

    mov si, X
    mov di, palavra1
    call charcmp
    mov si, acertos
    call prints

    mov si, letras_certas
    call prints
    call endl
    call endl

    jmp .p1

    jmp done
     
 .p2:
    ;Imprimindo na tela a mensagem declarada em data
    mov si, mensagem    ;si aponta para o começo do endereço onde está mensagem
    call prints         ;Como só é impresso um caractere por vez, pegamos uma string com N caracteres e printamos um por um em ordem até chegar ao caractere de valor 0 que é o fim da string, assim prints pega a string para qual o ponteiro si aponta e a imprime na tela até o seu final

    ;Lendo o valor de X
    mov di, X           ;di aponta para o começo do endereço onde está X
    call gets           ;gets salva no endereço apontado por di cada caractere lido do teclado até o enter
    call endl

    mov si, X

    mov di, palavra2
    call strcmp
    je .sucesso
    mov si, falha
    call prints
    call endl

    mov si, X
    mov di, palavra2
    call charcmp
    mov si, acertos
    call prints

    mov si, letras_certas
    call prints
    call endl
    call endl

    jmp .p2

    jmp done

 .p3:
    ;Imprimindo na tela a mensagem declarada em data
    mov si, mensagem    ;si aponta para o começo do endereço onde está mensagem
    call prints         ;Como só é impresso um caractere por vez, pegamos uma string com N caracteres e printamos um por um em ordem até chegar ao caractere de valor 0 que é o fim da string, assim prints pega a string para qual o ponteiro si aponta e a imprime na tela até o seu final

    ;Lendo o valor de X
    mov di, X           ;di aponta para o começo do endereço onde está X
    call gets           ;gets salva no endereço apontado por di cada caractere lido do teclado até o enter
    call endl

    mov si, X

    mov di, palavra3
    call strcmp
    je .sucesso
    mov si, falha
    call prints
    call endl

    mov si, X
    mov di, palavra3
    call charcmp
    mov si, acertos
    call prints

    mov si, letras_certas
    call prints
    call endl
    call endl

    jmp .p3

    jmp done
     
 .p4:
    ;Imprimindo na tela a mensagem declarada em data
    mov si, mensagem    ;si aponta para o começo do endereço onde está mensagem
    call prints         ;Como só é impresso um caractere por vez, pegamos uma string com N caracteres e printamos um por um em ordem até chegar ao caractere de valor 0 que é o fim da string, assim prints pega a string para qual o ponteiro si aponta e a imprime na tela até o seu final

    ;Lendo o valor de X
    mov di, X           ;di aponta para o começo do endereço onde está X
    call gets           ;gets salva no endereço apontado por di cada caractere lido do teclado até o enter
    call endl

    mov si, X

    mov di, palavra4
    call strcmp
    je .sucesso
    mov si, falha
    call prints
    call endl

    mov si, X
    mov di, palavra4
    call charcmp
    mov si, acertos
    call prints

    mov si, letras_certas
    call prints
    call endl
    call endl

    jmp .p4

    jmp done
     
 .p5:
    ;Imprimindo na tela a mensagem declarada em data
    mov si, mensagem    ;si aponta para o começo do endereço onde está mensagem
    call prints         ;Como só é impresso um caractere por vez, pegamos uma string com N caracteres e printamos um por um em ordem até chegar ao caractere de valor 0 que é o fim da string, assim prints pega a string para qual o ponteiro si aponta e a imprime na tela até o seu final

    ;Lendo o valor de X
    mov di, X           ;di aponta para o começo do endereço onde está X
    call gets           ;gets salva no endereço apontado por di cada caractere lido do teclado até o enter
    call endl

    mov si, X

    mov di, palavra5
    call strcmp
    je .sucesso
    mov si, falha
    call prints
    call endl

    mov si, X
    mov di, palavra5
    call charcmp
    mov si, acertos
    call prints

    mov si, letras_certas
    call prints
    call endl
    call endl

    jmp .p5

    .sucesso:
      mov si, sucesso
      call prints
      call endl
      jmp done

done:
    jmp $