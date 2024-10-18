;EJERCICIO 1.1
#lang racket
10 ;10

(+ 5 3 4) ;(+ 8 4)
          ;(12)

(- 9 1) ; (8)

(/ 6 2) ;(3)

(+ (* 2 4) (- 4 6)) ;(+ (8) (-2))
                    ;(6) 

(define a 3) 

(define b (+ a 1))

(+ a b (* a b)) ;(+ 3 4 (12))
                ;(7 12)
                ;(19)

(= a b)         ;#f

(if (and (> b a) (< b (* a b))) 
    b
    a)
;(if (and (#t) (< 4 (*3 4))) 4 3)
;(if (and (#t) (< 4 12)4 3)
;(if (and (#t) (#t))4 3)
;4
    
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
;(cond ((= 3 4) 6) ((= 4 4) (+ 6 7 3))(else 25))
;(cond ((#f) ((= 4 4) (+ 6 7 3))(else 25))
;(#t (6 7 3)
;(13 3)
;(16)
      
(+ 2 (if (> b a) b a))
;(+2 (if (>4 3) 4 3)
;(+2 (if (#t) 4 3)
;(+2 4)
;6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
;(* (cond ((> 3 4) 3)((< 3 4) 4)(else -1))(+ 3 1))
;(* (cond (#f 6)((< 3 4) 4)(else - 1))(+ 3 1))
;(* (#t 4) (+ 3 1))
;(* 4 4)
;16

;EJERCICIO 1.2
;5 + 4 + (2 - (3 - (6 + 4/5)))
;-----------------------------
;       3(6 - 2)(2 - 7)

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

;EJERCICIO 1.3
(define (suma-de-cuadrados-grandes x y z)
  (cond ((and (<= x y) (<= x z)) (+ (* y y) (* z z))) 
        ((and (<= y x) (<= y z)) (+ (* x x) (* z z)))  
        (else (+ (* x x) (* y y)))))

;Ejemplo
(suma-de-cuadrados-grandes 2 3 4)

;EJERCICIO 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;Esta funcion realiza la suma de "a" y "b" si el valor de b es positivo, y realiza la resta
;de "b" sobre "a" si el valor de "b" es negativo. Esto consigue sumar a "a" el valor
;absoluto de "b"

;EJERCICIO 1.6
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (good-enough? guess x)
  (< (abs (- (* guess guess) x)) 0.001))

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))


(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
;Al usar el new if se evalua tanto el "then" y el "else" de la funcion, lo que viene
;a ser el "guess" y el "sqrt-iter", provocando llamadas recursivas a este ultimo,
;convirtiendolo en un bucle infinito. 

;EJERCICIO 1.8
(define (cube-root x)
  (cube-iter 1.0 x))

(define (good-enough? guess x)
  (< (abs (- (* guess guess guess) x)) 0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cube-iter guess x)
  (if (good-enough? guess x)
          guess
          (cube-iter (improve guess x) x)))

;Ejemplo
(cube-root 27);

;EJERCICIO 1.9

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (plus a b)
  (if (= a 0) 
      b 
      (inc (plus (dec a) b))))
(plus 4 5)

;(plus 4 5)
;(+ (plus 3 5) 1)
;(+ (plus 2 5) 1 1)
;(+ (plus 1 5) 1 1 1)
;(+ (plus 0 5) 1 1 1 1)
;(+ 5 1 1 1 1)
;(+ 6 1 1 1)
;(+ 7 1 1)
;(+ 8 1)
;9

(define (plus a b)
  (if (= a 0) 
      b 
      (plus (dec a) (inc b))))

(plus 4 5)
;plus 4 5 llama a plus 3 6.
;plus 3 6 llama a plus 2 7.
;plus 2 7 llama a plus 1 8.
;plus 1 8 llama a plus 0 9.
;plus 0 9 retorna 9.

;EJERCICIO 1.16
(define (fast-expt-iter base exponente)
  ;Función iterativa con acumulador.
  (define (iter base exponente resultado)
    (cond ((= exponente 0) resultado)               
          ((even? exponente)                        
           (iter (* base base) (/ exponente 2) resultado))
          (else                                     
           (iter base (- exponente 1) (* resultado base)))))
  (iter base exponente 1))  

;Ejemplo
(fast-expt-iter 3 9)

;EJERCICIO 1.17
(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

(define (double x) (+ x x)) 
(define (halve x) (/ x 2))   

(define (mul2 a b)
  (cond ((= b 0) 0)                          
        ((even? b) (mul2 (double a) (halve b))) 
        (else (+ a (mul2 a (- b 1))))))  

;Ejemplo
(mul2 2356892374238 823748778234)

;EJERCICIO 1.30
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result                    
        (iter (next a) (+ result (term a)))))  
  (iter a 0))
(define (iden x) x)
(define (inc x) (+ x 1))

;Ejemplo
(sum iden 1 inc 7)  

;EJERCICIO 1.31
(define (iden n) n)
(define (inc n) (+ n 1))

(define (producto term a next b)
  (if (> a b)
      1   ; Si a > b, el producto es 1
      (* (term a) (producto term (next a) next b))))

(define (factorial n)
  (producto iden 1 inc n))


(define (producto-pi n)
  (define (numerator k) (if (even? k) (+ k 2) (+ k 1)))  
  (define (denominator k) (if (even? k) (+ k 1) (+ k 2))) 
  (* 4 (product (lambda (k) (/ (numerator k) (denominator k)))
                1 inc n)))

(producto-pi 27)
(factorial 5)

;EJERCICIO 1.31.b
(define (iden n) n)
(define (inc n) (+ n 1))


(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result   
        (iter (next a) (* result (term a)))))  .
  (iter a 1)) 

(define (factorial n)
  (product iden 1 inc n))

(product-pi 27)
(factorial 5)


;Ejemplo
(define (factorial n)
  (producto iden 1 inc n))

;EJERCICIO 1.32
(define (iden x) x)
(define (inc x) (+ x 1))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value  
      (combiner (term a) (accumulate combiner null-value term (next a) next b)))) 

(define (sum term a next b)
  (acumulate + 0 term a next b))  
(define (product term a next b)
  (acumulate * 1 term a next b))  

;Ejemplo
(sum iden 1 inc 7)
(product iden 1 inc 7)

;EJERCICIO 1.32.b
(define (iden x) x)
(define (inc x) (+ x 1))

(define (acumulate combiner null-value term a next b)
  (define (iter a)
    (if (> a b)
        null-value 
        (combiner (term a) (iter (next a)))))  
  (iter a))  

(define (sum term a next b)
  (acumulate + 0 term a next b))  
(define (product term a next b)
  (acumulate * 1 term a next b))  

;Ejemplo
(sum iden 1 inc 7)
(product iden 1 inc 7)

;EJERCICIO 1.34

(define (f g) (g 2))

(define (square x) (* x x))

(f square)


(f (lambda (z) (* z (+ z 1))))

(f f)

;Al llamar a (f f), se llama a una funcion g la cual a su vez llama de nuevo
;a la funcion (f 2), provocando asi un bucle infinito

;EJERCICIO 1.41

(define (inc x) (+ x 1))

(define (double func)
  (lambda (x) (func (func x))))


(((double (double double)) inc) 5)
;(5 + 2 ^ ((inc * 2)* 2)) = 21

;EJERCICIO 1.42
(define (inc x) (+ x 1))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (square x) (* x x))

((compose square inc) 6)   ; -> 49

;EJERCICIO 1.43
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (square x) (* x x))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)  ; Función identidad
      (let loop ((count n) (result (lambda (x) x)))
        (if (= count 0)
            result
            (loop (- count 1) (compose f result))))))

((repeated square 2) 5) ;

