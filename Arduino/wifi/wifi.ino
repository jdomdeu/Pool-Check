#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

// Datos de conexión WiFi
const char* ssid = "vodafone5900";
const char* password = "NoRob@r123PorFavor";

// URLs para pH
String url1_pH = "http://192.168.0.20:1026/v2/entities/iot_SensorpH/attrs/acidity";
String url2_pH = "http://192.168.0.20:1026/v2/entities/graph_SensorpH/attrs/acidity";

// URLs para ORP
String url1_ORP = "http://192.168.0.20:1026/v2/entities/iot_SensorORP/attrs/chlorine";
String url2_ORP = "http://192.168.0.20:1026/v2/entities/graph_SensorORP/attrs/chlorine";

// Variables para pH
float calibration_pH = 8.32; // Calibración para el sensor de pH
const int pHAnalogInPin = A0; // Pin de entrada analógica para el sensor de pH
int pHBuf[100], pHTemp;
unsigned long int avgValue_pH;

// Variables para ORP
#define VOLTAGE 5.00           // Voltaje del sistema para ORP
#define OFFSET 0               // Voltaje de compensación (calibración) para ORP
const int orpAnalogInPin = A1; // Pin de entrada analógica para el sensor ORP
int orpBuf[100], orpTemp;
unsigned long int avgValue_ORP;

// Timers
unsigned long lastMillis1 = 0; // Para el envío cada segundo
unsigned long lastMillis2 = 0; // Para el envío cada hora

const long interval1 = 1000; // Intervalo de envío cada segundo
const long interval2 = 3600000; // Intervalo de envío cada hora (3600000 ms)

void setup() {
  Serial.begin(9600); // Inicialización de la comunicación serial
  delay(10);
  Serial.println("\nIniciando...");

  // Conectar WiFi
  Serial.print("Conectando a WiFi");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi conectado");
}

