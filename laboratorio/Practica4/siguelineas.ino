#include <Servo.h>

int NO_LINEA = LOW; 
int LINEA = HIGH; 

int TURN_AROUND_TIME = 1700;
int QUARTER_BACK_TIME = 400;
int EXTRA_FORWARD_TIME = 225;

// Declaración de servos
Servo servoIzq;
Servo servoDer;

// Pines de los sensores
int pinIrIzqIzq = 10;
int pinIrIzq = 2;
int pinIrDer = 3;
int pinIrDerDer = 11;

// Pines de los servos
int pinServoDer = 9;
int pinServoIzq = 8;

// Valores de los sensores
int irSensorValues[] = {LOW, LOW, LOW, LOW};

// Variables para el generador pseudoaleatorio (LCG)
long seed = 12345;  
long a = 1103515245; 
long c = 12345; 
long m = 65536; 

void setup() {
  pinMode(pinIrDer, INPUT);
  pinMode(pinIrIzq, INPUT);
  
  servoIzq.attach(pinServoIzq);
  servoDer.attach(pinServoDer);

  stopMotor();
  delay(500);
  forward();
}

void loop() {
  readIRSensor();
  
  if (irSensorValues[0] == NO_LINEA && irSensorValues[3] == NO_LINEA && 
      (irSensorValues[1] == LINEA || irSensorValues[2] == LINEA)) {
    forwardMotor();
  } else if (irSensorValues[0] == LINEA) {
    turnLeft();
  } else if (irSensorValues[3] == LINEA) {
    turnRight();
  } else if (irSensorValues[0] == NO_LINEA && irSensorValues[3] == NO_LINEA) {
    probabilisticSearch();
  }
}

void readIRSensor() {
  irSensorValues[0] = digitalRead(pinIrIzqIzq);
  irSensorValues[1] = digitalRead(pinIrIzq);
  irSensorValues[2] = digitalRead(pinIrDer);
  irSensorValues[3] = digitalRead(pinIrDerDer);
}

void forward() {
  if (digitalRead(pinIrIzq) == NO_LINEA && digitalRead(pinIrDer) == LINEA) {
    servoIzq.write(0); 
    servoDer.write(90);
  } else if (digitalRead(pinIrIzq) == LINEA && digitalRead(pinIrDer) == NO_LINEA) {
    servoIzq.write(90); 
    servoDer.write(180);
  } else if (digitalRead(pinIrIzq) == LINEA || digitalRead(pinIrDer) == LINEA) {
    forwardMotor();
  } else if (digitalRead(pinIrIzq) == NO_LINEA && digitalRead(pinIrDer) == NO_LINEA) {
    stopMotor();
  }
}

void stopMotor() {
  servoIzq.write(90); 
  servoDer.write(90);
}

void forwardMotor() {
  servoIzq.write(0); 
  servoDer.write(180);
}

void forwardMotor(int xTime) {
  forwardMotor();
  delay(xTime);
}

void turnAround() {
  servoIzq.write(0); 
  servoDer.write(0);
  delay(TURN_AROUND_TIME); 
  forward();
}

void turnRight() {
  forwardMotor(EXTRA_FORWARD_TIME);
  servoIzq.write(0); 
  servoDer.write(0);
  delay(QUARTER_BACK_TIME); 
  forward();
}

void turnLeft() {
  forwardMotor(EXTRA_FORWARD_TIME);
  servoIzq.write(180); 
  servoDer.write(180);
  delay(QUARTER_BACK_TIME); 
  forward();
}

// Estrategia probabilista
void probabilisticSearch() {
  seed = (a * seed + c) % m; // LCG para generar un número pseudoaleatorio
  int randomBit = seed % 2;

  if (randomBit == 1) {
    turnRight();
    forwardMotor(400); // Avanza 400 ms
  } else {
    turnLeft();
    forwardMotor(400); // Avanza 400 ms
  }
}











