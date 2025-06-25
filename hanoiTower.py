#Objetivo: mover n-1 discos para uma torre auxiliar, mover o maior disco para a torre de destino 
#e mover os n-1 discos da torre auxiliar para a torre de destino, ele faz isso por meio da recursão tentando.
#A torre de destino no início vai ser usada como auxiliar já que o primeiro objetivo é passar para a torre auxiliar

#numero mínimo de movimentos =  2^n - 1 (n sendo o número de discos) --> serve para checar se está certo

#qtd_discos (N) = quantidade de discos
#torre_inicial (A) = indica qual a torre inicial
#torre_meio (B) = indica a torre intermediária
#torre_final (C) = indica qual a torre final

def hanoi(n , inicial ='A', meio ='B', final ='C'):
    #caso base: se tiver apenas 1 disco ele deve ser movido para a torre final
    if n == 1:
        print(f'Mova disco 1, da Torre {inicial} para a Torre {final}')
    
    #se não, 2 etapas, 1- do inicial pro do meio; 2- do meio pro final:
    else:
        hanoi(n - 1, inicial, final, meio)
        print(f'Mova o disco {n}, da torre {inicial} para a torre {final}') #torre final sendo a do meio

        hanoi(n-1, meio, inicial, final ) #a inicial agora é a do meio
        
print("Insira uma quantidade de discos entre 1 e 9: ")
n = int(input())
if n > 9 or n <= 0:
    print("Número de discos inválido!")
else:
    print(f'Algoritmo da Torre de Hanoi com {n} discos') #print inicial
    hanoi(n) #usa a função recursiva
    print("Concluído!") #print final
