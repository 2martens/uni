// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pin for the LED
int ledPin = 7;
// hardware pin for the plus button
int buttonPlusPin = 5;
// hardware pin for the minus button
int buttonMinusPin = 3;

// used to achieve a 1kHz frequency
// don't touch them
int compareValue = 60;
int rc = 10499;

// these values are used by the TC0_Handler
// do not write into them within the loop/setup
// only the counter should be used within the loop
int volatile counter = 0;
int timesPressedPlus = 0;
int timesPressedMinus = 0;
bool increased = false;
bool decreased = false;

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
  pinMode(buttonPlusPin, INPUT);
  pinMode(buttonMinusPin, INPUT);

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
 * Increases the counter by 1.
 *
 * The highest possible value of the counter is 255.
 */
void increment() {
  if (counter < 255) {
    counter += 1;
  }
}

/**
 * Decreases the counter by 1.
 *
 * The lowest possible value of the counter is 0.
 */
void decrement() {
  if (counter > 0)  {
    counter -= 1;
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
  bool buttonPressedPlus = (digitalRead(buttonPlusPin) == LOW);
  bool buttonPressedMinus = (digitalRead(buttonMinusPin) == LOW);

  // handles the plus button
  if (buttonPressedPlus){
    ++timesPressedPlus;
  }
  else {
    if (increased) {
      increased = false;
    }
    timesPressedPlus = 0 ;
  }

  // handles the minus button
  if (buttonPressedMinus){
    ++timesPressedMinus;
  }
  else {
    if (decreased) {
      decreased = false;
    }
    timesPressedMinus = 0 ;
  }

  // increases counter if button has been pressed long enough
  if (timesPressedPlus >= compareValue) {
    if (!increased) {
      increment();
    }
    increased = true;
    timesPressedPlus = 0;
  }

  // decreases counter if button has been pressed long enough
  if (timesPressedMinus >= compareValue) {
    if (!decreased) {
      decrement();
    }
    decreased = true;
    timesPressedMinus = 0;
  }
}
