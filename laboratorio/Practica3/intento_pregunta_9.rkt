#lang racket

;; Calcular la distancia euclidiana entre dos puntos
(define (distancia p1 p2)
  (let ([dx (- (car p1) (car p2))]
        [dy (- (cadr p1) (cadr p2))])
    (sqrt (+ (* dx dx) (* dy dy)))))

;; Encontrar la pareja más próxima por fuerza bruta
(define (fuerza-bruta puntos)
  (let loop ([puntos puntos]
             [mejor-distancia +inf.0]
             [mejor-pareja '()])
    (if (null? puntos)
        mejor-pareja
        (let* ([p (car puntos)]
               [resto (cdr puntos)]
               [mejor-del-resto (foldl
                                 (lambda (q mejor)
                                   (let ([d (distancia p q)])
                                     (if (< d (car mejor))
                                         (list d (list p q))
                                         mejor)))
                                 (list mejor-distancia mejor-pareja)
                                 resto)])
          (loop resto (car mejor-del-resto) (cadr mejor-del-resto))))))

;; Dividir puntos en dos mitades según la coordenada x
(define (dividir puntos)
  (let* ([n (length puntos)]
         [mitad (quotient n 2)])
    (values (take puntos mitad) (drop puntos mitad))))

;; Combinar resultados de las dos mitades
(define (combinar izquierda derecha delta)
  (let ([en-banda (filter
                   (lambda (p) (and (>= (car p) (- (car (last izquierda)) delta))
                                    (<= (car p) (+ (car (first derecha)) delta))))
                   (append izquierda derecha))])
    (foldl (lambda (p mejor)
             (foldl (lambda (q mejor-actual)
                      (let ([d (distancia p q)])
                        (if (< d (car mejor-actual))
                            (list d (list p q))
                            mejor-actual)))
                    mejor
                    (cdr (drop-while (lambda (q) (< (car q) (+ (car p) delta))) en-banda))))
           (list delta '())
           en-banda)))

;; Algoritmo principal: Divide y vencerás
(define (pareja-mas-cercana puntos)
  (if (< (length puntos) 4)
      (fuerza-bruta puntos)
      (let* ([ordenados (sort puntos < #:key car)]
             [izquierda derecha] (dividir ordenados)
             [res-izq (pareja-mas-cercana izquierda)]
             [res-der (pareja-mas-cercana derecha)]
             [delta (min (car res-izq) (car res-der))])
        (combinar izquierda derecha delta))))

;; Prueba con un conjunto de puntos
(define puntos '((2 3) (12 30) (40 50) (5 1) (12 10) (3 4)))
(display (pareja-mas-cercana puntos))
