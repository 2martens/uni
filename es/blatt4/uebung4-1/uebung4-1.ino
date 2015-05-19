// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins
int ledPin = 13;
int analogLevel = 0;

/**
 * Setup function for initial setup code
 */
void setup() {
    // Configure pins
    analogWrite(ledPin, 0);

    // initialize serial port
    Serial.begin(9600);
    Serial2.begin(9600);
}

/**
 * Loop function for main code
 */
void loop() {
  if (Serial2.available() > 0) {
    char command = Serial2.read();
    if (command == '1') {
      for (int i = 0; i < 255; i++) {
        analogLevel += 1;
        analogWrite(ledPin, analogLevel);
        Serial.print("LED-Level: ");
        Serial.println(analogLevel);
        delay(19);
      }
      Serial2.print('1');
      for (int i = 255; i > 0; i--) {
        analogLevel -= 1;
        analogWrite(ledPin, analogLevel);
        Serial.print("LED-Level: ");
        Serial.println(analogLevel);
        delay(19);
      }
      Serial2.print('2');
    }
  }
}
