#lang racket
(define (busca x lista)
  (busca-aux x lista 0 (len lista)))

(define (busca-aux x lista i j)
  (let ((m (quotient (+ i j) 2)))
  (if (>= i j)
      #f  ; Retorna falso en vez de None
        (cond
          ((= (posicion lista m) x) m) 
          ((< (posicion lista m) x) (busca-aux x lista (+ m 1) j))
          (else (busca-aux x lista i m))))))

(define (posicion objeto m)
  (if (pair? objeto)
      (list-ref objeto m)
  (vector-ref objeto m)))

(define (list-ref lista m)
  (if (= m 0)
      (car lista)
  (list-ref (cdr lista) (- m 1))))


(define (len seq)
  (cond
    ((vector? seq) (vector-length seq))
    ((list? seq) (length seq))
    (else (error "El tipo no es ni una lista ni un vector"))))

(define lista '(1 3 5 7 9 11 13 15))

(busca 7 lista) 
(busca 4 lista)

(define mi-vector (vector 1 3 5 7 9 11 13 15 17 19))

(busca 9 mi-vector)
(busca 6 mi-vector)



