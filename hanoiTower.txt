; -----------------------------------Torre de Hanoi - Assembly x86 -----------------------------------
;Dupla: Eduarda Rodrigues e Isabelle Tenório

section .text
global _start 
_start:        

    ;Mensagem Inicial
    mov edx, lenMensagem ;tamanho da mensagem
    mov ecx, mensagem ;message para a tela
    mov ebx, 1 ;stdout
    mov eax, 4 ;sys_write para escrever
    int 0x80 ;faz a chamada de kernel das interfaces e passa os argumentos eax, ebx, etc

    ;Mensagem do input
    mov edx, lenInput ;ler a mensagem para o input da quantidade de discos
    mov ecx, input
    mov ebx, 1 ;stdout
    mov eax, 4 ;sys_write para escrever
    int 0x80

    ;Ler input
    mov edx, 2 ;tamanho do espaço reservado para o número de discos
    mov ecx, num ;numero de discos
    mov ebx, 0
    mov eax, 3 ;ler o numero de discos
    int 0x80

    ;if else para ver se discos é 0
    movzx eax, byte [num] ;comparar se o valor de numero é 0, movzx para ler apenas o primeiro byte 
    sub eax, '0' ; transforma para inteiro para poder comparar
    cmp eax, 0
    
    jne l1 ;Caso o número de discos não seja 0, ele chama a função de Hanoi e pula para l1
    
    ;Caso seja 0, ele imprime mensagem de erro e não inicia o algoritmo
    mov edx, lenCaso_zero
    mov ecx, caso_zero
    mov ebx, 1
    mov eax, 4
    int 0x80
    jmp fim ;pula para as linhas que finalizam o código   

l1: ;Condição que chama Hanoi
    movzx eax, byte [num]
    sub eax, '0'
    mov ebx, "A" ;torre origem
    mov ecx, "C" ;torre destino
    mov edx, "B" ;torre auxiliar
    call hanoi

    mov edx, lenDone;ler a mensagem para o input da quantidade de discos
    mov ecx, done_message
    mov ebx, 1 ;stdout
    mov eax, 4 ;sys_write para escrever
    int 0x80
    
fim: ;Encerra o programa
    mov eax, 1 ;sys_exit
    mov ebx, 0
    int 0x80

section .bss
    num resb 2 ;reserva espaço para o número de discos

section .data
    ;Mensagem inicial
    mensagem db "ALGORITMO DA TORRE DE HANOI - by Duda & Belle", 13, 10 ;O 10 serve para pular a linha e o 13 pra iniciar a linha
    lenMensagem equ $-mensagem ;reserva o espaço da mensagem

    ;Mensagem de input
    input db "Digite uma quantidade de discos entre 1 e 9: ", 13
    lenInput equ $-input ;reserva o espaço da mensagem

    ;Mensagens para o movimento dos discos
    mover_disco db "Mova o disco "
    disco db "0"
    db " da torre "
    torre_origem db "A"
    db " para a torre "
    torre_destino db "B", 10
    lenMoverDisco equ $-mover_disco

    ;Mensagem do condicional caso seja 0 e inválido
    caso_zero       db "Digite um número de discos válido quando for rodar o programa novamente :("
    lenCaso_zero    equ $ -caso_zero ;reserva o espaço da mensagem

    ;Mensagem final
    done_message db 10, "Concluído! :)", 13 ;
    lenDone equ $-done_message
   

;Função recursiva de Hanoi
hanoi:
    cmp eax, 0
    je fimHanoi ;se o número de discos for 0, fim da recursão

    push eax
    push ebx
    push ecx
    push edx

    dec eax ;decrementa o número de discos em 1

    push ecx ;salva o destino
    mov ecx, edx ;torre de destino == torre auxiliar
    pop edx ; pega o disco da torre de destino

    call hanoi

    ;restauração dos valores originais dos registradores antes da chamada recursiva
    pop edx
    pop ecx
    pop ebx
    pop eax

    ;salvar o estado atual dos registradores antes de modificá-los
    push eax
    push ebx
    push ecx
    push edx

    ;montar a mensagem que será impressa na tela
    add al, '0'
    mov [disco], al ;armazena o valor do reg al
    mov [torre_origem], bl ;armazena o valor do reg bl
    mov [torre_destino], cl ;armazena o valor do reg cl

    mov edx, lenMoverDisco ;ler a mensagem para o input da quantidade de discos
    mov ecx, mover_disco
    mov ebx, 1 ;stdout
    mov eax, 4 ;sys_write para escrever
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax

    dec eax ;decrementa o número de discos em 1

    push edx ;salva o destino
    mov edx, ebx ;torre de destino == torre auxiliar
    pop ebx ; pega o disco da torre de destino

    call hanoi ;chamada recursiva


fimHanoi:
    ret ;retorna da função