#include <Servo>

// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins

// servo
int servoPin = 11;
Servo ourServo;

// used to achieve a 10 Hz frequency
// don't touch them
long rc = 1049999;

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
  for (int i = 90; i <= 180; ++i) {
    ourServo.write(i);
    delay(10);
  }
  delay(1000);
  for (int i = 180; i >= 0; --i) {
    ourServo.write(i);
    delay(10);
  }
  delay(1000);
  for (int i = 0; i <= 90; ++i) {
    ourServo.write(i);
    delay(10);
  }
  delay(2000);
}
