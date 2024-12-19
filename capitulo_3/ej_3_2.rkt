#lang racket
;Ejercicio 3.2
(define (make-monitored f)
  (let ((mf 0)) 
    (lambda (x)
      (cond ((eq? x 'how-many-calls?) mf)  
            ((eq? x 'reset-count)               
             (set! mf 0))
            (else
             (set! mf (+ mf 1))      
             (f x))))))


(define s (make-monitored sqrt))
(s 100) ; 10
(s 'how-many-calls?) ;1
(s 100) ;10
(s 100) ;10
(s 'how-many-calls?) ;3
(s 'reset-count) 
(s 'how-many-calls?) ;0
(s 100) ;10
(s 'how-many-calls?) ;1