#include <SPI.h>
#include <SD.h>

// pins
int slaveSelectPin = 10;
int SDslaveSelectPin = 4;
int rstPin = 6;
int dcPin = 5;

// constants
int divider = 84;
int maxBufferIndex = 504;

// buffer
char screenBuffer[504];

// ASCII data
unsigned char font[95][6] =
    {
        { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }, // space
        { 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 }, // !
        { 0x00, 0x07, 0x00, 0x07, 0x00, 0x00 }, // "
        { 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00 }, // #
        { 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00 }, // $
        { 0x23, 0x13, 0x08, 0x64, 0x62, 0x00 }, // %
        { 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 }, // &
        { 0x00, 0x00, 0x07, 0x00, 0x00, 0x00 }, // '
        { 0x00, 0x1C, 0x22, 0x41, 0x00, 0x00 }, // (
        { 0x00, 0x41, 0x22, 0x1C, 0x00, 0x00 }, // )
        { 0x0A, 0x04, 0x1F, 0x04, 0x0A, 0x00 }, // *
        { 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 }, // +
        { 0x00, 0x50, 0x30, 0x00, 0x00, 0x00 }, // ,
        { 0x08, 0x08, 0x08, 0x08, 0x08, 0x00 }, // -
        { 0x00, 0x60, 0x60, 0x00, 0x00, 0x00 }, // .
        { 0x20, 0x10, 0x08, 0x04, 0x02, 0x00 }, // slash
        { 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 }, // 0
        { 0x00, 0x42, 0x7F, 0x40, 0x00, 0x00 }, // 1
        { 0x42, 0x61, 0x51, 0x49, 0x46, 0x00 }, // 2
        { 0x21, 0x41, 0x45, 0x4B, 0x31, 0x00 }, // 3
        { 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 }, // 4
        { 0x27, 0x45, 0x45, 0x45, 0x39, 0x00 }, // 5
        { 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 }, // 6
        { 0x03, 0x71, 0x09, 0x05, 0x03, 0x00 }, // 7
        { 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 }, // 8
        { 0x06, 0x49, 0x49, 0x29, 0x1E, 0x00 }, // 9
        { 0x00, 0x36, 0x36, 0x00, 0x00, 0x00 }, // :
        { 0x00, 0x56, 0x36, 0x00, 0x00, 0x00 }, // ;
        { 0x08, 0x14, 0x22, 0x41, 0x00, 0x00 }, // <
        { 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 }, // =
        { 0x00, 0x41, 0x22, 0x14, 0x08, 0x00 }, // >
        { 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 }, // ?
        { 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00 }, // @
        { 0x7E, 0x11, 0x11, 0x11, 0x7E, 0x00 }, // A
        { 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 }, // B
        { 0x3E, 0x41, 0x41, 0x41, 0x22, 0x00 }, // C
        { 0x7F, 0x41, 0x41, 0x41, 0x3E, 0x00 }, // D
        { 0x7F, 0x49, 0x49, 0x49, 0x41, 0x00 }, // E
        { 0x7F, 0x09, 0x09, 0x09, 0x01, 0x00 }, // F
        { 0x3E, 0x41, 0x41, 0x49, 0x7A, 0x00 }, // G
        { 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 }, // H
        { 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 }, // I
        { 0x20, 0x40, 0x41, 0x3F, 0x01, 0x00 }, // J
        { 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 }, // K
        { 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 }, // L
        { 0x7F, 0x02, 0x0C, 0x02, 0x7F, 0x00 }, // M
        { 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 }, // N
        { 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 }, // O
        { 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 }, // P
        { 0x3E, 0x41, 0x51, 0x21, 0x5E, 0x00 }, // Q
        { 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 }, // R
        { 0x26, 0x49, 0x49, 0x49, 0x32, 0x00 }, // S
        { 0x01, 0x01, 0x7F, 0x01, 0x01, 0x00 }, // T
        { 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 }, // U
        { 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 }, // V
        { 0x3F, 0x40, 0x38, 0x40, 0x3F, 0x00 }, // W
        { 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 }, // X
        { 0x07, 0x08, 0x70, 0x08, 0x07, 0x00 }, // Y
        { 0x61, 0x51, 0x49, 0x45, 0x43, 0x00 }, // Z
        { 0x00, 0x7F, 0x41, 0x41, 0x00, 0x00 }, // [
        { 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 }, // backslash
        { 0x00, 0x41, 0x41, 0x7F, 0x00, 0x00 }, // ]
        { 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 }, // ^
        { 0x40, 0x40, 0x40, 0x40, 0x40, 0x00 }, // _
        { 0x00, 0x01, 0x02, 0x04, 0x00, 0x00 }, // `
        { 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 }, // a
        { 0x7F, 0x48, 0x44, 0x44, 0x38, 0x00 }, // b
        { 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 }, // c
        { 0x38, 0x44, 0x44, 0x48, 0x7F, 0x00 }, // d
        { 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 }, // e
        { 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 }, // f
        { 0x08, 0x54, 0x54, 0x54, 0x3C, 0x00 }, // g
        { 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 }, // h
        { 0x00, 0x48, 0x7D, 0x40, 0x00, 0x00 }, // i
        { 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 }, // j
        { 0x7F, 0x10, 0x28, 0x44, 0x00, 0x00 }, // k
        { 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 }, // l
        { 0x7C, 0x04, 0x78, 0x04, 0x78, 0x00 }, // m
        { 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 }, // n
        { 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 }, // o
        { 0x7C, 0x14, 0x14, 0x14, 0x08, 0x00 }, // p
        { 0x08, 0x14, 0x14, 0x18, 0x7C, 0x00 }, // q
        { 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 }, // r
        { 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 }, // s
        { 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 }, // t
        { 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 }, // u
        { 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 }, // v
        { 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 }, // w
        { 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 }, // x
        { 0x0C, 0x50, 0x50, 0x50, 0x3C, 0x00 }, // y
        { 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 }, // z
        { 0x00, 0x08, 0x36, 0x41, 0x00, 0x00 }, // {
        { 0x00, 0x00, 0x7F, 0x00, 0x00, 0x00 }, // |
        { 0x00, 0x41, 0x36, 0x08, 0x00, 0x00 }, // }
        { 0x10, 0x08, 0x08, 0x10, 0x08, 0x00 } // ~
    };

