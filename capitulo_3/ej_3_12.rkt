#lang racket

; Exercise 3.12

; The following procedure for appending lists was introduced
; in 2.2.1.  It has been modified for use in Racket specifically
; for this exercise.


(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))


; `Append` forms a new list by successively `cons`ing the elements
; of `x` onto `y`.  The procedure `append!` is similar to `append`,
; but it is a mutator rather than a constructor.  It appends the
; lists by splicing them together, modifying the final pair of `x`
; so that its `cdr` is now `y`. 
; (It is an error to call `append!` with an empty `x`.)


(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)



; Here `last-pair` is a procedure that returns the last pair in its argument:

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))



(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))


; Consider the interaction. What are the missing `⟨response⟩`s?  
; Draw box-and-pointer diagrams to explain your answer.



(define z (append x y))
z

; First we call (append x y) with:
; x = [ a | o ]---> [ b | '() ]
; y = [ c | o ]---> [ d | '() ]

; We apply (mcons (mcar x) (append (mcdr x) y))
;   (mcar x) = 'a
;   (mcdr x) = [ b | '() ]
;   (append (mcdr x) y) = (append [ b | '() ] y)

; We call (append x y) again with:
; x = [ b | '() ]
; y = [ c | o ]---> [ d | '() ]

; We apply (mcons (mcar x) (append (mcdr x) y))
;   (mcar x) = 'b
;   (mcdr x) = '()
;   (append (mcdr x) y) = (append '() y)

; We call (append x y) again with:
; x = '()
; y = [ c | o ]---> [ d | '() ]
; x es null por lo que devuelvo y

; Going back, we finally return:
; [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]

; At the end, we see that the variables x, y have not changed
; x = [ a | o ]---> [ b | '() ]
; y = [ c | o ]---> [ d | '() ]
; z = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]


(mcdr x)

; Response: Since x has not changed, (mcdr x) is still...
; (mcons 'b '())

 




(define w (append! x y))
w


; First we call (append! x y) with:
; x = [ a | o ]---> [ b | '() ]
; y = [ c | o ]---> [ d | '() ]

; We apply (set-mcdr! (last-pair x) y)
;   (mcdr x) = [ b | '() ]
;   (last-pair (mcdr x)) = (last-pair [ b | '() ])

; We call (last-pair x) with:
;   x = [ b | '() ]
;
;   (mcdr x) = '()
;   Since it is null, we return x = [ b | '() ]

; Going back, we execute (set-mcdr! (last-pair x) y) with:
;   (last-pair x) = [ b | '() ]
;   y = [ c | o ]---> [ d | '() ]
;
;   transforms (mcdr x) into [ b | o ]---> [ c | o ]---> [ d | '() ]
;   returns x = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]

; At the end, we see that the variables x, y have not changed
; x = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]
; y = [ c | o ]---> [ d | '() ]
; z = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]


(mcdr x)

; Response: Now, x do changes along the process, so (mcdr x) is.
; (mcons 'b (mcons 'c (mcons 'd '())))