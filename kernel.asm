org 0x7e00
jmp 0x0000:start

data:
	mensagem db 'Digite uma palavra',0
    palavra1 db 'batata',0
    palavra2 db 'ceu',0

    call clear

    endl:       ;Pula uma linha, printando na tela o caractere que representa o /n
        mov al, 0x0a          ; line feed
        call putchar
        mov al, 0x0d          ; carriage return
        call putchar
        ret
    
    putchar:    ;Printa um caractere na tela, pega o valor salvo em al
        mov ah, 0x0e
        int 10h
        ret

    clear:                   ; mov bl, color
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

    prints:             ; mov si, string
    .loop:
        lodsb           ; bota character apontado por si em al 
        cmp al, 0       ; 0 é o valor atribuido ao final de uma string
        je .endloop     ; Se for o final da string, acaba o loop
        call putchar    ; printa o caractere
        jmp .loop       ; volta para o inicio do loop
    .endloop:
    ret

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    
    ;limpando a tela, em bl fica o valor da cor que vai ser utilizada na tela, 1 é o valor azul, outras cores disponíveis no tutorial
    
    mov bl, 1 
    

    ;Imprimindo na tela a mensagem declarada em data
    mov si, mensagem    ;si aponta para o começo do endereço onde está mensagem
    call prints         ;Como só é impresso um caractere por vez, pegamos uma string com N caracteres e printamos um por um em ordem até chegar ao caractere de valor 0 que é o fim da string, assim prints pega a string para qual o ponteiro si aponta e a imprime na tela até o seu final
    call endl           ;Pula uma linha, assim o próximo caractere imprimido estará na linha de baixo

   

jmp $