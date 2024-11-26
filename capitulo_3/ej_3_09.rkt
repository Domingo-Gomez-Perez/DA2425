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


; Antes de llamar (factorial 6), tenemos el siguiente entorno global:

; global env:
;             - factorial:   - Código de la función
;                            - Puntero
 
; Cuando llamamos a (factorial 6), se crea un nuevo entorno (E1):
 
; E1:
;     - Entorno superior:   global env
;     - Variables:          n : 6
;     - Cuerpo evaluado:    (if (= n 1)
;                               1
;                               (* n (factorial (- n 1))))) 
 
; Al sustituir en el cuerpo evaluado, ( n por 6 ) , es necesario evaluar (factorial 5)
; esto supone la creación de un nuevo entorno (E2):
 
; E2:
;     - Entorno superior:   E1
;     - Variables:          n : 5
;     - Cuerpo evaluado:    (if (= n 1)
;                               1
;                               (* n (factorial (- n 1))))) 
           
; Al sustituir en el cuerpo evaluado, ( n por 5 ) , es necesario evaluar (factorial 4)
; esto supone la creación de un nuevo entorno (E3):
 
; E3:
;     - Entorno superior:   E2
;     - Variables:          n : 4
;     - Cuerpo evaluado:    (if (= n 1)
;                               1
;                               (* n (factorial (- n 1))))) 
 
; Al sustituir en el cuerpo evaluado, ( n por 4 ) , es necesario evaluar (factorial 3)
; esto supone la creación de un nuevo entorno (E4):
 
; E4:
;     - Entorno superior:   E3
;     - Variables:          n : 3
;     - Cuerpo evaluado:    (if (= n 1)
;                               1
;                               (* n (factorial (- n 1))))) 
 
; Al sustituir en el cuerpo evaluado, ( n por 3 ) , es necesario evaluar (factorial 2)
; esto supone la creación de un nuevo entorno (E5):
 
; E5:
;     - Entorno superior:   E4
;     - Variables:          n : 2
;     - Cuerpo evaluado:    (if (= n 1)
;                               1
;                               (* n (factorial (- n 1))))) 
 
; Al sustituir en el cuerpo evaluado, ( n por 2 ) , es necesario evaluar (factorial 1)
; esto supone la creación de un nuevo entorno (E6):
 
; E6:
;     - Entorno superior:   E5
;     - Variables:          n : 1
;     - Cuerpo evaluado:    (if (= n 1)
;                               1
;                               (* n (factorial (- n 1))))) 
 
; Esta vez al evaluar la expresión con n = 1, nos devuelve 1. Ahora sí, con el
; resultado calculado, vamos de nuevo hacia atrás desde E6 hasta E1, mediante
; la referencia al entorno superior, eliminando el entorno al acabar de usarlo.
 
;   E6 retorna 1 y se elimina
;   E5 calcula (* 2 1), retorna 1 y se elimina
;   E4 calcula (* 3 2), retorna 6 y se elimina
;   E3 calcula (* 4 6), retorna 24 y se elimina
;   E2 calcula (* 5 24), retorna 120 y se elimina
;   E1 calcula (* 6 120), retorna 720 y se elimina
 
 
;--------------------------------------------------------------------------------


; ** Let's check the iterative version **

(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product) (+ counter 1) max-count)))




; Antes de llamar (factorial 6), tenemos el siguiente entorno global:

; global env:
;             - factorial:   - Código de la función
;                            - Puntero
;
;             - fact-iter:   - Código de la función
;                            - Puntero

; Cuando llamamos a (factorial 6), se crea un nuevo entorno (E1):
 
; E1:
;     - Entorno superior:   global env
;     - Variables:          n : 6
;     - Cuerpo evaluado:    (fact-iter 1 1 n) 

; Al sustituir en el cuerpo evaluado, ( n por 6 ) , es necesario evaluar (fact-iter 1 1 6)
; esto supone la creación de un nuevo entorno (E2):

; E2:
;     - Entorno superior:   E1
;     - Variables:          product: 1
;                           counter 1
;                           max-count : 6
;     - Cuerpo evaluado:    (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count)))

; Al sustituir en el cuerpo evaluado, ( product por 1, counter por 1, max-count por 6 ), 
; es necesario evaluar (fact-iter 1 2 6). Esto supone la creación de un nuevo entorno (E3):

; E3:
;     - Entorno superior:   E2
;     - Variables:          product: 1
;                           counter 2
;                           max-count : 6
;     - Cuerpo evaluado:    (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count)))

; Al sustituir en el cuerpo evaluado, ( product por 1, counter por 2, max-count por 6 ), 
; es necesario evaluar (fact-iter 2 3 6). Esto supone la creación de un nuevo entorno (E4):

; E4:
;     - Entorno superior:   E3
;     - Variables:          product: 2
;                           counter 3
;                           max-count : 6
;     - Cuerpo evaluado:    (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count)))

; Al sustituir en el cuerpo evaluado, ( product por 2, counter por 3, max-count por 6 ), 
; es necesario evaluar (fact-iter 6 4 6). Esto supone la creación de un nuevo entorno (E5):

; E5:
;     - Entorno superior:   E4
;     - Variables:          product: 6
;                           counter 4
;                           max-count : 6
;     - Cuerpo evaluado:    (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count)))

; Al sustituir en el cuerpo evaluado, ( product por 6, counter por 4, max-count por 6 ), 
; es necesario evaluar (fact-iter 24 5 6). Esto supone la creación de un nuevo entorno (E6):

; E6:
;     - Entorno superior:   E5
;     - Variables:          product: 24
;                           counter 5
;                           max-count : 6
;     - Cuerpo evaluado:    (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count)))

; Al sustituir en el cuerpo evaluado, ( product por 24, counter por 5, max-count por 6 ), 
; es necesario evaluar (fact-iter 120 6 6). Esto supone la creación de un nuevo entorno (E7):

; E7:
;     - Entorno superior:   E6
;     - Variables:          product: 120
;                           counter 6
;                           max-count : 6
;     - Cuerpo evaluado:    (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count)))

; Al sustituir en el cuerpo evaluado, ( product por 120, counter por 6, max-count por 6 ), 
; es necesario evaluar (fact-iter 720 7 6). Esto supone la creación de un nuevo entorno (E8):

; E8:
;     - Entorno superior:   E7
;     - Variables:          product: 720
;                           counter 7
;                           max-count : 6
;     - Cuerpo evaluado:    (if (> counter max-count)
                                product
                                (fact-iter (* counter product)
                                          (+ counter 1)
                                          max-count)))

; Al sustituir en el cuerpo evaluado, ( product por 720, counter por 7, max-count por 6 ), 
; este devuelve el valor de product (720). Ahora sí, con el resultado calculado, vamos de
; nuevo hacia atrás desde E6 hasta E1, mediante la referencia al entorno superior, eliminando 
; el entorno al acabar de usarlo.
 
;   E6 retorna 720 a E5 y se elimina
;   E5 retorna 720 a E4 y se elimina
;   E4 retorna 720 a E3 y se elimina
;   E3 retorna 720 a E2 y se elimina
;   E2 retorna 720 a E1 y se elimina
;   E1 retorna 720 a gloval env y se elimina