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
    Wire.onReceive(receiveEvent);

    // initialize serial port
    Serial.begin(9600);
}

/**
 * Loop function for main code
 */
void loop() {
  Wire.beginTransmission(slaveAddress);
  Wire.write(1);
  Wire.endTransmission();
  delay(100);
  Wire.beginTransmission(slaveAddress);
  Wire.write('r');
  Wire.endTransmission();
  delay(1900);
  Wire.beginTransmission(slaveAddress);
  Wire.write(0);
  Wire.endTransmission();
  delay(100);
  Wire.beginTransmission(slaveAddress);
  Wire.write('r');
  Wire.endTransmission();
  delay(1900);
}

void receiveEvent(int readBytes)
{
  int x = Wire.read();
  Serial.print("Result: ");
  Serial.println(x ? "on" : "off");
}
