#lang racket
; Ejercicio 3.16

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

(count-pairs (mcons 1 (mcons 2 (mcons 3 null))))

(count-pairs (mcons 1 (mcons 2 (mcons 3 (mcons 4 null)))))

(count-pairs (mcons 1 (mcons 2 (mcons 3 (mcons 4 (mcons 5 (mcons 6 (mcons 7 null))))))))