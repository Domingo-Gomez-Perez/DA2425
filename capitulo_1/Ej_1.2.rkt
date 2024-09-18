#lang racket

;nominador
;(+ 5 4 (- 2 ( - 3 (+ 6 (/ 4  5)))))

;denominador
;(* 3 (- 6 2) (- 2 7))

; Traducción completa
(/ (+ 5 4 (- 2 ( - 3 (+ 6 (/ 4  5)))))  (* 3 (- 6 2) (- 2 7)))
