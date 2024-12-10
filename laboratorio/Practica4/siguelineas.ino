#include <Servo.h>

int NO_LINEA = LOW; 
int LINEA = HIGH; 

int TURN_AROUND_TIME = 1700;
int QUARTER_BACK_TIME = 400;
int EXTRA_FORWARD_TIME = 225;


Servo servoIzq;
Servo servoDer;

int pinIrIzqIzq = 10;
int pinIrIzq = 2;
int pinIrDer = 3;
int pinIrDerDer = 11;

int pinServoDer = 9;
int pinServoIzq = 8;

int irSensorValues[] = {LOW, LOW, LOW, LOW};

unsigned long seed = 12345; // Semilla inicial

bool searching = false;

void setup(){
  Serial.begin(9600); // Initialize serial communication
  pinMode(pinIrIzqIzq, INPUT); // Initialize pinIrIzqIzq
  pinMode(pinIrDerDer, INPUT); // Initialize pinIrDerDer
  pinMode(pinIrDer, INPUT);
  pinMode(pinIrIzq, INPUT);
  
  servoIzq.attach(pinServoIzq);
  servoDer.attach(pinServoDer);

  stopMotor();

  delay(500);
  forward();
  
}

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

void readIRSensor(){
  irSensorValues[0] = digitalRead(pinIrIzqIzq);
  irSensorValues[1] = digitalRead(pinIrIzq);
  irSensorValues[2] = digitalRead(pinIrDer);
  irSensorValues[3] = digitalRead(pinIrDerDer);
}

/**
 * Funcion que hace que se mantenga sobre la linea haciendo correciones y si se sale del todo, detiene el motor
 */
void forward(){
 
  if(digitalRead(pinIrIzq) == NO_LINEA && digitalRead(pinIrDer) == LINEA){
   servoIzq.write(0); 
   servoDer.write(90);
//	turnRight();
  }else if(digitalRead(pinIrIzq) == LINEA && digitalRead(pinIrDer) == NO_LINEA){
    servoIzq.write(90); 
    servoDer.write(180);
//         turnLeft();
  }else if (digitalRead(pinIrIzq) == LINEA || digitalRead(pinIrDer) == LINEA){
    forwardMotor();
  }
   else if(digitalRead(pinIrIzq) == NO_LINEA && digitalRead(pinIrDer) == NO_LINEA){
    stopMotor();}
}

void stopMotor(){
  servoIzq.write(90); 
  servoDer.write(90);
}

void forwardMotor(){
  servoIzq.write(0); 
  servoDer.write(180);
}

void forwardMotor(int xTime){
  forwardMotor();
  delay(xTime);
}

void turnAround(){
  servoIzq.write(0); 
  servoDer.write(0);
  delay(QUARTER_BACK_TIME); 
  forward();
}

void turnRight(){
  forwardMotor(EXTRA_FORWARD_TIME / 4);
  servoIzq.write(0); 
  servoDer.write(0);
  delay(QUARTER_BACK_TIME / 4); 
  forward();
}

void turnLeft(){
  forwardMotor(EXTRA_FORWARD_TIME / 4);
  servoIzq.write(180); 
  servoDer.write(180);
  delay(QUARTER_BACK_TIME / 4); 
  forward();
}

// int generateRandomBit() {
//   seed = (1664525 * seed + 1013904223) % 4294967296; // LCG
//   Serial.println("El bit aleatorio es: " + String(seed & 1)); // Correctly format the output
//   return (seed & 1); // Devuelve el bit menos significativo
// }

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



