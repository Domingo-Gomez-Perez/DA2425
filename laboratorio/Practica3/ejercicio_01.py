import math

"""
Ejercicio 1 de la práctica 3 hecho en python para calcular 
los dos puntos más cercanos de un fichero de texto.
"""

def leer_archivo_a_lista(nombre_archivo):
    """
    Lee un archivo de texto que contiene coordenadas de puntos
    (representando cada fila un punto y siendo la columna 1
    la coordenada x y la columna 2 la coordenada y), y vuelca
    todas las coordeandas en una lista.

    Args:
        nombre_archivo (file): el archivo de texto con las coordeandas
    
    Returns:
        lista_tuplas (list): la lista con el contenido del fichero
    """
    # La lista en la que se almacenan los puntos
    lista_coordeandas = []
    
    with open(nombre_archivo, 'r') as archivo:
        # Leer todas las líneas del archivo
        lineas = archivo.readlines()
        
        # Ignorar la primera línea si contiene metadatos
        for linea in lineas[1:]:
            # Separar los valores por espacios y convertirlos a float
            valores = tuple(map(float, linea.split()))
            # Agregar la tupla a la lista
            lista_coordeandas.append(valores)
    
    return lista_coordeandas


def distancia_euc(punto1: tuple, punto2: tuple):
    """
    Calcula la distancia euclídea entre dos puntos almacenados como tuplas.

    Args:
        punto1 (tuple): el primer punto para calcular la diferencia.
        punto2 (tuple): el segundo punto dos para calcular la diferencia.
    
    Returns:
        (int): la distancia euclidea entre los dos puntos dados
    """
    return (punto1[0]-punto2[0])**2 + (punto1[1]-punto2[1])**2



def puntos_mas_cercanos_en_lista(lista: list):
    """
    Calcula los dos puntos más cercanos dentro de la lista de puntos.

    Args:
        lista (list): la lista con todos los puntos.
    
    Returns:
        punto1_minimo: el primer punto de la relación de mayor proximidad.
        punto2_minimo: el segundo punto de la relación de mayor proximidad.
    """
    # Inicializar la distancia mínima con un valor muy grande
    distancia_minima = float('inf')

    # Puntos distancia minima
    punto1_minimo = None
    punto2_minimo = None

    # Se calcula la distancia de cada punto con todos los demás
    for i in range (len(lista)):
        if i != len(lista) -1:
            for j in range (i + 1, len(lista)):
                distancia = distancia_euc(lista[i], lista[j])

                # Si se encuentra una distancia inferior a la minima registrada, se actualiza.
                if distancia < distancia_minima:
                    distancia_minima = distancia
                    punto1_minimo = lista[i]
                    punto2_minimo = lista[j]
    
    return punto1_minimo, punto2_minimo
        

# PRUEBA DEL ALGORITMO
nombre_archivo = 'ej_pts_europa.txt'  # Cambia esto por el nombre de tu archivo
lista_puntos = leer_archivo_a_lista(nombre_archivo)
# print(lista_puntos)
punto1, punto2 = puntos_mas_cercanos_en_lista(lista_puntos)
print(punto1, punto2)
