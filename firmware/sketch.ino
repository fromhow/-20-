const unsigned long T_MS = 5000;

const int PIN_S1 = A1;    
const int PIN_S2 = A2;    
const int PIN_S3 = 2;     
const int PIN_RELAY = 5;  
const int PIN_LED = 3;    

const float THRESHOLD = 20.0;


const int RELAY_ON = LOW;
const int RELAY_OFF = HIGH;

unsigned long n = 0;
bool alarm = false;

void setup() {
  Serial.begin(9600);

  pinMode(PIN_S1, INPUT);
  pinMode(PIN_S2, INPUT);
  pinMode(PIN_S3, INPUT);


  digitalWrite(PIN_RELAY, RELAY_OFF);
  pinMode(PIN_RELAY, OUTPUT);

  digitalWrite(PIN_LED, LOW);
  pinMode(PIN_LED, OUTPUT);
}

void loop() {
  n++;


  float s1 = 100.0 * analogRead(PIN_S1) / 1023.0;


  float s2 = 5.0 * analogRead(PIN_S2) / 1023.0;


  int s3 = digitalRead(PIN_S3);


  Serial.print("DATA n=");
  Serial.print(n);
  Serial.print(" s1=");
  Serial.print(s1, 2);
  Serial.print(" s2=");
  Serial.print(s2, 2);
  Serial.print(" s3=");
  Serial.println(s3);

  bool condition = s1 > THRESHOLD;

  if (condition && !alarm) {
    alarm = true;

    digitalWrite(PIN_RELAY, RELAY_ON);
    digitalWrite(PIN_LED, HIGH);

    Serial.print("EVENT n=");
    Serial.print(n);
    Serial.println(" type=THRESHOLD");
  } else if (!condition && alarm) {
    alarm = false;

    digitalWrite(PIN_RELAY, RELAY_OFF);
    digitalWrite(PIN_LED, LOW);

    Serial.print("EVENT n=");
    Serial.print(n);
    Serial.println(" type=NORMAL");
  }

  delay(T_MS);
}