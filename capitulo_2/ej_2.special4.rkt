#lang racket

#|
Hecho por 
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Challenge Exercise (Binding): Instead of matching, a more advanced operation is binding. Here is an example:

(bind '(job ?name ?job) record)
;  --> '((name (Hacker Alyssa P)) (job (computer programmer)))

(bind '(?type ?name (?what programmer)) record)
; -->  '((type job) (name (Hacker Alyssa P)) (what computer))

(bind '(job ?what) record)
; --> false (doesn't match)
|#
(define (bind pattern data)
  (cond
    ;; If the pattern is a symbol, it is a variable to be bound
    ((symbol? pattern)
     (list (list pattern data)))  ; Return a binding of the variable to the data

    ;; If both are lists, we need to bind their structure
    ((and (list? pattern) (list? data))
     (if (equal? (length pattern) (length data))  ; Lengths must match
         (apply append                            ; Combine all bindings
                (map bind pattern data))        ; Bind each corresponding pair
         #f))                                   ; Return false if lengths don't match

    ;; If both are atoms and they are equal, return an empty binding (nothing to bind)
    ((equal? pattern data) '())

    ;; Otherwise, return false (no match)
    (else #f)))

;; Test cases
(define record '(job (Hacker Alyssa P) (computer programmer)))

(display (bind '(job ?name ?job) record))  ; --> '((name (Hacker Alyssa P)) (job (computer programmer)))
(newline)
(display (bind '(?type ?name (?what programmer)) record))  ; --> '((type job) (name (Hacker Alyssa P)) (what computer))
(newline)
(display (bind '(job ?what) record))  ; --> false
(newline)