#lang racket
((lambda (f)
   ((lambda (fact)
      (fact fact 5))
    (lambda (fact n)
      (if (= n 0)
          1
          (* n (fact fact (- n 1)))))))
 (lambda (fact n) (fact fact n)))
