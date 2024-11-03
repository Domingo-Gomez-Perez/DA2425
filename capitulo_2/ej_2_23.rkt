#lang racket

; Exercise 2.23

; The procedure `for-each` is similar to `map`. It takes as arguments a procedure and a list of
; elements. However, rather than forming a list of the results, `for-each` just applies the procedure
; to each of the elements in turn, from left to right. The values returned by applying the procedure
; to the elements are not used at all—`for-each` is used with procedures that perform an action, such as
; printing.


; (for-each 
;  (lambda (x) (newline) (display x))
;   (list 57 321 88))

; 57
; 321
; 88

; The value returned by the call to `for-each` (not illustrated above) can
; be something arbitrary, such as true. Give an implementation of
; `for-each`.

(define (for-each proc lst)
  (unless (null? lst)
    (proc (car lst))
    (for-each proc (cdr lst))
   )
 ) 

; Tests:
(for-each                     ; Should return
 (lambda (x)                  ; 57    -> 57
   (newline)                  ; 321   -> 321
   (display x))               ; 88    -> 88
  (list 57 321 88))    

(newline)

(for-each                     ; Should return
 (lambda (x)                  ; 57    -> #t
   (newline)                  ; 321   -> #f
   (display (= x 57)))        ; 88    -> #f
  (list 57 321 88))