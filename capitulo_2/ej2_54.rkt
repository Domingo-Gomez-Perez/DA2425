#lang racket

(display"\nExercise 2.54\n")

; **Exercise 2.54:** Two lists are said to be
; `equal?` if they contain equal elements arranged in the same order.  For
; example,

; ```
; (equal? '(this is a list) 
;         '(this is a list))
; ```

; is true, but

; ```
; (equal? '(this is a list) 
;         '(this (is a) list))
; ```

; is false.  To be more precise, we can define `equal?`  recursively in
; terms of the basic `eq?` equality of symbols by saying that `a` and
; `b` are `equal?` if they are both symbols and the symbols are
; `eq?`, or if they are both lists such that `(car a)` is `equal?`
; to `(car b)` and `(cdr a)` is `equal?` to `(cdr b)`.  Using
; this idea, implement `equal?` as a procedure. (Note: This implementation
; is only concerned with lists of symbols).

; Note: In practice,
; programmers use `equal?` to compare lists that contain numbers as well as
; symbols.  Numbers are not considered to be symbols.  The question of whether
; two numerically equal numbers (as tested by `=`) are also `eq?` is
; highly implementation-dependent.  A better definition of `equal?` (such as
; the one that comes as a primitive in Scheme) would also stipulate that if
; `a` and `b` are both numbers, then `a` and `b` are
; `equal?` if they are numerically equal.  Can you modify `(equal?)` to also
; work with numbers?


(define (equal? a b)
  (cond
    ((and (symbol? a) (symbol? b)) (eq? a b))   ; ambos son símbolos
    ((and (number? a) (number? b)) (= a b))     ; ambos son números
    ((and (null? a) (null? b)) #t)              ; ambas listas son vacías
    ((or (null? a) (null? b)) #f)               ; solo una es vacía
    ((and (list? a) (list? b))                  ; ambos son listas no vacías
     (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b))))
    (else #f)))                                 ; en cualquier otro caso, son diferentes

(display "'(this is a list) == '(this is a list)\n")
(equal? '(this is a list) '(this is a list)); devuelve #t.
(display "'(this is a list) == '(this (is a) list)\n")
(equal? '(this is a list) '(this (is a) list)); devuelve #f.
(display "`(1 2 3) == '(1 2 3)\n")
(equal? '(1 2 3) '(1 2 3)); devuelve #t.
(display "`(1 2 3) == '(1 2 tree)\n")
(equal? '(1 2 3) '(1 2 three)); devuelve #f
(display "1 == 1\n")
(equal? 1 1); devuelve #t.
(display "1 == 2\n")
(equal? 1 2); devuelve #f.
; Ahora equal? funciona tambien para numeros y operaciones numericas