#lang racket
(define (busca x lista)
  (define (busca-iter i j)
    (if (>= i j)
        #f  ; Retorna falso si en vez de None
        (let ((m (quotient (+ i j) 2)))
          (cond
            ((= (posicion lista m) x) m)
            ((< (posicion lista m) x) (busca-iter (+ m 1) j))
            (else (busca-iter i m))))))
  (busca-iter 0 (len lista)))

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