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
 * Calculates the servo position.
 *
 * @param int currentServoPos
 * @param int rotationZ
 */
int calculate_new_servo_pos(int currentServoPos, int rotationZ) {
    int newServoPos = currentServoPos + rotationZ;

    if (newServoPos > 159) {
        newServoPos = 159;
        cwMaxReached = true;
        lightLED = true;
    }

    if (newServoPos < 25) {
        newServoPos = 25;
        ccwMaxReached = true;
        lightLED = true;
    }

    return newServoPos;
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
    TC_Start(TC0, 1);

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
    if (read_ready) {
        int zAxis = analogRead(zout);
        int ref = analogRead(vref);

        double differenceZRef = zAxis - ref;
        double rotationZ = differenceZRef / 9.1;
        
        Serial.print("rotationZ: ");
        Serial.println(rotationZ);

        int currentServoPos = ourServo.read();
        int newServoPos = calculate_new_servo_pos(currentServoPos, rotationZ);
        
        Serial.print("currentServoPos: ");
        Serial.println(currentServoPos);
        
        Serial.print("newServoPos: ");
        Serial.println(newServoPos);
        
        if (lightLED) {
            digitalWrite(ledPin, HIGH);
            delay(10);
            digitalWrite(ledPin, LOW);
            delay(10);
            digitalWrite(ledPin, HIGH);
            delay(10);
            digitalWrite(ledPin, LOW);
            delay(10);
            digitalWrite(ledPin, HIGH);
            delay(10);
            digitalWrite(ledPin, LOW);
            lightLED = false;
        }
        ourServo.write(newServoPos + 1);
        read_ready = false;
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
