#lang racket

(define s (stream-cons 1 (add-streams s s)))
; stream-cons 1 crea el stream con 1 como primer elemento
; add-streams s s Suma s a s, esto segguira las potencias de dos aol referirse a si mismo
