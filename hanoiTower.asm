; -----------------------------------Torre de Hanoi - Assembly x86 -----------------------------------

section .text
global _start  ;must be declared for using gcc
_start:        ;tell linker entry point

; Mensagem Inicial
mov edx, lenDisco ;tamanho da mensagem
mov ecx, mover_disco ;message para a tela
mov ebx, 1 ;stdout
mov eax, 4 ;sys_write para escrever
int 0x80 ;faz a chamada de kernel das interfaces e passa os argumentos eax, ebx, etc

; Mensagem do input
mov edx, lenInput ;ler a mensagem para o input da quantidade de discos
mov ecx, input
mov ebx, 1 ;stdout
mov eax, 4 ;sys_write para escrever
int 0x80

; Ler input
mov edx, 5 ;tamanho do espaço reservado para o número de discos
mov ecx, num ;numero de discos
mov ebx, 2
mov eax, 3 ;ler o numero de discos
int 0x80

; Salvar o input num espaço reservado
mov edx, 5
mov ecx, num
mov ebx, 1
mov eax, 4
int 0x80

;if else para ver se discos é 0
mov eax, [num] ;comparar se o valor de numero é 0 
sub eax, '0' ; transforma para inteiro para poder comparar
cmp eax, 0

;Caso o número de discos não seja 0, ele chama a função de Hanoi e pula para l1
jne l1

;Caso seja 0, ele imprime mensagem de erro e não inicia o algoritmo
mov ecx, caso_zero
    int 0x80 ;chamada de kernel
    mov eax, 1 ; system call number (sys_exit)
    int 0x80 ;chamada de kernel

l1: ;Condição que chama Hanoi
    mov eax, [num] ;carrega o número de discos
    mov ebx, "A" ;torre origem
    mov ecx, "C" ;torre destino
    mov edx, "B" ;torre auxiliar
    call hanoi

    ; Encerra o programa
    mov eax, 1 ;sys_exit
    mov ebx, 0
    int 0x80

section .bss
    num resb 5 ;reserva espaço para o número de discos

section .data
    ;Mensagem inicial
    message db "ALGORITMO DA TORRE DE HANOI", 13, 10 ;O 10 serve para pular a linha e o 13 pra iniciar a linha
    lenMessage equ $-message ;reserva o espaço da mensagem

    ; Mensagem de input
    input db "Digite uma quantidade de discos entre 1 e 9: ", 
    lenInput equ $-input ;reserva o espaço da mensagem

    ; Mensagens para o movimento dos discos
    mover_disco db "Mova o disco "
    disco db " "
    da_torre db "da torre "
    torre_origem db " "
    para_torre db " para a torre "
    torre_destino db " "
    fim_mensagem db 13

    ;Mensagem do condicional caso seja 0 e inválido
    caso_zero       db "Digite um número de discos válido", 13;
    lenCaso_zero    equ $ -caso_zero ;reserva o espaço da mensagem

    ; Mensagem final
    done_message db "Concluído!", 13 ;
    lenDisco equ $-mover_disco ;reserva o espaço da mensagem

; Função recursiva de Hanoi
hanoi:
    cmp eax, 0
    je fimHanoi ;se o número de discos for 0, fim da recursão

    push eax
    push ebx
    push ecx
    push edx

    dec eax ;decrementa o número de discos

    push ecx ;salva o destino
    mov ecx, edx ;torre de destino == torre auxiliar
    pop edx ; pega o disco da torre de destino

    call hanoi ;chamada recursiva


fimHanoi:
    ret ;retorna da função
