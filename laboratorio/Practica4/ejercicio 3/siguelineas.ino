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

unsigned long seed = 12345;    // Semilla inicial
const unsigned long a = 22695477;  // Constante multiplicadora
const unsigned long c = 0; // Incremento
const unsigned long m = 4294967296; // Modulo (2^32)
int bit = ((seed >> 3) ^ (seed >> 5) ^ seed) & 1;
int contador_giros = 0;

void setup(){
  Serial.println("test1");
  Serial.begin(9600);

  pinMode(pinIrDer, INPUT);
  pinMode(pinIrIzq, INPUT);
  
  servoIzq.attach(pinServoIzq);
  servoDer.attach(pinServoDer);

  stopMotor();

  delay(500);
  forward();
  readIRSensor();
  
}

void loop(){
  Serial.println("test2");
  readIRSensor();
  if(irSensorValues[0] == NO_LINEA && irSensorValues[1] == NO_LINEA && irSensorValues[2] == NO_LINEA && irSensorValues[3] == NO_LINEA){
    if (contador_giros == 0) {
      seed = (a * seed + c) % m;
      bit = ((seed >> 3) ^ (seed >> 5) ^ seed) & 1;
    }
    if (bit == 0){
      turnLeft();
    }
    else if (bit == 1) {
      turnRight();
    }
    contador_giros++;
    if (contador_giros == 4) {
      forwardMotor(400);
      contador_giros = 0;
    }
  }
  else {
    contador_giros = 0;
    if(irSensorValues[1] == NO_LINEA && irSensorValues[2] == LINEA){
      servoIzq.write(0); 
      servoDer.write(90);
    }
    else if(irSensorValues[1] == LINEA && irSensorValues[2] == NO_LINEA){
      servoIzq.write(90); 
      servoDer.write(180);
    }
    else if (irSensorValues[1] == LINEA || irSensorValues[2] == LINEA){
      forwardMotor();
    }
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
  delay(TURN_AROUND_TIME); 
  forward();
}

void turnRight(){
  forwardMotor(EXTRA_FORWARD_TIME);
   servoIzq.write(0); 
   servoDer.write(90);
  delay(QUARTER_BACK_TIME/2); 
  forward();
}

void turnLeft(){
  forwardMotor(EXTRA_FORWARD_TIME);
   servoIzq.write(90); 
   servoDer.write(180);
  delay(QUARTER_BACK_TIME/2); 
  forward();
}
















