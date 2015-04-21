int ledPin = 7;
int buttonPin = 5;
int buttonState;
bool volatile ledState = true;
bool volatile performDelay = false;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT);
  attachInterrupt(buttonPin, buttonChanged, RISING);
  digitalWrite(ledPin, LOW);
}

void loop() {
  // put your main code here, to run repeatedly:
  buttonState = digitalRead(buttonPin);
  if (performDelay) {
    detachInterrupt(buttonPin);
    delay(20);
    performDelay = false;
    attachInterrupt(buttonPin, buttonChanged, RISING);
  
    if (buttonState == HIGH) {
      if (ledState) {
        digitalWrite(ledPin, LOW);
      } else {
        digitalWrite(ledPin, HIGH);
      }
      ledState = !ledState;
    } 
  }
}

void buttonChanged()  {
  performDelay = true;
}
