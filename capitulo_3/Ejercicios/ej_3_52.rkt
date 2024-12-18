#lang racket
(define sum 0)

(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))


(define (display-stream s)
  (stream-for-each displayln s))

; Sum nunca se modifica ya que esto se hace por copía es decir que se modifica otro ambiente dejando el sum original a 0 modificando solo la copia

(stream-ref y 8) ; Filtra todos los valores para que este sea siempre par haciendo que esto sea una lista de (6,10,28,36,66,78,120,138,190,210)
(display-stream z) ; Retorna todas las sumas del acumulador que son divisibles entre 5



; El valor cambiaria sin memoizacion ya que en ese caso cada vez que se accede a un elemento del string este se reinicia desde cero haciendo que sum tenga
; un valor mucho más alto del esperado, esto no pasa con memoizacion ya que se guarda en el cache haciendo que se actualice una vez por elemento procesado