#include <Servo.h>

// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins
int az = 50;

int xout = A1;
int zout = A3;
int vref = A0;

// servo
int servoPin = 11;
Servo ourServo;

// used to achieve a 10 Hz frequency
// don't touch them
int rc = 1049999;

bool volatile read_ready = false;

/**
 * Setup function for initial setup code
 */
void setup() {
  pmc_set_writeprotect(false);
  pmc_enable_periph_clk(ID_TC0);

  // configure hardware timer
  TC_Configure(TC1, 0, TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC | TC_CMR_TCCLKS_TIMER_CLOCK2) ;
  TC_SetRC(TC1, 0, rc);

  TC1->TC_CHANNEL[0].TC_IER=TC_IER_CPCS;   // IER = interrupt enable register
  TC1->TC_CHANNEL[0].TC_IDR=~TC_IER_CPCS;

  NVIC_ClearPendingIRQ(TC1_IRQn);
  NVIC_EnableIRQ(TC1_IRQn);

  // start hardware timer
  //TC_Start(TC0, 0);

  // Configure servo
  ourServo.attach(servoPin);
  ourServo.write(90);
  
  pinMode(az, OUTPUT);
  pinMode(servoPin, OUTPUT);
  
  digitalWrite(az, HIGH);
  
  // initialize serial port
  Serial.begin(9600);
}

/**
 * Loop function for main code
 */
void loop() {
  for (int i = 0; i < 90; i++) {
    ourServo.write(90 + i);
    delay(10);
  }
  Serial.println(ourServo.read());
}

/**
 * Used to handle the timer.
 */
void TC1_Handler()
{
  // request static for some magic behind the curtain
  TC_GetStatus(TC1, 0);
}
