#lang racket
(car ''abracadabra)
; La razon por la que evalua 'quote es por que hay dos ' que son el operador de quote seguidas el primero crea la lista y el segundo es el primer elemento de la lista por lo que car obtine quote
; Además nunca se llega a evaluar abracadabra que no esta definido por lo que no hay errores de compilación

