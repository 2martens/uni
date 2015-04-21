int ledPin = 7;
int buttonPlusPin = 5;
int buttonMinusPin = 3;
int volatile counter = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPlusPin, INPUT);
  pinMode(buttonMinusPin, INPUT);
  attachInterrupt(buttonPlusPin, increment, LOW);
  attachInterrupt(buttonMinusPin, decrement, LOW);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
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

void increment() {
  counter += 1;
  delayMicroseconds(50000);
}

void decrement() {
  counter -= 1;
  delayMicroseconds(50000);
}


