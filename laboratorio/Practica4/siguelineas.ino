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

// Constantes del generador LCG
const int A = 1664525;
const int C = 1013904223;
const unsigned int M = 4294967296; // 2^32
unsigned int seed = 12345;         // Semilla inicial

// Generador LCG
unsigned int lcg()
{
  seed = (A * seed + C) % M;
  return seed;
}

// Genera un bit aleatorio (0 o 1) y lo devuelve como booleano
bool randomBit()
{
  Serial.println(seed);
  return (lcg() > M/2); // Esto asegura que siempre se devuelva true o false
}

void setup()
{

  pinMode(pinIrDer, INPUT);
  pinMode(pinIrIzq, INPUT);

  servoIzq.attach(pinServoIzq);
  servoDer.attach(pinServoDer);

  stopMotor();

  delay(500);
  forward();
}

void loop()
{
  readIRSensor();
  if ((((irSensorValues[0] == NO_LINEA) && (irSensorValues[3] == NO_LINEA)) && (irSensorValues[1] == NO_LINEA)) && (irSensorValues[2] == NO_LINEA))
  {
    if (randomBit() == 1)
      turnRight();
    else
      turnLeft();
  }
  else if ((((irSensorValues[0] == LINEA) && (irSensorValues[3] == NO_LINEA)) && (irSensorValues[1] == NO_LINEA)) && (irSensorValues[2] == NO_LINEA))
  {
    forwardMotor(EXTRA_FORWARD_TIME);
  }
  else if ((((irSensorValues[0] == NO_LINEA) && (irSensorValues[3] == LINEA)) && (irSensorValues[1] == NO_LINEA)) && (irSensorValues[2] == NO_LINEA))
  {
    forwardMotor(EXTRA_FORWARD_TIME);
  }
  else
    forward();
}

void readIRSensor()
{
  irSensorValues[0] = digitalRead(pinIrIzqIzq);
  irSensorValues[1] = digitalRead(pinIrIzq);
  irSensorValues[2] = digitalRead(pinIrDer);
  irSensorValues[3] = digitalRead(pinIrDerDer);
}

/**
 * Funcion que hace que se mantenga sobre la linea haciendo correciones y si se sale del todo, detiene el motor
 */
void forward()
{

  if (digitalRead(pinIrIzq) == NO_LINEA && digitalRead(pinIrDer) == LINEA)
  {
    servoIzq.write(0);
    servoDer.write(90);
    //	turnRight();
  }
  else if (digitalRead(pinIrIzq) == LINEA && digitalRead(pinIrDer) == NO_LINEA)
  {
    servoIzq.write(90);
    servoDer.write(180);
    //         turnLeft();
  }
  else if (digitalRead(pinIrIzq) == LINEA || digitalRead(pinIrDer) == LINEA)
  {
    forwardMotor();
  }
  else if (digitalRead(pinIrIzq) == NO_LINEA && digitalRead(pinIrDer) == NO_LINEA)
  {
    stopMotor();
  }
}

void stopMotor()
{
  servoIzq.write(90);
  servoDer.write(90);
}

void forwardMotor()
{
  servoIzq.write(0);
  servoDer.write(180);
}

void forwardMotor(int xTime)
{
  forwardMotor();
  delay(xTime);
}

void turnAround()
{
  servoIzq.write(0);
  servoDer.write(0);
  delay(TURN_AROUND_TIME);
  forward();
}

void turnRight()
{
  forwardMotor(EXTRA_FORWARD_TIME);
  servoIzq.write(0);
  servoDer.write(0);
  delay(QUARTER_BACK_TIME);
  forward();
}

void turnLeft()
{
  forwardMotor(EXTRA_FORWARD_TIME);
  servoIzq.write(180);
  servoDer.write(180);
  delay(QUARTER_BACK_TIME);
  forward();
}

