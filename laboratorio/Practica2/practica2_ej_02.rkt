; EJERCICIO 2
; Hecho por: Miguel Martín, Sergio Lanza, Alvaro Gonzalez, David Ruiz del Corro

; Cota superior para cantidad de llamadas es log2(n) donde n es la longitud de la lista.

; La complejidad espacial de este algoritmo está relacionada con el número de llamadas 
; recursivas, como cada llamada recursiva guarda un parametro y el número máximo de llamadas
; activas es O(log2 (n)), por tanto, la complejidad espacial también es de O(log2⁡ (n)).

; Complejidad temporal: cada llamada recursiva realiza una operacion de comparacion O(1), 
; o realiza una llamada recursiva, como hemos visto el número de llamadas log2(n) por lo 
; que la complejidad temporal es log2(n).