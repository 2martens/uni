int ledPin = 7;
int buttonPin = 5;
bool ledState = false;
bool buttonHasBeenReset = true;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT);
  digitalWrite(ledPin, LOW);
}

void loop() {
  // put your main code here, to run repeatedly:
  int buttonState = digitalRead(buttonPin);
  if (buttonState == LOW && buttonHasBeenReset) {
    if (!ledState) {
      ledState = true;
      digitalWrite(ledPin, HIGH);
    }
    else {
      digitalWrite(ledPin, LOW);
      ledState = false;
    }
    buttonHasBeenReset = false;
  }
  else if (buttonState == HIGH) {
    buttonHasBeenReset = true;
  }
  delay(10);
}
