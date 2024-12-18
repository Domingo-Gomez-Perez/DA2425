#lang racket
(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))


(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))

z
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)
(mcons 'b '()) ; La lista original x no se modifica

;x:  (a) --> (b) --> null
;y:  (c) --> (d) --> null
;z:  (a) --> (b) --> (c) --> (d) --> null




(define w (append! x y))

w
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '())))) ; La lista original x se modifica

;x:  (a) --> (b) --> (c) --> (d) --> null
;y:     (c) --> (d) --> null
;w:  (a) --> (b) --> (c) --> (d) --> null

; Como podemos ver w y z son iguales en contenido pero la diferencia es que en append! la lista que se retorna es a partir de la original x y no una lista nueva como pasa en el append

(mcdr x)
(mcons 'b (mcons 'c (mcons 'd '()))) ; Response