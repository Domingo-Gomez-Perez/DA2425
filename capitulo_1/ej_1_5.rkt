#lang racket

; Ben Bitdiddle has invented a test to determine whether the interpreter he is 
; faced with is using applicative-order evaluation or normal-order evaluation.
; He defines the following two procedures:

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

; Then he evaluates the expression

(test 0 (p))

; What behavior will Ben observe with an interpreter that uses applicative-order
; evaluation? What behavior will he observe with an interpreter that uses
; normal-order evaluation? Explain your answer. (Assume that the evaluation
; rule for the special form `if` is the same whether the interpreter is
; using normal or applicative order: The predicate expression is evaluated first,
; and the result determines whether to evaluate the consequent or the alternative
; expression.)


; Applicative-order evaluation:
; In applicative-order evaluation, the arguments to a procedure are evaluated before the procedure is applied.
; Therefore, when evaluating (test 0 (p)), the interpreter will first attempt to evaluate (p).
; Since (p) is defined as (p), this will result in an infinite loop or a stack overflow, as (p) will keep calling itself recursively without end.
; Thus, Ben will observe that the interpreter does not terminate and gets stuck in an infinite loop.


; Normal-order evaluation:
; In normal-order evaluation, the arguments to a procedure are not evaluated until their values are needed.
; When evaluating (test 0 (p)), the interpreter will first evaluate the predicate (= x 0).
; Since x is 0, the predicate evaluates to true, and the interpreter will return 0 without ever evaluating (p).
; Thus, Ben will observe that the interpreter returns 0 immediately, without getting stuck in an infinite loop.