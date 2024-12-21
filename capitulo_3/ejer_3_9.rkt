#lang racket

;Si n estuviese en el ambiente global seguiría funcionando bien porque primero los ambientes locales revisan si la n está redefinida dentro del ambiente local 

(define (factorial-1 n)            ; env --> { 'n': 6, env --> { 'n': 5, env --> { 'n': 4, env --> { 'n': 3, env --> { 'n': 2, env --> { 'n': 1 }}}}}}
  (if (= n 1)
      1
      (* n (factorial-1 (- n 1)))))

(factorial-1 6)


(define (factorial-2 n)                ; env --> { 'n': 6 }
  (fact-iter 1 1 n))

(define (fact-iter product             ; env --> { 'product': 1, 'counter': 1, 'max-count': 6, 
                   counter             ;              , env --> { 'product': 1, 'counter': 2, 'max-count': 6, 
                   max-count)          ;                            , env --> { 'product': 2, 'counter': 3, 'max-count': 6,  
  (if (> counter max-count)            ;                                          , env --> { 'product': 6, 'counter': 4, 'max-count': 6,  
      product                          ;                                                        , env --> { 'product': 24, 'counter': 5, 'max-count': 6,
      (fact-iter (* counter product)   ;                                                                      , env --> { 'product': 120, 'counter': 6, 'max-count': 6,
                 (+ counter 1)         ;                                                                                    , env --> { 'product': 720, 'counter': 7, 'max-count': 6 }}}}}}}
                 max-count)))      

(factorial-2 6)