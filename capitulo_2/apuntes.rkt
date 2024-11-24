#lang racket


; PREGUNTAR: EL 2.6 que es lo uqe hay que hacer y como se hace el +

; EL 39 vale con el append en el fold right??

; el special patterns (tiene que poder buscar, si es el simbolo jsuto hace cosas (intentar recuivo))

; el special binding (te tiene que decir la estructura completa y hay que pode buscar cada cosa)

; el E (es para hacer imports (hay que poner los defines dentro y usar los register y tal al general))

; el F (cosas de mensajes)

#|
Chapter 2 : Building Abstractions with Data

Hecho por: Gabriel Gomez Garcia
|#

#|
2.1 Introduction to Data Abstraction
|#

; En resumen, ¿Como representamos los datos?

#| 2.1.1Example: Arithmetic Operations for Rational Numbers |#
; Empezamos con los pares.
(define x (cons 1 2))
; es un par
(car x)
1

(cdr x)
2

; con car cogemos el primero, con cdr el segundo
; Pueden ser de lo que sea los pares, numeros, variables...

; Ahora nos hablan de hacer cosas como numerador y denominador por hacer algo con la info
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g)
          (/ d g))))

; Por ejemplo eso para hacer fracciones y simplificarlas

#| 2.1.2Abstraction Barriers |#
; Va todo de ir abstrayendo cosas para hacerlas mas sencillas
; pasamos de usar car y cdr a hacer numeradores a hacer operaciones...

#| 2.1.3What Is Meant by Data? |#
; Te explica un poco como funciona el cons por dentro, podriamos implementar los pares
; nosotros mismos pero ya lo implementa scheme por nosotros por eficiencia

; bastante lio lo de los procedimientos como numeros no entiendo bien

#| 2.1.4Extended Exercise: Interval Arithmetic |#
; No entra;

; Va de en vez de sumar restar... numeros, hacerlo con intervalos y como se podria definir
; te explica sumar, resta, division, multiplicacion... pero en vez de numeros, intervalos

#|
2.2 Hierarchical Data and the Closure Property
|#

; nos explican que es una lista enlazada

#| 2.2.1Representing Sequences |#

; Asi enlazando muchos cons y al final un null, pues tenemos una lista
(cons 1
      (cons 2
            (cons 3
                  (cons 4 null))))
; como escribirlo asi es horrible pues han hecho un acortamiento:
(list 1 2 3 4)
; cuidado no poner sin list que no es lo mismo (1 2 3 4)

; cosas que nos da el scheme para ayudarnos con las listas:
; null? nos deja ver si la lista esta vacia.
; lenght nos da el numero de elementos en la lista.
; append para juntar dos listas
; (car s)            ; -> 1
; (cadr s)           ; -> 2
; (caddr s)          ; -> 3
; (cddr s)           ; -> (3) (va de atras alante)

; para recorrer una lista
; (define (do-something s)
;     (if (null? s)
;         base-case
; 	(<op> (do-something (cdr s)))))


; lo del punto en los parametros.
; si tu pones x y . resto, x e y seran el parametro 1 y 2 y lo demas sera una lista con todos los extras

; Mapping over lists
; es aplicar una transformacion a cada uno de los elementos de una lista
; lo general seria:
(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))

; (donde dice nil en verdad es null)
; asi con esa procedimiento se abstrae la funcionalidad

; cosas importantes:
; void para que no devuelva nada el procedimiento
; begin para poder poner varias cosas en el if

#| 2.2.2Hierarchical Structures |#
; listas de listas, se puede ver como un arbol las listas de listas
; Explica como ir contando las hojas del arbol (cada numero al final es una hoja)

; tambien se puede hacer mapping sobre arboles, mas abstraccion pero va a cada hoja
; a hacer la abstraccion

(define (scale-tree tree factor)
  (cond ((null? tree) null)
        ((not (pair? tree))
         (* tree factor))
        (else
         (cons (scale-tree (car tree)
                           factor)
               (scale-tree (cdr tree)
                           factor)))))
; y ya con ese esquema se hace de to.
; incluso con map se puede reducir mas:
; esto es para escalar con el factor pero se puede ampliar para todo
(define (scale-tree2 tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree2 sub-tree factor)
             (* sub-tree factor)))
       tree))

; ampliado para todo:
(define (mapa-tree proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (mapa-tree proc sub-tree)  ; Llamada recursiva si es un subárbol
             (proc sub-tree)))           ; Aplicar el procedimiento a la hoja
       tree))

#| 2.2.3 Sequences as Conventional Interfaces |#
; Habla de abstraer la funcionalidad (como siempre) para sacar todo a un enumerate
; Es mucho esto la verdad. va explicando como ir extrayendo cosas y todo como secuencias

; Todo lo demas de imagenes, ajedrez... no hace falta estudiarlo!!
; pasamos al siguiente punto directamente

#|
2.3 Symbolic Data
|#
; Por ahora solo teniamos listas de numeros, ahora es cuando empieza a molar
; vamos a poder tener listas de todo lo que queramos pero necesitamos una manera de
; poder llamar a esas listas porque si ponemos letras sin mas no da error porque no existen
; esas variables.

