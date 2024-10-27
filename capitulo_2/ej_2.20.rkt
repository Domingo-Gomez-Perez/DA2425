#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.20: The procedures +, *, and list take arbitrary numbers of arguments.
One way to define such procedures is to use define with "dotted-tail notation".
In a procedure definition, a parameter list that has a dot before the last parameter name
indicates that, when the procedure is called, the initial parameters (if any) will have as
values the initial arguments, as usual, but the final parameter's value will be a list of any
remaining arguments. For instance, given the definition

(define (f x y . z) ⟨body⟩)
the procedure f can be called with two or more arguments. If we evaluate

(f 1 2 3 4 5 6)
then in the body of f, x will be 1, y will be 2, and z will be the list (3 4 5 6). Given the
definition

(define (g . w) ⟨body⟩)
the procedure g can be called with zero or more arguments. If we evaluate

(g 1 2 3 4 5 6)
then in the body of g, w will be the list (1 2 3 4 5 6).

Note: Dotted-tail notation is similar to the *args syntax in Python. For example:

def f(x, y, *z):
    ...
Use this notation to write a procedure same-parity that takes one or more integers and
returns a list of all the arguments that have the same even-odd parity as the first argument.
For example,

(same-parity 1 2 3 4 5 6 7)
(1 3 5 7)

(same-parity 2 3 4 5 6 7)
(2 4 6)
|#

; para saber la paridad hay dos maneras, o con el modulo de 2
; o con los procedimientos de odd? even? y filtrando

(define (same-parity primero . resto)
  (define mirar-paridad
    (if (odd? primero) odd? even?)) ; elige que funcion usar, si odd o even
  (cons primero (filter mirar-paridad resto))) ; ponemos el primero y filtramos todos los demas con el filtro

(define (same-parity2 x . elements)
  (define (parity-match? n)          ;verifica si un número tiene la misma paridad que x.
    (if (even? x)
        (even? n)
        (odd? n)))
  (define (same-parity-rec list)     ;función para añadir a una lista los que tienen la misma paridad que x
    (if (null? list)
        '()
        (let ((first (car list))      ;con el let se definen 2 variables locales, first y rest, para ver si el primero tiene la misma paridad que x
              (rest (cdr list)))
          (if (parity-match? first)
              (cons first (same-parity-rec rest))  ; si se cumple se agrega a la lista y se llama a la función nuevamente pero con el resto
              (same-parity-rec rest)))))
  (cons x (same-parity-rec elements)))



;pruebas
(same-parity 1 2 3 4 5 6 7) ; (1 3 5 7)
(same-parity 2 3 4 5 6 7)   ; (2 4 6)

(same-parity2 1 2 3 4 5 6 7) ; (1 3 5 7)
(same-parity2 2 3 4 5 6 7)   ; (2 4 6)

