
;**Exercise 2.55:** Eva Lu Ator types to the
;interpreter the expression


;(car ''abracadabra)

;To her surprise, the interpreter prints back `quote`.  Explain.


;Al escribir (car ''abracadabra), realmente estas escribiendo (car (quote (quote abracadabra))),
; lo que en scheme equivale al print del quote.