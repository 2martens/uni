#include <Servo.h>

// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins

// servo
int servoPin = 11;
Servo ourServo;

// used to achieve a 10 Hz frequency
// don't touch them
long rc = 1049999;

// borders
int currentMax = 25;

/**
 * Setup function for initial setup code
 */
void setup() {
  // Configure servo
  ourServo.attach(servoPin);
  ourServo.write(90);
  
  // initialize serial port
  Serial.begin(9600);
}

/**
 * Loop function for main code
 */
void loop() {
  while (currentMax < 70) {
    move();
    Serial.print("currentMax: ");
    Serial.println(currentMax);
    if (currentMax < 70) {
      currentMax += 5;
    }
  }
  currentMax = 65;
  while (currentMax > 20) {
    move();
    Serial.print("currentMax: ");
    Serial.println(currentMax);
    if (currentMax > 20) {
      currentMax -= 5;
    }
  }
  currentMax = 25;
  delay(1000);
}

void move() {
  int currentPos = 90;
  int currentMin = 90 - currentMax;
  for (int i = 0; i <= currentMax; ++i) {
    ourServo.write(90 + i);
    currentPos = 90 + i;
    delay(10);
  }
  for (int i = currentPos; i >= currentMin; --i) {
    ourServo.write(i);
    currentPos = i;
    delay(10);
  }
  for (int i = currentPos; i <= 90; ++i) {
    ourServo.write(i);
    currentPos = i;
    delay(10);
  }
}
