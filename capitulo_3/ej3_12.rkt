#lang racket
(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y)))) ; Construye una nueva lista.

(define (append! x y)
  (set-mcdr! (last-pair x) y) ; Modifica el último par de x.
  x)

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x)))) ; Encuentra el último par de la lista x.

; Interacción
(define x (mcons 'a (mcons 'b null))) ; x --> [a | o] --> [b | nil]
(define y (mcons 'c (mcons 'd null))) ; y --> [c | o] --> [d | nil]

(define z (append x y)) ; Se crea una nueva lista, dejando x e y sin cambios.

; Paso 1:
; Llamada inicial: (append x y)
; x = [a | o] --> [b | nil], y = [c | o] --> [d | nil]

; (mcons (mcar x) (append (mcdr x) y)) 
; 1. mcar x = 'a
; 2. (append (mcdr x) y) donde (mcdr x) = [b | nil]

; Paso 2:
; x = [b | nil], y = [c | o] --> [d | nil]

; (mcons (mcar x) (append (mcdr x) y))
; 1. mcar x = 'b
; 2. (append (mcdr x) y) donde (mcdr x) = null

; Paso 3:
; x = null, y = [c | o] --> [d | nil]

; Al llegar a (if (null? x) y), retorna y directamente: [c | o] --> [d | nil]

; Construcción final:
; Retorna: [a | o] --> [b | o] --> [c | o] --> [d | nil]

z
; -> (mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

x
; x sigue siendo [a | o] --> [b | nil]

(mcdr x)
; response: 
; (mcdr x) sigue siendo [b | nil], ya que x no ha sido modificado.
; Diagrama:
; x --> [a | o] --> [b | nil]

; Ahora, ejecutamos append!:
(define w (append! x y)) ; Mutamos x para que su último par apunte a y.

; Paso 1: 
; (last-pair x)
; x = [a | o] --> [b | nil]
; mcdr x = [b | nil], recursión...

; Paso 2:
; x = [b | nil]
; mcdr x = null -> Este es el último par.

; Paso 3:
; (set-mcdr! (last-pair x) y)
; Se modifica el cdr del último par ([b | nil]) para apuntar a y.

; Resultado mutado:
; x --> [a | o] --> [b | o] --> [c | o] --> [d | nil]
; w apunta al mismo objeto que x.

w
; -> (mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

x
; x ahora es [a | o] --> [b | o] --> [c | o] --> [d | nil]

(mcdr x)
; response: 
; (mcdr x) ahora es [b | o] --> [c | o] --> [d | nil], porque x fue modificado.
; Diagrama:
; x --> [a | o] --> [b | o] --> [c | o] --> [d | nil]
