#include <Servo>

// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins
int az = 50;

int xout = A1;
int zout = A3;
int vref = A0;
int ledPin = 13;

// servo
Servo ourServo;
int servoPin = 11;

// used to achieve a 10 Hz frequency
// don't touch them
long rc = 1049999;

// flags for servo
bool cwMaxReached = false;
bool ccwMaxReached = false;
bool lightLED = false;

bool volatile read_ready = false;

/**
 * Calculates the servo position.
 *
 * @param int currentServoPos
 * @param int rotationX
 */
int calculate_new_servo_pos(int currentServoPos, int rotationX) {
    int newServoPos = currentServoPos;

    if (!cwMaxReached && !ccwMaxReached) {
        // clockwise rotation from 90 to 180
        newServoPos = currentServoPos + rotationX;
    }
    else if (cwMaxReached && !ccwMaxReached) {
        // counter clockwise rotation from 180 to 0
        newServoPos = currentServoPos - rotationX;
    }
    else if (cwMaxReached && ccwMaxReached) {
        // clockwise rotation from 0 to 90
        newServoPos = currentServoPos + rotationX;
        if (newServoPos >= 90) {
            cwMaxReached = false;
            ccwMaxReached = false;
        }
    }

    if (newServoPos > 180) {
        newServoPos = 180;
        cwMaxReached = true;
        lightLED = true;
    }

    if (newServoPos < 0) {
        newServoPos = 0;
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
    TC_Configure(TC1, 0, TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC | TC_CMR_TCCLKS_TIMER_CLOCK2) ;
    TC_SetRC(TC1, 0, rc);

    TC1->TC_CHANNEL[0].TC_IER=TC_IER_CPCS;   // IER = interrupt enable register
    TC1->TC_CHANNEL[0].TC_IDR=~TC_IER_CPCS;

    NVIC_ClearPendingIRQ(TC1_IRQn);
    NVIC_EnableIRQ(TC1_IRQn);

    // start hardware timer
    TC_Start(TC1, 0);

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
        int xAxis = analogRead(xout);
        int ref = analogRead(vref);

        double differenceXRef = xAxis - ref;
        double rotationX = differenceXRef / 9.1;

        int currentServoPos = ourServo.read();
        int newServoPos = calculate_new_servo_pos(currentServoPos, rotationX);

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
        ourServo.write(newServoPos);
        read_ready = false;
    }
}

/**
 * Used to handle the timer.
 */
void TC1_Handler()
{
    // request static for some magic behind the curtain
    TC_GetStatus(TC1, 0);
    read_ready = true;
}
