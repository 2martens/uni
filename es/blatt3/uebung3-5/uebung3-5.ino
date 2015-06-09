#include <Servo.h>

// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins
int az = 50;

int xout = A4;
int zout = A2;
int vref = A3;
int ledPin = 13;

// servo
Servo ourServo;
int servoPin = 11;

// used to achieve a 10 Hz frequency
// don't touch them
long rc = 1049999;

// flags for servo
bool volatile cwMaxReached = false;
bool volatile ccwMaxReached = false;
bool volatile lightLED = false;

bool volatile read_ready = false;


/**
 * Validates the servo position.
 *
 * @param int newServoPos
 */
int validate_new_servo_pos(int newServoPos) {
    if (newServoPos > 159) {
        newServoPos = 159;
        cwMaxReached = true;
        lightLED = true;
        Serial.println("Interval 25-159");
    }

    if (newServoPos < 25) {
        newServoPos = 25;
        ccwMaxReached = true;
        lightLED = true;
        Serial.println("Interval 25-159");
    }

    return newServoPos;
}

int parse_angle(String command) {
  int indexP1 = command.indexOf('(');
  int indexP2 = command.indexOf(')');
  String command2 = command;
  command2.remove(indexP1);
  if (command2 != "moveTo") {
    Serial.println("Use moveTo(<angle>)");
    return ourServo.read();
  }
  
  command.remove(indexP2);
  int angle = command.substring(indexP1 + 1).toInt();

  return angle;
}
  

/**
 * Setup function for initial setup code
 */
void setup() {
    pmc_set_writeprotect(false);
    pmc_enable_periph_clk(ID_TC1);

    // configure hardware timer
    TC_Configure(TC0, 1, TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC | TC_CMR_TCCLKS_TIMER_CLOCK2) ;
    TC_SetRC(TC0, 1, rc);

    TC0->TC_CHANNEL[1].TC_IER=TC_IER_CPCS;   // IER = interrupt enable register
    TC0->TC_CHANNEL[1].TC_IDR=~TC_IER_CPCS;

    NVIC_ClearPendingIRQ(TC1_IRQn);
    NVIC_EnableIRQ(TC1_IRQn);

    // start hardware timer
    //TC_Start(TC0, 1);

    // Configure pins
    pinMode(ledPin, OUTPUT);
    pinMode(az, OUTPUT);
    digitalWrite(az, HIGH);
    digitalWrite(ledPin, LOW);
    
    ourServo.attach(servoPin);
    ourServo.write(90);

    // initialize serial port
    Serial.begin(9600);
}

/**
 * Loop function for main code
 */
void loop() {
    if (Serial.available() > 0) {
      String command;
      char currentChar;
      int i = 0;
      bool readable = true;
      command = Serial.readString();
      
      int servoPos = parse_angle(command);
      int validatedServoPos = validate_new_servo_pos(servoPos);
      
      Serial.print("move to angle ");
      Serial.println(validatedServoPos);
      
      ourServo.write(validatedServoPos);
      
      if (lightLED) {
        lightLED = false;
        digitalWrite(ledPin, HIGH);
        delay(500);
        digitalWrite(ledPin, LOW);
      }
    }
}

/**
 * Used to handle the timer.
 */
void TC1_Handler()
{
    // request static for some magic behind the curtain
    TC_GetStatus(TC0, 1);
    read_ready = true;
}
