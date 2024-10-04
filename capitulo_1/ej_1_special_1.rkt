#lang racket

; Special Exercise

; Why does this code not work?

(define (f x) 
 (let ((a (+ x 10))
      (b (* a 5)))
      (+ a b)))

(f 2)      ; Fails.  Why?

; In a 'let' expression all bindings aren't defined sequentially, but simultaneously. 
; We are using 'a' to define 'b' (when 'a' has not been defined yet).