int ledPin = 7;
int buttonPlusPin = 5;
int buttonMinusPin = 3;
int volatile counter = 0;
int timesPressedPlus = 0;
int timesPressedMinus = 0;
int vergleichswert = 60;
int rc = 10499;
bool increased = false;
bool decreased = false;

void setup() {
  // put your setup code here, to run once:

  pmc_set_writeprotect(false);
  pmc_enable_periph_clk(ID_TC0);

  // Hier erfolgt die Konfiguration des Timers
  TC_Configure(TC0, 0, TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC | TC_CMR_TCCLKS_TIMER_CLOCK2) ;
  TC_SetRC(TC0, 0, rc);

  TC0->TC_CHANNEL[0].TC_IER=TC_IER_CPCS;   // IER = interrupt enable register
  TC0->TC_CHANNEL[0].TC_IDR=~TC_IER_CPCS;

  NVIC_ClearPendingIRQ(TC0_IRQn);
  NVIC_EnableIRQ(TC0_IRQn);

  // Hier wird der konfigurierte Timer gestartet
  TC_Start(TC0, 0);

  // Hier werden die Taster konfiguriert
  pinMode(buttonPlusPin, INPUT);
  pinMode(buttonMinusPin, INPUT);

  // Ausgabe über den seriellen Port
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  // Hier wird die Plus Taste abgefragt
  analogWrite(ledPin, counter);
  Serial.print("LED: ");
  Serial.println(counter);
}

void increment() {
  if (counter < 255) {
    counter += 1;
  }
}

void decrement() {
  if (counter > 0)  {
    counter -= 1;
  }

}

void TC0_Handler()
{
  TC_GetStatus(TC0, 0);
  bool tasteGedruecktPlus = (digitalRead(buttonPlusPin) == LOW);
  bool tasteGedruecktMinus = (digitalRead(buttonMinusPin) == LOW);

  if (tasteGedruecktPlus){
    ++timesPressedPlus;
  }
  else {
    if (increased) {
      increased = false;
    }
    timesPressedPlus = 0 ;
  }

  if (tasteGedruecktMinus){
    ++timesPressedMinus;
  }
  else {
    if (decreased) {
      decreased = false;
    }
    timesPressedMinus = 0 ;
  }

  if (timesPressedPlus >= vergleichswert) {
    if (!increased) {
      increment();
    }
    increased = true;
    timesPressedPlus = 0;
  }

  // Hier wird die Minus Taste abgefragt
  if (timesPressedMinus >= vergleichswert) {
    if (!decreased) {
      decrement();
    }
    decreased = true;
    timesPressedMinus = 0;
  }
}
