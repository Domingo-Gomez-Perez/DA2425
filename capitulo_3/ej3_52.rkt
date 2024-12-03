#lang racket
(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (display-stream s)
     (if (stream-empty? s) null
         (begin (display (stream-first s))
                (newline)
                (display-stream (stream-rest s)))))

(define seq 
  (stream-map 
   accum 
   (enumerate-interval 1 20)))

(define y (stream-filter even? seq)) ; los pares

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq)) ; los múltiplosd de 5

(stream-ref y 7) ; -> sum = 136 (la posición 7 del stream y es 136)

sum ; -> 136

(display-stream y) ; [6, 10, 28, 36, 66, 78, 120, 136, 190, 210] (los pares)
(newline)
(display-stream z) ; -> sum = 210 <- [10, 15, 45, 55, 105, 120, 190, 210] (los múltiplos de 5)

sum ; -> 210

(newline)
(display-stream seq) ; [1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91, 105, 120, 136, 153, 171, 190, 210]

;; El stream seq se genera aplicando la función accum sobre los números del 1 al 20.
;; La función accum actualiza la variable global sum cada vez que se llama.

;; Para x = 1: sum = 0 + 1 = 1
;; Para x = 2: sum = 1 + 2 = 3
;; Para x = 3: sum = 3 + 3 = 6
;; Para x = 4: sum = 6 + 4 = 10
;; Para x = 5: sum = 10 + 5 = 15
;; Para x = 6: sum = 15 + 6 = 21
;; Para x = 7: sum = 21 + 7 = 28
;; Para x = 8: sum = 28 + 8 = 36
;; Para x = 9: sum = 36 + 9 = 45
;; Para x = 10: sum = 45 + 10 = 55
;; Para x = 11: sum = 55 + 11 = 66
;; Para x = 12: sum = 66 + 12 = 78
;; Para x = 13: sum = 78 + 13 = 91
;; Para x = 14: sum = 91 + 14 = 105
;; Para x = 15: sum = 105 + 15 = 120
;; Para x = 16: sum = 120 + 16 = 136
;; Para x = 17: sum = 136 + 17 = 153
;; Para x = 18: sum = 153 + 18 = 171
;; Para x = 19: sum = 171 + 19 = 190
;; Para x = 20: sum = 190 + 20 = 210

;; Las respuestas sí serían diferentes si hubiésemos implementado (delay <exp>) simplemente como (lambda () <exp>) sin usar
;; memo-proc?, porque `seq` se enumera dos veces, para `y` y para `z`.