void loop() {
  unsigned long currentMillis = millis(); // Obtener el tiempo actual

  // --- Lectura y cálculo del valor de pH ---
  int totalSamples = 100;
  for (int i = 0; i < totalSamples; i++) {
    pHBuf[i % 100] = analogRead(pHAnalogInPin);
    delay(10); // Pausa para estabilizar la lectura
  }

  // Ordenar los valores de pH
  for (int i = 0; i < totalSamples - 1; i++) {
    for (int j = i + 1; j < totalSamples; j++) {
      if (pHBuf[i] > pHBuf[j]) {
        pHTemp = pHBuf[i];
        pHBuf[i] = pHBuf[j];
        pHBuf[j] = pHTemp;
      }
    }
  }

  // Calcular el valor promedio de pH excluyendo extremos
  avgValue_pH = 0;
  for (int i = 10; i < 90; i++) 
    avgValue_pH += pHBuf[i];

  float pHVol = (float)avgValue_pH * 3.3 / 1024 / 80;
  float phValue = -5.70 * pHVol + calibration_pH;

  // --- Lectura y cálculo del valor de ORP ---
  for (int i = 0; i < totalSamples; i++) {
    orpBuf[i % 100] = analogRead(orpAnalogInPin);
    delay(10); // Pausa para estabilizar la lectura
  }

  // Ordenar los valores de ORP
  for (int i = 0; i < totalSamples - 1; i++) {
    for (int j = i + 1; j < totalSamples; j++) {
      if (orpBuf[i] > orpBuf[j]) {
        orpTemp = orpBuf[i];
        orpBuf[i] = orpBuf[j];
        orpBuf[j] = orpTemp;
      }
    }
  }

  // Calcular el valor promedio de ORP excluyendo extremos
  avgValue_ORP = 0;
  for (int i = 10; i < 90; i++) 
    avgValue_ORP += orpBuf[i];

  float orpValue = ((30.0 * VOLTAGE * 1000) - (75.0 * avgValue_ORP * VOLTAGE * 1000 / 1024.0)) / 75.0 - OFFSET;

  // --- Enviar datos cada segundo ---
  if (currentMillis - lastMillis1 >= interval1) {
    lastMillis1 = currentMillis;

    if (WiFi.status() == WL_CONNECTED) {
      HTTPClient http;
      WiFiClient client;

      // Enviar pH a la primera URL
      http.begin(client, url1_pH);
      http.addHeader("Content-Type", "application/json");
      http.addHeader("Fiware-Service", "tutorial");
      http.addHeader("Fiware-Servicepath", "/");
      String payload_pH = "{\"value\": " + String(phValue) + ", \"type\": \"Float\"}";
      int httpResponseCode_pH = http.PUT(payload_pH);
      if (httpResponseCode_pH > 0) {
        String response = http.getString();
        Serial.printf("[HTTP] PUT pH to url1... code: %d\n", httpResponseCode_pH);
        Serial.println(response);
      } else {
        Serial.printf("[HTTP] PUT pH to url1... failed, error: %s\n", http.errorToString(httpResponseCode_pH).c_str());
      }
      http.end();

      // Enviar ORP a la primera URL
      http.begin(client, url1_ORP);
      http.addHeader("Content-Type", "application/json");
      http.addHeader("Fiware-Service", "tutorial");
      http.addHeader("Fiware-Servicepath", "/");
      String payload_ORP = "{\"value\": " + String(orpValue) + ", \"type\": \"Float\"}";
      int httpResponseCode_ORP = http.PUT(payload_ORP);
      if (httpResponseCode_ORP > 0) {
        String response = http.getString();
        Serial.printf("[HTTP] PUT ORP to url1... code: %d\n", httpResponseCode_ORP);
        Serial.println(response);
      } else {
        Serial.printf("[HTTP] PUT ORP to url1... failed, error: %s\n", http.errorToString(httpResponseCode_ORP).c_str());
      }
      http.end();
    } else {
      Serial.println("WiFi no está conectado");
    }
  }

  // --- Enviar datos cada hora ---
  if (currentMillis - lastMillis2 >= interval2) {
    lastMillis2 = currentMillis;

    if (WiFi.status() == WL_CONNECTED) {
      HTTPClient http;
      WiFiClient client;

      // Enviar pH a la segunda URL
      http.begin(client, url2_pH);
      http.addHeader("Content-Type", "application/json");
      http.addHeader("Fiware-Service", "tutorial");
      http.addHeader("Fiware-Servicepath", "/");
      String payload_pH = "{\"value\": " + String(phValue) + ", \"type\": \"Float\"}";
      int httpResponseCode_pH = http.PUT(payload_pH);
      if (httpResponseCode_pH > 0) {
        String response = http.getString();
        Serial.printf("[HTTP] PUT pH to url2... code: %d\n", httpResponseCode_pH);
        Serial.println(response);
      } else {
        Serial.printf("[HTTP] PUT pH to url2... failed, error: %s\n", http.errorToString(httpResponseCode_pH).c_str());
      }
      http.end();

      // Enviar ORP a la segunda URL
      http.begin(client, url2_ORP);
      http.addHeader("Content-Type", "application/json");
      http.addHeader("Fiware-Service", "tutorial");
      http.addHeader("Fiware-Servicepath", "/");
      String payload_ORP = "{\"value\": " + String(orpValue) + ", \"type\": \"Float\"}";
      int httpResponseCode_ORP = http.PUT(payload_ORP);
      if (httpResponseCode_ORP > 0) {
        String response = http.getString();
        Serial.printf("[HTTP] PUT ORP to url2... code: %d\n", httpResponseCode_ORP);
        Serial.println(response);
      } else {
        Serial.printf("[HTTP] PUT ORP to url2... failed, error: %s\n", http.errorToString(httpResponseCode_ORP).c_str());
      }
      http.end();
    } else {
      Serial.println("WiFi no está conectado");
    }
  }
}