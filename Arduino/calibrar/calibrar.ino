/*
* Calibracion modulo PH
*/

int entrada_A0;
float voltaje;
 
void setup()  {
  Serial.begin(9600);
}
 
void loop() {
  entrada_A0 = analogRead(A0);
  voltaje = entrada_A0 * (5.0/1023.0);
  Serial.println(voltaje);
  delay(500);
}