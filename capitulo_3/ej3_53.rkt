#lang racket
(define (stream-map proc . ss)
  (if (stream-empty? (car ss))
      empty-stream
      (stream-cons (apply proc (map stream-first ss))
                   (apply stream-map proc (map stream-rest ss)))))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define s (stream-cons 1 (add-streams s s))) ; -> 1, 2, 4, 6, 8, 16, ...
; s es el stream de potencias de 2

;; s = [1]                ; Primer elemento es 1
;; (add-streams s s) =    ; El resto es la suma de s consigo mismo
;;     [2]                ; 1 + 1 = 2
;;     [4]                ; 2 + 2 = 4
;;     [8]                ; 4 + 4 = 8
;;     [16]               ; 8 + 8 = 16
;;     [32]               ; 16 + 16 = 32
;;     [64]               ; 32 + 32 = 64
;;     [128]              ; 64 + 64 = 128
;;     ...                ; Y así sucesivamente...

;; La secuencia generada por `s` es:
;; s = [1, 2, 4, 8, 16, 32, 64, 128, ...]
;; Donde cada número es el doble del anterior, es decir,
;; las potencias de 2: 2^0, 2^1, 2^2, 2^3, 2^4, 2^5, 2^6, 2^7, ...