#lang racket

; Hecho por:
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#| 
Exercise 1.46: 
Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as "iterative improvement". Iterative improvement says that, to compute something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess.

Write a procedure iterative-improve that takes two procedures as arguments: 
  - a method for telling whether a guess is good enough 
  - a method for improving a guess.

Iterative-improve should return as its value a procedure that takes a guess as an argument and keeps improving the guess until it is good enough. Rewrite the sqrt procedure of section 1.1.7 and the fixed-point procedure of section 1.3.3 in terms of iterative-improve.

Challenge Exercise: 
Throughout chapter 1, the only model of computation described is that of substitution. For example, if you define a procedure `fact` like this:

(define (fact n)
  (if (= n 0) 
      1 
      (* n (fact (- n 1)))))

It evaluates by substituting the `n` with whatever value you provide.

(fact 5) ; --> (if (= 5 0) 1 (* 5 (fact (- 5 1)))))

After this substitution, further steps might be carried out to get to a final answer 
(for example, recursive calls to `fact` involve further substitutions).

One "fuzzy" aspect of this whole model is the behavior of `define`. It assigns a name to a procedure, 
but where do these names live? Are procedures stored somewhere? We simply have no idea and no further details.
 Are defined names even necessary at all? Maybe you don't even need `define`.

Suppose you had the following procedure:

(define (square x)
  (* x x))

(square 10) ; --> 100

As you know, an unnamed procedure can be defined using `lambda`. So, you could 
certainly write the above calculation as follows:

((lambda (x) (* x x)) 10) ; --> 100

Observe: The `define` statement went away as well as the name `square`.

Challenge: 
Can you also define `fact` as an unnamed procedure using `lambda`? This is, could you 
write a single expression, involving no `define` statements, that works like this:

; Compute 5!
((lambda <???> ...) 5) ; --> 120

Hint: 
Any free-variable `y` with value `v` in an expression `e` can be replaced by an 
expression of the form `((lambda (y) e) v)`. For example:

(define y 2) ; A free variable
((lambda (x) (+ x y)) 3) ; --> 5

; Can rewrite as follows:
(((lambda (y) (lambda (x) (+ x y))) 2) 3) ; --> 5
|#
