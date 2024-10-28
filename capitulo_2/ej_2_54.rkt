#lang racket

; Exercise 2.54

; Two lists are said to be `equal?` if they contain equal
; elements arranged in the same order. 

; (equal? '(this is a list) '(this is a list))    ; Should return #t
; (equal? '(this is a list) '(this (is a) list))  ; Should return #f

; To be more precise, we can define `equal?` recursively in
; terms of the basic `eq?` equality of symbols by saying that `a` and
; `b` are `equal?` if they are both symbols and the symbols are
; `eq?`, or if they are both lists such that `(car a)` is `equal?`
; to `(car b)` and `(cdr a)` is `equal?` to `(cdr b)`. Using
; this idea, implement `equal?` as a procedure. (Note: This implementation
; is only concerned with lists of symbols).

(define (equal-base? x y)
  (cond
    ((and (pair? x) (pair? y)) (and (equal-base? (car x) (car y)) (equal-base? (cdr x) (cdr y))))
    ((and (symbol? x) (symbol? y)) (eq? x y))
    ((and (eq? x '()) (eq? y '())) (eq? x y))
    (else #f)
  )
)

;Test:
(display 'equal-base?:)(newline) 
(equal-base? '(this is a list) '(this is a list))    ; Should return #t
(equal-base? '(this (b) list) '(this (b) list))      ; Should return #t
(equal-base? '(this is a list) '(this (is a) list))  ; Should return #f
(equal-base? '(this () list) '(this (b a) list))     ; Should return #f

; Using numbers IS NOT VALID, so it returns #f
(equal-base? '(this (4 b) list) '(this (4 b) list))  ; Should return #f
(equal-base? '(this (4 b) list) '(this (5 b) list))  ; Should return #f
(equal-base? 4 4)                                    ; Should return #f



; Note: In practice, programmers use `equal?` to compare lists that contain 
; numbers as well as symbols. Numbers are not considered to be symbols. The
; question of whether two numerically equal numbers (as tested by `=`) are
; also `eq?` is highly implementation-dependent. A better definition of 
; `equal?` (such as the one that comes as a primitive in Scheme) would also
; stipulate that if `a` and `b` are both numbers, then `a` and `b` are
; `equal?` if they are numerically equal. Can you modify `(equal?)` to also
; work with numbers?

(define (equal? x y)
  (cond
    ((and (pair? x) (pair? y)) (and (equal? (car x) (car y)) (equal? (cdr x) (cdr y))))
    ((and (number? x) (number? y)) (= x y))
    (else (eq? x y))
  )
)

; Tests:
(newline)(display 'equal?:)(newline) 
(equal-base? '(this is a list) '(this is a list))    ; Should return #t
(equal-base? '(this (b) list) '(this (b) list))      ; Should return #t
(equal-base? '(this is a list) '(this (is a) list))  ; Should return #f
(equal-base? '(this () list) '(this (b a) list))     ; Should return #f

; Using numbers IS VALID, so ...
(equal? '(this (4 b) list) '(this (4 b) list))       ; Should return #t
(equal? '(this (4 b) list) '(this (5 b) list))       ; Should return #f
(equal? 4 4)                                         ; Should return #t