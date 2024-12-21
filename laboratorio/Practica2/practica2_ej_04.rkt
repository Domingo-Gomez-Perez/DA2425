; EJERCICIO 4
; Hecho por: Miguel Martín, Sergio Lanza, Alvaro Gonzalez, David Ruiz del Corro

; Si se puede utilizar en ambos casos:

; Para el primer caso, T(n) = T(n/2) + O(1) donde a = 1 debido a que solo se hace una
; llamada recursiva en cada paso, b=2 debido a que el problema se reduce a la mitad y 
; el coste de combinar las soluciones es constante O(1) por lo que d tomaria valor 0,
; nos situariamos en el segundo caso y por tanto la complejidad temporal es O(log2(n))
; y coincide con lo visto anteriormente.

; Para el segundo caso, seria de la misma forma anterior, pero como el coste de trabajar con bits
; es O(log2 (n)). La complejidad temporal es: O(log2 (n)) * O(log2 (n)) = O((log2 (n))^2) al ver
; que coincide, podemos corroborar que efectivamente se puede puede usar el teorema maestro
