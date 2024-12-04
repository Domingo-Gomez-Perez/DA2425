def busca(x, lista):
    return busca_aux(x, lista, 0, len(lista))


def busca_aux(x, lista, i, j):
    # Busca el elemento ‘x’ en la lista ordenada ‘lista’,
    # a partir del índice ‘i’ (incluido) y antes del ‘j’
    # (excluido).
    if i >= j:  # rango vacío
        return None
    else:
        m = (i + j - 1) >> 1
        if lista[m] == x:
            return m
        elif lista[m] < x:
            return busca_aux(x, lista, m + 1, j)
        else:
            return busca_aux(x, lista, i, m)


def busqueda_binaria(x, lista):
    """Realiza la búsqueda binaria en una lista ordenada.

    Args:
        lista (list): La lista ordenada en la que buscar.
        objetivo (int): El valor que se busca.

    Returns:
        int: El índice del objetivo en la lista, o -1 si no se encuentra.
    """
    izquierda, derecha = 0, len(lista) - 1

    while izquierda <= derecha:
        medio = (izquierda + derecha) >> 1  # Índice medio

        if lista[medio] == x:
            return medio  # Elemento encontrado
        elif lista[medio] < x:
            izquierda = medio + 1  # Ignorar la mitad izquierda
        else:
            derecha = medio - 1  # Ignorar la mitad derecha

    return None  # Elemento no encontrado


# pruebas

lista_ordenada = [1, 3, 5, 7, 9, 11, 13]
resultado = busqueda_binaria(1, lista_ordenada)
resultado2 = busca(1, lista_ordenada)
print(f"{resultado} y {resultado2}")

resultado = busqueda_binaria(13, lista_ordenada)
resultado2 = busca(13, lista_ordenada)
print(f"{resultado} y {resultado2}")

resultado = busqueda_binaria(7, lista_ordenada)
resultado2 = busca(7, lista_ordenada)
print(f"{resultado} y {resultado2}")

resultado = busqueda_binaria(15, lista_ordenada)
resultado2 = busca(15, lista_ordenada)
print(f"{resultado} y {resultado2}")

resultado = busqueda_binaria(8, lista_ordenada)
resultado2 = busca(8, lista_ordenada)
print(f"{resultado} y {resultado2}")

lista_ordenada = []
resultado = busqueda_binaria(1, lista_ordenada)
resultado2 = busca(1, lista_ordenada)
print(f"{resultado} y {resultado2}")

lista_ordenada = [2]
resultado = busqueda_binaria(2, lista_ordenada)
resultado2 = busca(2, lista_ordenada)
print(f"{resultado} y {resultado2}")
