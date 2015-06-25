#include <SPI.h>

// pins
int slaveSelectPin = 10;
int rstPin = 6;
int dcPin = 5;

// constants
int divider = 84;
int maxBufferIndex = 504;

// buffer
char screenBuffer[504];

void setup()
{
    Serial.begin(9600);
    
    // intialize SPI
    SPI.begin(slaveSelectPin);
    SPI.setClockDivider(slaveSelectPin, divider);
    
    // initialize pins
    pinMode(dcPin, OUTPUT);
    pinMode(rstPin, OUTPUT);
    
    // initial reset of display
    resetDisplay();
    
    // initialization of display
    digitalWrite(dcPin, LOW);
    SPI.transfer(slaveSelectPin, 0x21);
    SPI.transfer(slaveSelectPin, 0x14);
    SPI.transfer(slaveSelectPin, 0xb0);
    SPI.transfer(slaveSelectPin, 0x20);
    SPI.transfer(slaveSelectPin, 0x0c);
    digitalWrite(dcPin, HIGH);
    
    // initialize screen buffer
    resetBuffer();
}

/**
 * Loop function for main code
 */
void loop()
{
  for (int y = 0; y < 84; y++) {
    for (int x = 0; x < 48; x++) {
      setPixel(x, y, 1);
    }
    flushBuffer();
    delay(20);
  }
  //flushBuffer();
  //delay(20);
  Serial.println("fertig");
  
}

/**
 * Resets display.
 */
void resetDisplay()
{
  digitalWrite(rstPin, LOW);
  delay(500);
  digitalWrite(rstPin, HIGH);
}

/**
 * Writes the screen buffer into the display.
 *
 * It does NOT reset the buffer.
 */
void flushBuffer()
{
  for (int i = 0; i < maxBufferIndex; i++) {
    SPI.transfer(slaveSelectPin, screenBuffer[i]);
  }
}

/**
 * Resets the buffer.
 *
 * Writes 0 in all fields.
 */
void resetBuffer()
{
    for (int i = 0; i < maxBufferIndex; i++) {
        screenBuffer[i] = 0x0;
    }
}

/**
 * Sets the pixel at the given location.
 * @param x
 * @param y
 * @param value
 */
void setPixel(int x, int y, int value)
{
  int bank = x / 8;
  int relativeRow = x - bank * 8;
  int bankStartIndex = bank * 84;
  int index = bankStartIndex + y;
  char bitValue = 0x0;
  
  if (value == 1) {
    bitValue = 0xff;
  }
  
  char existingValue = screenBuffer[index];
  char pixelMask = 1 << relativeRow;
  pixelMask = 0x0 | pixelMask;
  char invMask = ~ pixelMask;
  char newValue = pixelMask & bitValue;
  
  char finalExistingValue = existingValue & invMask;
  char finalValue = finalExistingValue | newValue;

  Serial.print("bank:");
  Serial.println(bank);
  Serial.print("relRow:");
  Serial.println(relativeRow);  
  Serial.print("index:");
  Serial.println(index);
  Serial.print("value:");
  Serial.println(value);
  Serial.print("existingValue:");
  Serial.println(existingValue, BIN);
  Serial.print("finalExistingValue:");
  Serial.println(finalExistingValue, BIN);
  Serial.print("pixelMask:");
  Serial.println(pixelMask, BIN);
  Serial.print("invMask:");
  Serial.println(invMask, BIN);
  Serial.print("newValue:");
  Serial.println(newValue, BIN);
  Serial.print("finalValue:");
  Serial.println(finalValue, BIN);
  Serial.println("-----");
  screenBuffer[index] = finalValue;
}
