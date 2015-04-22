// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pin for the LED
int ledPin = 7;
// hardware pin for button 1
int buttonOnePin = 5;
// hardware pin for button 2
int buttonTwoPin = 3;

// used to achieve a 1kHz frequency
// don't touch them
int compareValue = 60;
int rc = 10499;

// this variables are affected by the buttonOne and buttonTwo actions
// represents the motor state, can be 0 (clockwise rotation), 1 (anti-clockwise rotation) or 2 (motor stopped)
int volatile motorState = 0;
// represents the power of the motor (range from 0 to 100)
int volatile motorPower = 0;
bool volatile motorPowerMaxReached = false;

// these values are used by the TC0_Handler
// do not use them at all
int timesPressedOne = 0;
int timesPressedTwo = 0;
bool buttonOneActionPerformed = false;
bool buttonTwoActionPerformed = false;

/**
 * Setup function for initial setup code
 */
void setup() {
  pmc_set_writeprotect(false);
  pmc_enable_periph_clk(ID_TC0);

  // configure hardware timer
  TC_Configure(TC0, 0, TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC | TC_CMR_TCCLKS_TIMER_CLOCK2) ;
  TC_SetRC(TC0, 0, rc);

  TC0->TC_CHANNEL[0].TC_IER=TC_IER_CPCS;   // IER = interrupt enable register
  TC0->TC_CHANNEL[0].TC_IDR=~TC_IER_CPCS;

  NVIC_ClearPendingIRQ(TC0_IRQn);
  NVIC_EnableIRQ(TC0_IRQn);

  // start hardware timer
  TC_Start(TC0, 0);

  // Configure button pins for input mode
  pinMode(buttonOnePin, INPUT);
  pinMode(buttonTwoPin, INPUT);

  // initialize serial port
  Serial.begin(9600);
}

/**
 * Loop function for main code
 */
void loop() {
  // write the current counter to the LED pin
  analogWrite(ledPin, counter);
  // print the current LED value in the serial for debugging purposes
  Serial.print("LED: ");
  Serial.println(counter);
}

/**
 * Performs the action for button one.
 *
 * Has to be changed for the specific use case.
 */
void buttonOneAction() {
  if (motorState < 2) {
    motorState += 1;
  }
  else {
    motorState = 0;
  }
}

/**
 * Performs the action for button two.
 *
 * Has to be changed for the specific use case.
 */
void buttonTwoAction() {
  if (!motorPowerMaxReached && motorPower < 100) {
    motorPower += 1;
  }
  if (motorPowerMaxReached && motorPower > 0) {
    motorPower -= 1;
  }
  if (motorPowerMaxReached && motorPower == 0) {
    motorPowerMaxReached = false;
  }
  if (!motorPowerMaxReached && motorPower == 100) {
    motorPowerMaxReached = true;
  }
}

/**
 * Used to increase/decrease a counter when the corresponding button is pressed.
 */
void TC0_Handler()
{
  // request static for some magic behind the curtain
  TC_GetStatus(TC0, 0);
  // variables used to determine if the corresponding button is pressed
  bool buttonPressedOne = (digitalRead(buttonOnePin) == LOW);
  bool buttonPressedTwo = (digitalRead(buttonTwoPin) == LOW);

  // handles the plus button
  if (buttonPressedOne){
    timesPressedOne += 1;
  }
  else {
    if (buttonOneActionPerformed) {
      buttonOneActionPerformed = false;
    }
    timesPressedOne = 0 ;
  }

  // handles the minus button
  if (buttonPressedTwo){
    timesPressedTwo += 1;
  }
  else {
    if (buttonTwoActionPerformed) {
      buttonTwoActionPerformed = false;
    }
    timesPressedTwo = 0 ;
  }

  // performs button one action if button has been pressed long enough
  if (timesPressedOne >= compareValue) {
    if (!buttonOneActionPerformed) {
      buttonOneAction();
    }
    buttonOneActionPerformed = true;
    timesPressedOne = 0;
  }

  // performs button two action if button has been pressed long enough
  if (timesPressedTwo >= compareValue) {
    if (!buttonTwoActionPerformed) {
      buttonTwoAction();
    }
    buttonTwoActionPerformed = true;
    timesPressedTwo = 0;
  }
}
