#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.16: Ben Bitdiddle decides to write a procedure to count the number of pairs in any list structure.
"It's easy," he reasons. "The number of pairs in any structure is the number in the car plus the number
in the cdr plus one more to count the current pair." So Ben writes the following procedure (modified for Racket):

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

Show that this procedure is not correct. In particular, draw box-and-pointer diagrams representing list
 structures made up of exactly three pairs for which Ben's procedure would return 3; return 4; return 7;
  never return at all. Encode these diagrams as data structures using Racket mcons.
|#