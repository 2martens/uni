int ledPin = 7;
int buttonPlusPin = 5;
int buttonMinusPin = 3;
int counter = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPlusPin, INPUT);
  pinMode(buttonMinusPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (digitalRead(buttonPlusPin) == LOW) {
    counter += 1;
  }
  
  if (digitalRead(buttonMinusPin) == LOW) {
    counter -= 1;
  }
  
  if (counter > 255) {
    counter = 255;
  }
  if (counter < 0) {
    counter = 0;
  }
  
  analogWrite(ledPin, counter);
  Serial.print("LED: ");
  Serial.println(counter);
  delay(50);
}
