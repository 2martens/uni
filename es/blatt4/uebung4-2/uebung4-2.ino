#include <Wire.h>

// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins
int ledPin = 13;
int analogLevel = 0;
int slaveAddress = 4;

/**
 * Setup function for initial setup code
 */
void setup() {
    // Configure pins
    Wire.begin();
    pinMode(ledPin, OUTPUT);
    digitalWrite(ledPin, LOW);
    // initialize serial port
    Serial.begin(9600);
}

void writeResult(bool result)
{
  Serial.print("Result: ");
  Serial.println(result ? "on" : "off");
}

/**
 * Loop function for main code
 */
void loop() {
  Wire.beginTransmission(slaveAddress);
  Wire.write(1);
  Wire.endTransmission();
  delay(100);
  Wire.requestFrom(slaveAddress, 1);
  if (Wire.available()) {
    int x = Wire.read();
    writeResult((bool) x);
  }
  delay(1900);
  Wire.beginTransmission(slaveAddress);
  Wire.write(0);
  Wire.endTransmission();
  delay(100);
  Wire.requestFrom(slaveAddress, 1);
  if (Wire.available()) {
    int x = Wire.read();
    writeResult((bool) x);
  }
  delay(1900);
}

