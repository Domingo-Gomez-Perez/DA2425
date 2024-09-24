#lang racket


; **Exercise 1.16:** Design an iterative version of the `fast-expt`
; procedure given in the text.  Hint: to do this, it might help to use a
; subtle trick of algorithm design.  Normally when implementing an
; algorithm, you're thinking about how to break a problem down into
; smaller and smaller steps (e.g., subdividing the problem into parts).  However,
; sometimes it might make sense to change the problem into a different, but
; equivalent problem.  For example, suppose you were computing
; `2^16`. You could rewrite this problem by doubling the base and halving the exponent.
; Thus, it's really the same as computing `4^8`.  Perhaps this trick could be used
; in your solution.