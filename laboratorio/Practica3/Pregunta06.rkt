#lang racket
;Utilizando el teorema maestro, estima la complejidad del algoritmo en los dos casos siguientes:
 ;a) f(n) = Θ(n) y
 ;b) f(n) = Θ(n^2).

;Teorema maestro:
; T(n) ≤ 2·T(n/2)+f(n)

;Caso a) f(n)=Θ(n)

;Aplicamos el Teorema Maestro:

;T(n)=2⋅T(n/2)+Θ(n).

;1. a=2: número de subproblemas.

;2. b=2: factor de división (tamaño de los subproblemas).

;3. f(n)=Θ(n): coste de combinación.

;El teorema maestro compara n^logb(a)=n^log2(2)=n^1 con f(n). Dado que ambos términos son del mismo orden (Θ(n), deducimos que estamos en el caso 2 y
;podemos concluir con que T(n)=Θ(n*log(n)).

;---------------------------------------------------------------------------------------------------------------------------------------------------------

;Caso b) f(n)=Θ(n^2)

;Aplicamos el Teorema Maestro:

;T(n)=2⋅T(n/2)+Θ(n^2).

;1. a=2: número de subproblemas.

;2. b=2: factor de división (tamaño de los subproblemas).

;3. f(n)=Θ(n^2): coste de combinación.

;El teorema maestro compara n^logb(a)=n^log2(2)=n^1 con f(n). En este caso f(n) es mayor, ya que n^2 > n*log(n).Deducimos que estamos en el caso 1 y
;podemos concluir con que T(n)=Θ(n^2).