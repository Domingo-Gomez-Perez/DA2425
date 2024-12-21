import libraries.standard as standard
import libraries.serial as Serial
import libraries.string as String
import graphics.screen_updater as screen_updater
import libraries.servo as Servo


NO_LINEA = 0
LINEA = 1
TURN_AROUND_TIME = 1700
QUARTER_BACK_TIME = 50
EXTRA_FORWARD_TIME = 10
servoIzq = Servo.Servo(standard.board)
servoDer = Servo.Servo(standard.board)
pinIrIzqIzq = 10
pinIrIzq = 2
pinIrDer = 3
pinIrDerDer = 11
pinServoDer = 9
pinServoIzq = 8
irSensorValues = [0, 0, 0, 0]

seed = 98765
a = 75
c = 74
m = 65537
randomBit = 0

def setup():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	standard.pin_mode(pinIrDer, 0)
	standard.pin_mode(pinIrIzq, 0)
	servoIzq.attach(pinServoIzq)
	servoDer.attach(pinServoDer)
	stopMotor()
	standard.delay(500)
	forward()

def loop():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	readIRSensor()
	if (((irSensorValues[0] == NO_LINEA) and (irSensorValues[3] == NO_LINEA)) and ((irSensorValues[1] == LINEA) or (irSensorValues[2] == LINEA))):
		forwardMotor()
	elif (irSensorValues[0] == LINEA):
		turnLeft()
	elif (irSensorValues[3] == LINEA):
		turnRight()
	elif ((irSensorValues[0] == NO_LINEA) and (irSensorValues[2] == NO_LINEA)):
		probabilisticSearch()

def readIRSensor():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	irSensorValues[0] = standard.digital_read(pinIrIzqIzq)
	irSensorValues[1] = standard.digital_read(pinIrIzq)
	irSensorValues[2] = standard.digital_read(pinIrDer)
	irSensorValues[3] = standard.digital_read(pinIrDerDer)

def forward():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	if ((standard.digital_read(pinIrIzq) == NO_LINEA) and (standard.digital_read(pinIrDer) == LINEA)):
		servoIzq.write(0)
		servoDer.write(90)
	elif ((standard.digital_read(pinIrIzq) == LINEA) and (standard.digital_read(pinIrDer) == NO_LINEA)):
		servoIzq.write(90)
		servoDer.write(180)
	elif ((standard.digital_read(pinIrIzq) == LINEA) or (standard.digital_read(pinIrDer) == LINEA)):
		forwardMotor()
	elif ((standard.digital_read(pinIrIzq) == NO_LINEA) and (standard.digital_read(pinIrDer) == NO_LINEA)):
		stopMotor()

def stopMotor():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	servoIzq.write(90)
	servoDer.write(90)

def forwardMotor():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	servoIzq.write(0)
	servoDer.write(180)

def forwardMotor1(xTime = 0):
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	forwardMotor()
	standard.delay(xTime)

def turnAround():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	servoIzq.write(0)
	servoDer.write(0)
	standard.delay(TURN_AROUND_TIME)
	forward()

def turnRight():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	forwardMotor1(EXTRA_FORWARD_TIME)
	servoIzq.write(0)
	servoDer.write(0)
	standard.delay(QUARTER_BACK_TIME)
	forward()

def turn90Right():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	forwardMotor1(EXTRA_FORWARD_TIME)
	servoIzq.write(0)
	servoDer.write(0)
	standard.delay(545)
	forward()

def turnLeft():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	forwardMotor1(EXTRA_FORWARD_TIME)
	servoIzq.write(180)
	servoDer.write(180)
	standard.delay(QUARTER_BACK_TIME)
	forward()

def turn90Left():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	forwardMotor1(EXTRA_FORWARD_TIME)
	servoIzq.write(180)
	servoDer.write(180)
	standard.delay(545)
	forward()

def probabilisticSearch():
	global NO_LINEA
	global LINEA
	global TURN_AROUND_TIME
	global QUARTER_BACK_TIME
	global EXTRA_FORWARD_TIME
	global servoIzq
	global servoDer
	global pinIrIzqIzq
	global pinIrIzq
	global pinIrDer
	global pinIrDerDer
	global pinServoDer
	global pinServoIzq
	global irSensorValues
	global seed
	global a
	global c
	global m
	global randomBit
	seed = (((a * seed) + c) % m)
	randomBit = (seed % 2)
	if (randomBit == 1):
		turn90Right()
		forwardMotor1(400)
	else:
		turn90Left()
		forwardMotor1(400)
