// Declaración de variables
float calibration = 21.34 + 3.25; // Valor de calibración, se puede ajustar según sea necesario
const int analogInPin = A0; // Pin de entrada analógica para la lectura del sensor
int sensorValue = 0; // Variable para almacenar el valor del sensor
unsigned long int avgValue; // Variable para almacenar el valor promedio
float b;
int buf[10], temp;

void setup() {
  // Inicialización de la comunicación serial a 9600 baudios
  Serial.begin(9600);
}

void loop() {
  // Bucle para realizar 10 lecturas del sensor
  for(int i = 0; i < 10; i++) {
    // Almacenar cada lectura en el buffer
    buf[i] = analogRead(analogInPin);
    // Pequeña pausa para estabilizar la lectura
    delay(30);
  }

  // Ordenar los valores del buffer de menor a mayor
  for(int i = 0; i < 9; i++) {
    for(int j = i + 1; j < 10; j++) {
      if(buf[i] > buf[j]) {
        temp = buf[i];
        buf[i] = buf[j];
        buf[j] = temp;
      }
    }
  }

  // Calcular el valor promedio de los valores del buffer excluyendo los extremos
  avgValue = 0;
  for(int i = 2; i < 8; i++)
    avgValue += buf[i];

  // Convertir el valor promedio a voltaje del sensor (0-5V)
  float pHVol = (float)avgValue * 5.0 / 1024 / 6;

  // Calcular el valor de pH utilizando una fórmula de conversión
  float phValue = -5.70 * pHVol + calibration;

  // Imprimir el valor de pH en la consola serial
  Serial.print("sensor = ");
  Serial.println(phValue);

  // Pequeña pausa antes de la próxima lectura
  delay(500);
}
