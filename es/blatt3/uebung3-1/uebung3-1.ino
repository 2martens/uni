// these variables describe the used hardware pins
// adjust them when you use other pins
// hardware pins
int az = 50;

int xout = A1;
int zout = A3;
int vref = A0;

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
  TC_Configure(TC0, 0, TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC | TC_CMR_TCCLKS_TIMER_CLOCK2) ;
  TC_SetRC(TC0, 0, rc);

  TC0->TC_CHANNEL[0].TC_IER=TC_IER_CPCS;   // IER = interrupt enable register
  TC0->TC_CHANNEL[0].TC_IDR=~TC_IER_CPCS;

  NVIC_ClearPendingIRQ(TC0_IRQn);
  NVIC_EnableIRQ(TC0_IRQn);

  // start hardware timer
  TC_Start(TC0, 0);

  // Configure axis pins for input mode
  
  pinMode(az, OUTPUT);
  digitalWrite(az, HIGH);
  
  // initialize serial port
  Serial.begin(9600);
  delay(100);
}

/**
 * Loop function for main code
 */
void loop() {
  if (read_ready) {
    int xAxis = analogRead(xout);
    int zAxis = analogRead(zout);
    int ref = analogRead(vref);   
  
    double differenceXRef = xAxis - ref;
    double differenceZRef = zAxis - ref;
    
    double drehrateX = differenceXRef / 9.1;
    double drehrateZ = differenceZRef / 9.1;
  
    Serial.print("x:");
    Serial.println(xAxis);
    Serial.print("z: ");
    Serial.println(zAxis);
    Serial.print("ref: ");
    Serial.println(ref);
    Serial.print("x - ref: ");
    Serial.println(differenceXRef);
    Serial.print("z - ref: ");
    Serial.println(differenceZRef);
    Serial.print("Drehrate X: ");
    Serial.println(drehrateX);
    Serial.print("Drehrate Z: ");
    Serial.println(drehrateZ);
    read_ready = false;    
  }
}

/**
 * Used to handle the timer.
 */
void TC0_Handler()
{
  // request static for some magic behind the curtain
  TC_GetStatus(TC0, 0);
  read_ready = true;
}
