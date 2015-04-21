int ledPin = 7;
int buttonPin = 5;
int counter = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  counter += 1;
  if (counter % 256 == 0) {
    counter = 0;
  }
  analogWrite(ledPin, counter);
  Serial.print("LED: ");
  Serial.println(counter);
  delay(50);
}
