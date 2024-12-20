def busca_iterativa(x, lista):
    i, j = 0, len(lista)
    while i < j:
        m = (i + j - 1) >> 1
        if lista[m] == x:
            return m
        elif lista[m] < x:
            i = m + 1
        else:
            j = m
    return None

#######  PRUEBA #########
array = [1, 3, 5, 7, 9]
elemento_a_buscar = 7
resultado = busca_iterativa(elemento_a_buscar, array)
if resultado is not None:
    print(f"El elemento {elemento_a_buscar} se encuentra en el índice {resultado}.")
else:
    print(f"El elemento {elemento_a_buscar} no está en el array.")