// tmp vars
int readStringLength = 0;

void setup()
{
  Serial.begin(9600);

  // initialize SPI
  SPI.begin(slaveSelectPin);
  SPI.setClockDivider(slaveSelectPin, divider);

  // initialize SD
  SD.begin(SDslaveSelectPin);

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
  // write my data
  printString(9, 33, "Jim", 3);
  printString(19, 21, "Martens", 7);
  printString(29, 21, "6420323", 7);
  flushBuffer();
  resetBuffer();
  delay(5000);
  // write his data
  printString(9, 21, "Joachim", 7);
  printString(19, 6, "Schmidberger", 12);
  printString(29, 21, "6536496", 7);
  flushBuffer();
  resetBuffer();
  delay(5000);
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
  char invMask = ~ pixelMask;
  char newValue = pixelMask & bitValue;
  
  char finalExistingValue = existingValue & invMask;
  char finalValue = finalExistingValue | newValue;
  screenBuffer[index] = finalValue;
}

/**
 * Prints given char at given location.
 *
 * @param x
 * @param y
 * @param value
 *
 * @return 0 on success, -1 otherwise
 */
int printChar(int x, int y, char value)
{
  // guardians
  if (x > 40 || y > 78) {
    // absolute guardian
    return -1;
  }
  // TODO relative guardian to existing buffer

  char space = ' ';
  int arrayIndex = value - space;

  for (int i = 0; i < 6; i++) {
    char data = font[arrayIndex][i];
    for (int _x = 0; _x < 8; _x++) {
      char bitmask = 1 << _x;
      char pixel = bitmask & data;
      int pixelInt = 0;
      if (pixel != 0x0) {
        pixelInt = 1;
      }
      setPixel(x + _x, y + i, pixelInt);
    }
  }

  return 0;
}

/**
 * Prints a string.
 *
 * @param int x
 * @param int y
 * @param char* text
 * @param int textLength
 */
