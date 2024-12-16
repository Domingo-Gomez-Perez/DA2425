#lang racket
;sin simplificar
(define (make-rat-simple x y)
  (if (< y 0)              ; Si y es menor que 0
      (cons (- x) (- y))   ; Es negativo asi que hacemos x negativo e y positivo
      (cons x y)))         ; De lo contrario, crea el par (x, y)

;con simplificación
(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (< d 0)
    (cons (- (/ n g)) 
          (- (/ d g)))
    (cons (/ n g) 
          (/ d g)))
    ))

  
(make-rat-simple 3 (- 2)) 
(make-rat-simple (- 3) (- 2))
(make-rat-simple (- 3) 2)
(make-rat-simple 3 2)

(make-rat 2 (- 4)) 
(make-rat (- 2) (- 4))
(make-rat (- 2) 4)
(make-rat 2 4)

