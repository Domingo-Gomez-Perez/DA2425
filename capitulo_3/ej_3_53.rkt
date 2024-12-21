#lang racket

; Exercise 3.53 

; Without running the program, describe the elements of the
; stream defined by `(define s (stream-cons 1 (add-streams s s)))`

; Auxiliary methods

(define (add-streams s1 s2)
  (if (stream-empty? s1)
      empty-stream
      (stream-cons (+ (stream-first s1) (stream-first s2))
                   (add-streams (stream-rest s1) (stream-rest s2)))))

(define (display-stream-n s n)
  (when (and (not (stream-empty? s)) (> n 0))
    (display (stream-first s))
    (newline)
    (display-stream-n (stream-rest s) (- n 1))))


; The stream `s` will have a 1 in the first position (denoted as s[0]).
; The second will be s[0]*2 = 2 (s+s).
; The third will be s[1]*2 = 4.
; The fourth will be s[2]*2 = 8.
;             ...
;
; So it will contain the list of powers of 2.
;   
;           1 2 4  8 16 32  64 ...
;       +   1 2 4  8 16 32  64 ...
;        ----------------------
;    s =  1 2 4 8 16 32 64 128 ...

(define s (stream-cons 1 (add-streams s s)))

; Uncomment to see the result:
; (display-stream-n s 10)
