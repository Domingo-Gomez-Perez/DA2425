#lang racket

; Special Challenge Exercise (Binding)

; Instead of matching, a more advanced operation is binding.

; Hints: You can use `(symbol->string sym)` to convert a symbol to a string.
; `(string->symbol s)` converts a string to a symbol. `(substring s first last)` creates
; a substring.

(define (bind pattern data) 
    (cond
      ((and (null? pattern) (null? data)) null)
      ((and (pair? pattern) (pair? data)) (define car-bind (bind (car pattern) (car data)))
                                          (define cdr-bind (bind (cdr pattern) (cdr data)))
                 
                                          (cond
                                            ((or (boolean? car-bind) (boolean? cdr-bind)) #f)
                                            ((and (null? car-bind) (null? cdr-bind)) null)
                                            ((null? car-bind) (if (list? cdr-bind)
                                                                  cdr-bind
                                                                  (list cdr-bind)))
                                            ((null? cdr-bind) (if (list? car-bind)
                                                                  car-bind
                                                                  (list car-bind)))
                                            ((list? (car cdr-bind)) (cons car-bind cdr-bind))
                                            (else (cons car-bind (list cdr-bind)))))
                                        
      ((is-field? pattern) (list (get-field pattern) data))
      ((eq? pattern data) null)
      (else #f)))



; Check if start by `?`
(define (is-field? sym)
  (if (null? sym)
      #f
      (if (string=? (substring (symbol->string sym) 0 1) "?")
          (get-field sym)
          #f)))

; Return the name of the fielafter `?`
(define (get-field sym)
  (string->symbol (substring (symbol->string sym) 1 (string-length (symbol->string sym)))))




; Tests:

(define record '(job (Hacker Alyssa P) (computer programmer)))


(bind '(job ?name ?job) record)
;  --> '((name (Hacker Alyssa P)) (job (computer programmer)))

(bind '(?type ?name (?what programmer)) record)
; -->  '((type job) (name (Hacker Alyssa P)) (what computer))

(bind '(job ?what) record)
; --> false (doesn't match)