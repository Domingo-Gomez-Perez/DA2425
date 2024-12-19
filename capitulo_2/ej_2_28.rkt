#lang racket
(define (fringe mylist)
  (define (fringe-iter mylist result)
    (if (null? mylist)
        result
        (if (pair? (car mylist))
            (fringe-iter (car mylist) (fringe-iter (cdr mylist) result))
            (if (null? (cdr mylist))
                (cons (car mylist) result)
                (cons (car mylist) (fringe-iter (cdr mylist) result))))))

  (fringe-iter mylist null))

(fringe (list (list 1 2) (list 3 4)))
(fringe (list (list 1 2 (list 3 4)) 5 6 7))
(fringe (list (list 1 (list 2)) 3 4 5))
