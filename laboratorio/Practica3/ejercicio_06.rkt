################################################################
Caso a) f(n) = Θ(n)

En este caso:
a = 2 (hay dos subproblemas),
b = 2 (cada subproblema tiene tamaño n / 2),
f(n) = Θ(n) (el costo de dividir el problema).

El teorema maestro establece que para una recurrencia de la forma T(n) = aT(n / b) + f(n), 
comparamos f(n) con n^(log_b a) para determinar la complejidad.

Calculamos log_b a: log_b a = log_2 2 = 1

Comparamos f(n) = Θ(n) con n^(log_b a) = n:

f(n) = Θ(n) y n^(log_b a) = n, por lo que f(n) y n^(log_b a) son iguales. Esto corresponde al Caso 2 del teorema, que nos da como resultado: T(n) = Θ(n log n)
Por lo tanto, la complejidad del algoritmo en este caso es T(n) = Θ(n log n).


#################################################################
Caso b) f(n) = Θ(n^2)

En este caso:
a = 2 (hay dos subproblemas),
b = 2 (cada subproblema tiene tamaño n / 2),
f(n) = Θ(n^2) (el costo de dividir el problema).

Calculamos log_b a: log_b a = log_2 2 = 1

Comparamos f(n) = Θ(n^2) con n^(log_b a) = n:

f(n) = Θ(n^2) y n^(log_b a) = n, por lo que f(n) crece más rápido que n^(log_b a). 
Esto corresponde al Caso 3 del teorema, que nos da como resultado: T(n) = Θ(n^2)
Por lo tanto, la complejidad del algoritmo en este caso es T(n) = Θ(n^2).

#################################################################
Resumen de la complejidad:
Caso a) f(n) = Θ(n): T(n) = Θ(n log n)
Caso b) f(n) = Θ(n^2): T(n) = Θ(n^2)


