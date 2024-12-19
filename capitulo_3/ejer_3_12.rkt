#lang racket
(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))

(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))

z
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)
;|-------|    
;| b | -----> (null)
;|-------|    

(define w (append! x y))

w
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)
;|-------|    |-------|    |-------|
;| b | -----> | c | -----> | d | -----> (null)
;|-------|    |-------|    |-------|