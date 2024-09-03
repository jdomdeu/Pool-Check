#include <SoftwareSerial.h>

// Definir los pines de SoftwareSerial
SoftwareSerial BTSerial(10, 11); // TX, RX

// Declaración de variables para pH
const float calibration = 21.34 + 3.28; // Valor de calibración, se puede ajustar según sea necesario
const int pHAnalogInPin = A0; // Pin de entrada analógica para la lectura del sensor de pH
const int pHArrayLength = 10; // Tamaño del array para almacenar las lecturas de pH
int pHBuf[pHArrayLength];
float pHValue;
int pHTemp;

// Declaración de variables para ORP
#define VOLTAGE 5.00           // Voltaje del sistema
#define OFFSET 0               // Voltaje de compensación (calibración)
const int orpAnalogInPin = A1; // Pin de entrada analógica para la lectura del sensor ORP
const int orpArrayLength = 10; // Tamaño del array para almacenar las lecturas de ORP
int orpBuf[orpArrayLength];
float orpValue;
int orpTemp;

char myChar;

void setup() {
  delay(60000);
  // Inicialización de la comunicación serial a 9600 baudios
  Serial.begin(9600);
  BTSerial.begin(9600);
  BTSerial.println("Conexión Bluetooth exitosa");

  pinMode(LED_BUILTIN, OUTPUT); // Configura el pin del LED integrado como salida
}

void loop() {
  // --- Medir y calcular el valor de pH ---
  for (int i = 0; i < pHArrayLength; i++) {
    pHBuf[i] = analogRead(pHAnalogInPin);  // Leer el valor del sensor de pH
    delay(30);                             // Pausa para estabilizar la lectura
  }

  // Ordenar los valores del buffer de pH
  for (int i = 0; i < pHArrayLength - 1; i++) {
    for (int j = i + 1; j < pHArrayLength; j++) {
      if (pHBuf[i] > pHBuf[j]) {
        pHTemp = pHBuf[i];
        pHBuf[i] = pHBuf[j];
        pHBuf[j] = pHTemp;
      }
    }
  }

  // Calcular el valor promedio de pH, excluyendo los extremos
  long pHAvgValue = 0;
  for (int i = 2; i < 8; i++) {
    pHAvgValue += pHBuf[i];
  }
  pHAvgValue /= 6;

  // Convertir el valor promedio de pH a voltaje y luego a pH
  float pHVol = (float)pHAvgValue * 5.0 / 1024.0;
  pHValue = -5.70 * pHVol + calibration;

  // Imprimir y enviar el valor de pH
  Serial.print("pH = ");
  Serial.println(pHValue);
  BTSerial.print("pH:");
  BTSerial.println(pHValue);

  // --- Medir y calcular el valor de ORP ---
  for (int i = 0; i < orpArrayLength; i++) {
    orpBuf[i] = analogRead(orpAnalogInPin);  // Leer el valor del sensor ORP
    delay(30);                               // Pausa para estabilizar la lectura
  }

  // Ordenar los valores del buffer de ORP
  for (int i = 0; i < orpArrayLength - 1; i++) {
    for (int j = i + 1; j < orpArrayLength; j++) {
      if (orpBuf[i] > orpBuf[j]) {
        orpTemp = orpBuf[i];
        orpBuf[i] = orpBuf[j];
        orpBuf[j] = orpTemp;
      }
    }
  }

  // Calcular el valor promedio de ORP, excluyendo los extremos
  long orpAvgValue = 0;
  for (int i = 2; i < 8; i++) {
    orpAvgValue += orpBuf[i];
  }
  orpAvgValue /= 6;

  // Convertir el valor promedio de ORP a mV
  orpValue = ((30.0 * VOLTAGE * 1000) - (75.0 * orpAvgValue * VOLTAGE * 1000 / 1024.0)) / 75.0 - OFFSET;

  // Imprimir y enviar el valor de ORP
  Serial.print("ORP = ");
  Serial.print(orpValue);
  Serial.println(" mV");
  BTSerial.print("ORP:");
  BTSerial.println(orpValue);

  // Indicar mediante el LED que se ha realizado una lectura
  digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN)); // Cambiar el estado del LED

  // Pausa antes de la próxima lectura
  delay(500);

  // Comunicación Bluetooth (bidireccional)
  while (BTSerial.available()) {
    myChar = BTSerial.read();
    Serial.print(myChar);
  }

  while (Serial.available()) {
    myChar = Serial.read();
    BTSerial.print(myChar);
  }
}