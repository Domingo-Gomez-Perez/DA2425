Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

(define (suma_cuadrados_2_mas_grandes a b c)
  (define mas_pequeño (min a b c))  ; coges el mas pequeño de los argumentos
  (+ (* a a) (* b b) (* c c) (- (* mas_pequeño mas_pequeño))))  ; restas el cuadrado del mas pequeño
)
