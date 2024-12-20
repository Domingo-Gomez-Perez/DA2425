#lang racket

; El procedimiento make-monitored
(define (make-monitored f)
  (define counter 0)  
  
  (define (mf input)
    (cond
      [(eq? input 'how-many-calls?) counter]  
      [(eq? input 'reset-count)               
       (set! counter 0) 0]                   
      [else
       (begin
         (set! counter (+ counter 1))         
         (f input))]))                     
  
  mf) 

; Comprobar
(define s (make-monitored sqrt))

(display (s 100))        ; 10
(newline)
(display (s 'how-many-calls?)) ; 1
(newline)
(display (s 'reset-count))     ; 0
(newline)
(display (s 'how-many-calls?)) ; 0
(newline)
(display (s 9))          ; 3
(newline)
(display (s 'how-many-calls?)) ; 1
(newline)
