#lang racket
(define (f g) (g 2))

(define (square x) (* x x))
(f square) ; -> 4
(f (lambda (z) (* z (+ z 1)))) ; -> 6

; (f f) ?
(f f)

; 1. Cuando llamamos a `(f f)`, el procedimiento `f` es pasado como argumento `g` 
;    en la primera instancia de `f`.
;    
;    Por lo tanto, la expresión `(f f)` se convierte en:
;
;    (f 2)
;
; 2. Ahora, `f` espera que `g` sea un procedimiento, pero en este caso, `g` es 
;    el mismo `f`. Esto significa que la expresión se convierte en `(f 2)`.
;    Sin embargo, `f` espera que su argumento sea un procedimiento, no un número.
;    Al intentar aplicar `2` como si fuera una función, esto genera un error.
;
;    "application: not a procedure;
;    expected a procedure that can be applied to arguments
;    given: 2"
