#include <Servo.h>

// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins
int az = 50;

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
 * Validates the new servo position.
 *
 * @param long newServoPos
 */
int validate_new_servo_pos(long newServoPos) {

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

    int validatedServoPos = (int) newServoPos;

    return validatedServoPos;
}

/**
 * Parses the angle of the moveTo command.
 *
 * @param char command
 */
long parse_angle(char* command) {
    char* angle;

    angle = strtok(command, "()");
    angle = strtok(NULL, "()");

    return strtol(angle, NULL, 10);
}

/**
 * Setup function for initial setup code
 */
void setup() {
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
        char command[8];
        char currentChar;
        int i = 0;
        bool readable = true;
        while (readable) {
            currentChar = Serial.read();
            readable = (currentChar != -1);
            command[i] = currentChar;
            i++;
        }
        command[i] = '\0';

        long servoPos = parse_angle(command);
        int validatedServoPos = validate_new_servo_pos(servoPos);

        ourServo.write(validatedServoPos);

        if (lightLED) {
            lightLED = false;
            digitalWrite(ledPin, HIGH);
            delay(500);
            digitalWrite(ledPin, LOW);
        }
    }
}
