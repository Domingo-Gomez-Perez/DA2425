#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Exercise (Patterns): Sometimes it's useful to match patterns in data. For example, consider this record:

(define record '(job (Hacker Alyssa P) (computer programmer)))
Write a procedure (match pattern data) that matches structure:

(match '(job ? ?) record)           ; --> true
(match '(job ? (? coder)) record)   ; --> false
(match '(? ? (computer ?)) record)  ; --> true
|#

; tenemos un record asi y ahora queremos saber lo que pide:
(define record '(job (Hacker Alyssa P) (computer programmer)))


; Coincidir un patrón con datos
(define (match pattern data)
  (void))


(match '(job ? ?) record)           ; --> true
(match '(job ? (? coder)) record)   ; --> false
(match '(? ? (computer ?)) record)  ; --> true