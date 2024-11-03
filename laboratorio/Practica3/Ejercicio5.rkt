#lang racket


(define (length s)
    (if (null? s)
        0
	(+ 1 (length (cdr s)))))


(define (divide archivo)
  (let ((coordenadas (next-line-it archivo)))
    (define (divide-rec coordenadas result)
      (if (null? coordenadas)
          (sort result <=) 
         (divide-rec (cdr coordenadas) (cons (string->number(car (string-split (car coordenadas) " "))) result))
         ))
  (divide-rec coordenadas null)))

(define (p2 lista length resultp2 a)
 (if (= a (quotient length 2))
     resultp2
     (p2 (cdr lista) length (cons (car lista) resultp2) (+ a 1))
   )
 )




(define (p1 lista length resultp1 a)
  (p2 (reverse lista) length resultp1 a)
 )



(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (let ((valor (next-line-it file)))
      (cons line (if (void? valor) null valor ))))))


(define listapuntos(call-with-input-file "ej_pts_europa.txt" divide))
(display (length listapuntos))
(newline)


(define P2 (p2 (call-with-input-file "ej_pts_europa.txt" divide) (length listapuntos) null 0))
(display "P2")
(newline)
(display (length P2))
(newline)
(display P2)
(newline)

(define P1 (p1 (call-with-input-file "ej_pts_europa.txt" divide) (length listapuntos) null 0))
(display "P1")
(newline)
(display (length P1))
(newline)
(display P1)
(newline)








