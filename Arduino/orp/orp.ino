#define VOLTAGE 5.00          // Voltaje del sistema
#define OFFSET 0              // Voltaje de compensación (calibración)
const int analogInPin = A1;   // Pin de entrada analógica para la lectura del sensor ORP
const int ArrayLength = 10;   // Tamaño del array para almacenar las lecturas

int buf[ArrayLength];         // Array para almacenar las lecturas del sensor
float orpValue;               // Valor del ORP
int temp;

void setup() {
  Serial.begin(9600);         // Inicialización de la comunicación serial a 9600 baudios
  pinMode(LED_BUILTIN, OUTPUT); // Configura el pin del LED integrado como salida
}

void loop() {
  // Realizar 10 lecturas del sensor ORP
  for (int i = 0; i < ArrayLength; i++) {
    buf[i] = analogRead(analogInPin);  // Leer el valor del sensor
    delay(30);                         // Pausa para estabilizar la lectura
  }

  // Ordenar los valores del buffer de menor a mayor
  for (int i = 0; i < ArrayLength - 1; i++) {
    for (int j = i + 1; j < ArrayLength; j++) {
      if (buf[i] > buf[j]) {
        temp = buf[i];
        buf[i] = buf[j];
        buf[j] = temp;
      }
    }
  }

  // Calcular el valor promedio del buffer, excluyendo los valores extremos
  long avgValue = 0;
  for (int i = 2; i < 8; i++) {
    avgValue += buf[i];
  }
  avgValue /= 6; // Promediar los valores centrales (excluye los dos valores más bajos y los dos más altos)

  // Convertir el valor promedio a mV del sensor ORP
  orpValue = ((30.0 * VOLTAGE * 1000) - (75.0 * avgValue * VOLTAGE * 1000 / 1024.0)) / 75.0 - OFFSET;

  // Imprimir el valor de ORP en la consola serial
  Serial.print("ORP: ");
  Serial.print(orpValue);
  Serial.println(" mV");

  // Indicar mediante el LED que se ha realizado una lectura
  digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN)); // Cambiar el estado del LED
  delay(500); // Pequeña pausa antes de la próxima lectura
}
