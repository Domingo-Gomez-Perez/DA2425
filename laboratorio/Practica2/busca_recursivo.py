def busca(x, lista):
    return busca_aux(x, lista, 0, len(lista))
def busca_aux(x, lista, i, j):
    # Busca el elemento ‘x’ en la lista ordenada ‘lista’,
    # a partir del índice ‘i’ (incluido) y antes del ‘j’
    # (excluido).
    if i >= j: # rango vacío
        return None
    else:
        m = (i + j - 1) >> 1
        if lista[m] == x:
            return m
        elif lista[m] < x:
            return busca_aux(x, lista, m + 1, j)
        else:
            return busca_aux(x, lista, i, m)
        

lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(busca(5, lista))