int printString(int x, int y, const char* text, int textLength)
{
  // guardians
  if (x > 40 || y > 78) {
    // absolute guardian
    return -1;
  }

  int actualY = y;
  int actualX = x;
  bool writeError = false;
  for (int i = 0; i < textLength; i++) {
    char character = text[i];
    actualY++;
    // write dash
    if (actualY > 72) {
      printChar(actualX, actualY, '-');
      actualX += 10;
      actualY = y;
    }

    int result = printChar(actualX, actualY, character);
    if (!result) {
      // the character would be out of the display x bounds
      writeError = true;
      break;
    }
  }

  if (writeError) {
    resetBuffer();
    printString(3, 20, "Too long text", 13);
  }

  return 0;
}

/**
 * Prints an image with given parameters.
 *
 * @param int x
 * @param int y
 * @param int rows
 * @param int cols
 * @param const int* pixels
 */
void printImage(int x, int y, int rows, int cols, const int* pixels)
{
  int currentX = x;
  int currentY = y;
  int maxIndex = rows * cols;

  for (int i = 0; i < maxIndex; i++) {
    if (currentY == cols) {
      currentX++;
      currentY = y;
    }

    int pixel = pixels[i];
    setPixel(currentX, currentY, pixel);
    currentY++;
  }
}

/**
 * Reads the contents of a text file into a string.
 *
 * Returns an empty string on failure.
 *
 * @param File file
 */
const char* readString(File file)
{
  if (file) {
    unsigned long fileSize = file.size();
    char result[fileSize];
    int i = 0;
    while (file.available()) {
      char c = file.read();
      if (c != '\n') {
        result[i] = c;
        i++;
      }
      else {
        result[i] = '\0';
        break; // allows for multiple calls of the method for iterative reading
      }
    }

    readStringLength = i;

    return result;
  }
  else {
    // something happened
    return "";
  }
}

/**
 * Explodes the string into an integer array.
 *
 * @param const int* input
 * @param int length
 */
const int* explodeString(const char* input, int length)
{
  int result[length] = {};

  // TODO do some magic

  return result;
}

/**
 * Handles the command.
 *
 * @param String command
 */
void handleCommand(String command)
{
  String existCommand = "doesFileExist";
  String showCommand = "showFile";

  // determine command and parameter
  int indexP1 = command.indexOf('(');
  int indexP2 = command.indexOf(')');
  String command2 = command;
  command2.remove(indexP1);

  if (command2 != existCommand && command2 != showCommand) {
    Serial.println("Use doesFileExist(<file>) or showFile(<file>)");
    return;
  }

  command.remove(indexP2);
  String parameter = command.substring(indexP1 + 1);

  if (command2 == existCommand) {
    bool fileExists = SD.exists(parameter);
    Serial.print("Does file exist? ");
    Serial.println(fileExists ? "Yes" : "No");
  }

  if (command2 == showCommand) {
    showFile(parameter);
  }
}

/**
 * Shows the given file.
 *
 * @param String fileName
 */
void showFile(String fileName)
{
  bool isTextFile = false;
  int extPos = fileName.indexOf('.');
  String ext = fileName.substring(extPos + 1);
  isTextFile = (ext == "txt");

  if (SD.exists(fileName)) {
    File file = SD.open(fileName);
    if (isTextFile) {
      const char* text = readString(file);
      printString(0, 0, text, readStringLength);
    }
    else {
      const char* dimensions = readString(file);
      int dimensionsLength = readStringLength;
      const char* pixels = readString(file);
      int pixelsLength = readStringLength;

      // parse dimensions and pixels
      // TODO is there some kind of explode? - that is exactly what we need
      const int* dimensionsInt = explodeString(dimensions, dimensionsLength);
      const int* pixelsInt = explodeString(pixels, pixelsLength);
      // calculate x and y start positions
      int rows = dimensionsInt[0];
      int cols = dimensionsInt[1];
      int x = (48 - rows) / 2;
      int y = (84 - cols) / 2;

      printImage(x, y, rows, cols, pixelsInt);
    }

    // TODO Closing the file?
  }
}
