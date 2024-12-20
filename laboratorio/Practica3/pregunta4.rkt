#lang racket

;Planteamos la separación de la nube de puntos según que den a la izquierda o a la derecha de cierta recta vertical,es decir, escogemos x0 ∈ Q y adscribimos
;a P1 los puntos (x, y) que cumplan x < x0 y a P2 los que cumplan x > x0. ¿Siempre podemos encontrar x0 ∈ Q de modo tal que este sistema reparta todos los
;puntos de la lista inicial en sublistas con |P1| - |P2| ≤ 1?

;Si es posible encontar un x0. El algoritmo planteado funciona de la siguiente manera: Encuentra un x central para repartir la nube de puntos de manera equitativa
;y en funcion de ese punto se dividen los distintos puntos en las listas P1 y P2. Para explicarlo mejor vamos a dar un ejemplo. Si tenemos una nube de 99 elementos
;vamos a tomar todas las coordenadas x para decidir cual va a a ser nuestro x0 (cogeremos el punto medio para que se cumpla la formula)
;por lo que siempre va a existir una x0 central, en este caso 50 que hace que a P1 vayan 50 elementos y a P2 49 por lo que si aplicamos
;la formula ||50|-|49|| <= 1 se cumple.