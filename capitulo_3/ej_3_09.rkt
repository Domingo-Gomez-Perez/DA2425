#lang racket

; Exercise 3.9

; In 1.2.1 we used the substitution model to analyze two procedures 
; for computing factorials. Show the environment structures created
; by evaluating `(factorial 6)` using each version of the `factorial` 
; procedure.

; ------------------------------------------------------------------

; ** Let's check the recursive version **

; (define (factorial n)
;   (if (= n 1)
;       1
;       (* n (factorial (- n 1)))))


; Before calling (factorial 6), we have the following global environment:

; global env:
;             - factorial:   - Function code
;                            - Pointer
 
; When we call (factorial 6), a new environment (E1) is created:
 
; E1:
;     - Parent environment:   global env
;     - Variables:            n : 6
;     - Evaluated body:       (if (= n 1)
;                               1
;                               (* n (factorial (- n 1)))) 
 
; By substituting in the evaluated body, (n with 6), it is necessary to evaluate (factorial 5)
; which creates a new environment (E2):
 
; E2:
;     - Parent environment:   E1
;     - Variables:            n : 5
;     - Evaluated body:       (if (= n 1)
;                               1
;                               (* n (factorial (- n 1)))) 
           
; By substituting in the evaluated body, (n with 5), it is necessary to evaluate (factorial 4)
; which creates a new environment (E3):
 
; E3:
;     - Parent environment:   E2
;     - Variables:            n : 4
;     - Evaluated body:       (if (= n 1)
;                               1
;                               (* n (factorial (- n 1)))) 
 
; By substituting in the evaluated body, (n with 4), it is necessary to evaluate (factorial 3)
; which creates a new environment (E4):
 
; E4:
;     - Parent environment:   E3
;     - Variables:            n : 3
;     - Evaluated body:       (if (= n 1)
;                               1
;                               (* n (factorial (- n 1)))) 
 
; By substituting in the evaluated body, (n with 3), it is necessary to evaluate (factorial 2)
; which creates a new environment (E5):
 
; E5:
;     - Parent environment:   E4
;     - Variables:            n : 2
;     - Evaluated body:       (if (= n 1)
;                               1
;                               (* n (factorial (- n 1)))) 
 
; By substituting in the evaluated body, (n with 2), it is necessary to evaluate (factorial 1)
; which creates a new environment (E6):
 
; E6:
;     - Parent environment:   E5
;     - Variables:            n : 1
;     - Evaluated body:       (if (= n 1)
;                               1
;                               (* n (factorial (- n 1)))) 
 
; This time, by evaluating the expression with n = 1, it returns 1. Now, with the
; calculated result, we go back from E6 to E1, using the reference to the parent environment,
; eliminating the environment after using it.
 
;   E6 returns 1 and is eliminated
;   E5 calculates (* 2 1), returns 2 and is eliminated
;   E4 calculates (* 3 2), returns 6 and is eliminated
;   E3 calculates (* 4 6), returns 24 and is eliminated
;   E2 calculates (* 5 24), returns 120 and is eliminated
;   E1 calculates (* 6 120), returns 720 and is eliminated
 
 
;--------------------------------------------------------------------------------


; ** Let's check the iterative version **

(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product) (+ counter 1) max-count)))




; Before calling (factorial 6), we have the following global environment:

; global env:
;             - factorial:   - Function code
;                            - Pointer
;
;             - fact-iter:   - Function code
;                            - Pointer

; When we call (factorial 6), a new environment (E1) is created:
 
; E1:
;     - Parent environment:   global env
;     - Variables:            n : 6
;     - Evaluated body:       (fact-iter 1 1 n) 

; By substituting in the evaluated body, (n with 6), it is necessary to evaluate (fact-iter 1 1 6)
; which creates a new environment (E2):

; E2:
;     - Parent environment:   E1
;     - Variables:            product: 1
;                             counter: 1
;                             max-count: 6
;     - Evaluated body:       (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count))

; By substituting in the evaluated body, (product with 1, counter with 1, max-count with 6), 
; it is necessary to evaluate (fact-iter 1 2 6). This creates a new environment (E3):

; E3:
;     - Parent environment:   E2
;     - Variables:            product: 1
;                             counter: 2
;                             max-count: 6
;     - Evaluated body:       (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count))

; By substituting in the evaluated body, (product with 1, counter with 2, max-count with 6), 
; it is necessary to evaluate (fact-iter 2 3 6). This creates a new environment (E4):

; E4:
;     - Parent environment:   E3
;     - Variables:            product: 2
;                             counter: 3
;                             max-count: 6
;     - Evaluated body:       (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count))

; By substituting in the evaluated body, (product with 2, counter with 3, max-count with 6), 
; it is necessary to evaluate (fact-iter 6 4 6). This creates a new environment (E5):

; E5:
;     - Parent environment:   E4
;     - Variables:            product: 6
;                             counter: 4
;                             max-count: 6
;     - Evaluated body:       (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count))

; By substituting in the evaluated body, (product with 6, counter with 4, max-count with 6), 
; it is necessary to evaluate (fact-iter 24 5 6). This creates a new environment (E6):

; E6:
;     - Parent environment:   E5
;     - Variables:            product: 24
;                             counter: 5
;                             max-count: 6
;     - Evaluated body:       (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count))

; By substituting in the evaluated body, (product with 24, counter with 5, max-count with 6), 
; it is necessary to evaluate (fact-iter 120 6 6). This creates a new environment (E7):

; E7:
;     - Parent environment:   E6
;     - Variables:            product: 120
;                             counter: 6
;                             max-count: 6
;     - Evaluated body:       (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count))

; By substituting in the evaluated body, (product with 120, counter with 6, max-count with 6), 
; it is necessary to evaluate (fact-iter 720 7 6). This creates a new environment (E8):

; E8:
;     - Parent environment:   E7
;     - Variables:            product: 720
;                             counter: 7
;                             max-count: 6
;     - Evaluated body:       (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count))

; By substituting in the evaluated body, (product with 720, counter with 7, max-count with 6), 
; this returns the value of product (720). Now, with the calculated result, we go back from
; E8 to E1, using the reference to the parent environment, eliminating the environment after
; using it.
 
;   E8 returns 720 to E7 and is eliminated
;   E7 returns 720 to E6 and is eliminated
;   E6 returns 720 to E5 and is eliminated
;   E5 returns 720 to E4 and is eliminated
;   E4 returns 720 to E3 and is eliminated
;   E3 returns 720 to E2 and is eliminated
;   E2 returns 720 to E1 and is eliminated
;   E1 returns 720 to global env and is eliminated