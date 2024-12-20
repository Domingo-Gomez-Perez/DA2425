#lang racket
(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))

; x:  a -> b -> ()
; y:  c -> d -> ()

;Append
(define z (append x y)) 
(display "Resultado de append: ") (display z) (newline)
(display "cdr de x después de append: ") (display (mcdr x)) (newline)

; x:  a -> b -> ()    
; y:  c -> d -> ()    
; z:  a -> b -> c -> d -> () 

;Append!
(define w (append! x y)) ; Modifica la lista x directamente
(display "Resultado de append!: ") (display w) (newline)
(display "cdr de x después de append!: ") (display (mcdr x)) (newline)

; x:  a -> b -> c -> d -> () 
; y:  c -> d -> ()           
; w:  a -> b -> c -> d -> () 