; con quote y entre parentesis lo que sea, te devuelve una lista tal cual lo que tenga dentro.
; por ejemplo (quote (* (+ 23 45) (+ x 9))) devuelve tal cual sin operar.
; tambien se puede escribir con ' al principio del parentesis para ponerlo mas facil
; '(* (+ 23 45) (+ x 9))

; asi todo lo que pongamos se puede tratar como datos y no cosas que evaluar, ademas
; se puede usar las operaciones de las listas para todo lo de las quotes

(define a 1)
(define b 2)

(list a b)
; (1 2)

(list 'a 'b)
; (a b)

(list 'a b)
; (a 2)

; tambien se puede el car y cdr
(car '(a b c))
; a

(cdr '(a b c))
; (b c)

; otra cosa importante que se puede hacer es saber si un elemento esta en una lista
; usando el eq? para cada elemento de la lista a ver si lo encuentra
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

; *ejercicios de aprender a usarlas*
; *ahora ejercicios especiales*

#| 2.3.2Example: Symbolic Differentiation |#
; queremos que nos haga la derivada esto. pero no que la calcule si no que nos enseñe
; la expresion algebraica bonita sin calcular (para tener que manipular simbolos)

; asi suena super grande ya que hay muchas opciones de derivar asi que vamos a reducir esto
; a algo mas pequeñito: suma y multiplicacion con solo 2 argumentos (en el libro las formulas)

; Asi la suma y multiplicacion son recursivas y se van descomponiendo en cosas mas pequeñas y al final van
; a producir constantes con valo 0 o 1 en la derivada. Tenemos muchos procedimientos para esto:

; sigo la explicacion en el ejercicio 56 ya que va de esto

#| 2.3.3Example: Representing Sets |#
; ya vemos que si podemos representar listas, podemos representar mas estructuras de datos

; ahi nos explican como implementar un set con sus operaciones de union, interseccion...
; *No entra!*

; ahora lo complica mas representando el set como un arbol binario para bajar la complejidad temporal
; eso si, tienen que ser todos los elementos del mismo tipo y hacer un arbol balanceado
; (lo que hicimos en estructura de datos)

; todo lo demas de aqui no entra y se complica bastante asi que no lo voy a leer mucho.
; habla de huffman trees y de codificar simbolos con bits

#|
2.4 Multiple Representations for Abstract Data
|#
; Nos explican distintas maneras de representar los datos, todo lo del libro es
; aburridisimo la vd que si complejos, que si noseque...
; sinceramente horrible todo. Voy a hacer caso a los apuntes y a hacer los ejercicios del a al f mejor
; En resumen que havy varias maneras de hacer las cosas para todo

; Problem: The box
; Tenemos a dos personas, Bob y Alice

; Bob representa el cuadrado como un punto inicial y alto y ancho
; Alice representa el cuadrado como punto inicial y punto final (opuestos)

; Las dos son distintas pero describen la misma caja pero ahora, si queremos que
; las dos definiciones esten en el mismo codigo, como lo hacemos si se llaman igual
; ademas llamarlo con un prefijo bob o alice es un poco feo.
; * hacer el A*

; vemos que los dos son la misma estructura pero cada uno lo enteinde distinto


; Type Identification
; si queremos hacer un metodo width que nos diga bien el atributo con cualquiera de las dos
; es imposible porque solo se puede tener un nombre igual y el cuadrado se representa igual
; por lo que no puedes saber con que representacion estás trabajando.
; para eso sirven los tags

; para poner un tag y para ver el contenido y el tipo
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; ejemplo
(define dato (attach-tag 'int 23))    ; -> (int 23)
(type-tag dato)                       ; -> 'int
(contents dato)                       ; -> 23

; hasta el ejercicio c esta como crear metodos genericos. sigamos

; Al hacer asi lo sprocedimientos genericos, esta preparado para que mira por esas tags
; en concreto y como haya nuevas no va a funcionar :/ para arreglar esto se puede crear un
; registro con todas las posibilidades que se puedan (como un diccionario)

; Hemos hecho antes un set y jugado con llaves y valores pero como que era todo muy handmade
; racket tiene un tipo hash y todo. Hay que ir registrando cosas poco a poco.

; En el 2d lo hago.

; ahora otra cosa Problem: Namespaces

; Haber dejado todo escrito ahi tal cual lo deja todo muy feo porque ahora se puede ver todo desde
; cualquier parte del programa y queda mal. Asi que para eso lo podemos meter todo dentro de un
; namespace (dentro de un define) para que no se vea toda la implementacion interna desde fuera


#|
2.5 Systems with Generic Operations
|#

; habla de como crear procedimientos genericos para cualquier tipo de dato
; por ejemplo que haga suma para int, para complejos, para float...

; Si se hace una funcion distinta para cada tipo de dato se vuelve una locura con 8000 funciones distintas
; Y pues al final se creó la gerarquía de tipos y int -> float -> complex y cada uno se ocupa de lo suyo

; hay muchas cosas que dice el libro sobre esto pero no entra creo :)