# Práctica 4
```
@course Diseño de Algoritmos
@author Grupo D
@version 2024
```
### Pregunta 1: Explique con palabras como se hace girar el coche a la izquierda y a la derecha, según el código del fichero
### siguelineas.ino. Diga como se hace para leer los pines de digitales de los sensores, explicando que valores
### son los que se utilizan para detectar linea en el suelo

Para girar a la izquierda, el código escribe 180 al motor derecho usando servoDer.write(180). Esto hace que las ruedas giren en direcciones opuestas, y el coche voltea.
Para girar a la derecha, invierte la dirección, escribiendo  0 al motor izquierdo (servoIzq.write(0)).
Una vez rotado el coche se escribe 0 en el motor izquiero y 180 en el derecho para avanzar en la dirección buscada.

Los pines de los sensores infrarrojos (pinIrIzq, pinIrDer, pinIrIzqIzq, y pinIrDerDer) se configuran como entrada en setup() usando pinMode(pin, INPUT).
Los valores leídos con digitalRead(pin) pueden ser:
HIGH (1): Detecta la línea (color negro).
LOW (0): Detecta la nada (color blanco).

### Pregunta 2: . Quite el comentario y complete el código siguelineas.ino, de forma que el coche Arduino siga todo el
### circuito de manera autónoma. Véase el método loop() con el código indicado, que queda así:

void loop(){
  readIRSensor();

  if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    forwardMotor();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    forwardMotor(EXTRA_FORWARD_TIME / 2);
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    stopMotor();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    turnAround();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    forwardMotor();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    forwardMotor();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    turnRight();
  }
}


### Pregunta 3: Programe el generador de números pseudoaleatorio «LinearCongruentialGenerator», busque su definición
### en Wikipedia y utilice la siguiente estrategia probabilista para encontrar la linea: generar un bit, si el bit
### es uno girar 90 grados a la derecha y avanzar 400 ms, si es cero girar 90 grados a la izquierda y avanzar.
### Seguir así hasta encontrar la linea. Véanse los método loop(), probabilisticSearch(), probabilisticSearchStep() con el 
### código indicado, que quedan así:

void loop(){
  readIRSensor();

  if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    forwardMotor();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    forwardMotor(EXTRA_FORWARD_TIME / 2);
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    stopMotor();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    //Para la pregunta 2 se usa esta linea de codigo:
    //turnAround();
    //Para la pregunta 3 se usa esta linea de codigo:
    
    probabilisticSearch();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    forwardMotor();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    forwardMotor();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    turnLeft();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA && irSensorValues[3] == NO_LINEA) {
    turnRight();
  }

  if (searching) {
    probabilisticSearchStep();
  }
}

void probabilisticSearch() {
  searching = true;
}

void probabilisticSearchStep() {
  int bit = 0;
  seed = (1664525 * seed + 1013904223) % 4294967296; // LCG
  Serial.println("El bit aleatorio es: " + String(seed & 1)); // Correctly format the output
  bit = (seed & 1);
  if (bit == 1) {
    turnRight();
  } else {
    turnLeft();
  }
  forwardMotor(400);
  if (digitalRead(pinIrIzq) == LINEA || digitalRead(pinIrDer) == LINEA) {
    searching = false; // Stop searching if a line is found
  }
}






