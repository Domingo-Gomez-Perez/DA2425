# Practica 4 #

## Ejercicio 1 ##

*Explique con palabras como se hace girar el coche a la izquierda y a la derecha, según el código del fichero siguelineas.ino.*


Primero se indica la dirección en la que debe moverse cada motor. Puede tomar valores entre 0 y 180. La dirección dependerá de cómo esté colocado el motor correspondiente.

En caso de tener el motor hacia la derecha (esto ocurre en la rueda derecha), lo valores serían lo siguientes:

- 180   Hacia delante
- 90    Quieto
- 0     Hacia atras

         _____________
        |             |    |
        |   Motor ->  |----|
        |_____________|    |


Si el moto apuntara a la izquierda (es el caso de la rueda izquierda), los valores serían lo contrarios.

- 180   Hacia atras
- 90    Quieto
- 0     Hacia delante

              _____________
        |    |             |
        |----|  <- Motor   |
        |    |_____________| 


Una vez se cambia el valor, el motor empieza inmediatamente a girar. Además se le da un tiempo minimo de ejecución de 400ms.

Dicho lo anterior, para conseguir el giro del coche a la derecha, se hace mover la rueda izquierda hacia delante (0), y a su vez, la rueda derecha hacia atrás (0)

---

*Diga como se hace para leer los pines de digitales de los sensores, explicando que valores son los que se utilizan para detectar linea en el suelo*

Los pines pueden tomar los valores `HIGH` o `LOW`, que corresponden a 1 o 0 respectivamente. Estos se asignan en función de si el sensor detecta que hay linea o no.

El programa llama a la función `readIRSensor` que es la encargada de asignar valores al array `irSensorValues`. Esto lo hace con la función `digitalRead` que toma como parámetro el pin que se quiere leer.

- irSensorValues[0] para el pinIrIzqIzq (Pin #10)
- irSensorValues[1] para el pinIrIzq    (Pin #2)
- irSensorValues[2] para el pinIrDer    (Pin #3)
- irSensorValues[3] para el pinIrDerDer (Pin #11)
