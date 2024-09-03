#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

// Datos de conexión WiFi
const char* ssid = "vodafone5900";
const char* password = "NoRob@r123PorFavor";

// URLs para pH y ORP (envío cada segundo)
String url_pH = "http://192.168.0.20:1026/v2/entities/iot_SensorpH/attrs/acidity";
String url_ORP = "http://192.168.0.20:1026/v2/entities/iot_SensorORP/attrs/chlorine";

// URLs para pH y ORP (envío cada hora)
String url2_pH = "http://192.168.0.20:1026/v2/entities/graph_SensorpH/attrs/acidity";
String url2_ORP = "http://192.168.0.20:1026/v2/entities/graph_SensorORP/attrs/chlorine";

// Intervalo para envío de datos
const long interval1 = 1000;       // Intervalo de envío cada segundo
const long interval2 = 600000;    // Intervalo de envío cada 10 min
unsigned long lastMillis1 = 0;
unsigned long lastMillis2 = 0;

// Variables para almacenar los valores recibidos
float phValue = 0.0;
float orpValue = 0.0;

void setup() {
  Serial.begin(9600); // Inicialización de la comunicación serial
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi conectado");
}

void loop() {
  unsigned long currentMillis = millis();

  // Comprobar si hay datos disponibles en el puerto serial
  if (Serial.available()) {
    String input = Serial.readStringUntil('\n'); // Leer la línea completa hasta un salto de línea

    // Procesar el valor de pH
    if (input.startsWith("pH:")) {
      phValue = input.substring(3).toFloat(); // Extraer y convertir el valor de pH
    }
    // Procesar el valor de ORP
    else if (input.startsWith("ORP:")) {
      orpValue = input.substring(4).toFloat(); // Extraer y convertir el valor de ORP
    }
  }

  // --- Enviar los datos cada segundo ---
  if (currentMillis - lastMillis1 >= interval1) {
    lastMillis1 = currentMillis;
    enviarDatos(url_pH, phValue, "pH");
    enviarDatos(url_ORP, orpValue, "ORP");
  }

  // --- Enviar los datos cada hora ---
  if (currentMillis - lastMillis2 >= interval2) {
    lastMillis2 = currentMillis;
    enviarDatos(url2_pH, phValue, "pH (hourly)");
    enviarDatos(url2_ORP, orpValue, "ORP (hourly)");
  }
}

void enviarDatos(String url, float valor, String tipo) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    WiFiClient client;

    http.begin(client, url);
    http.addHeader("Content-Type", "application/json");
    http.addHeader("Fiware-Service", "tutorial");
    http.addHeader("Fiware-Servicepath", "/");

    String payload = "{\"value\": " + String(valor) + ", \"type\": \"Float\"}";
    int httpResponseCode = http.PUT(payload);

    if (httpResponseCode > 0) {
      Serial.printf("[HTTP] PUT %s... code: %d\n", tipo.c_str(), httpResponseCode);
      Serial.println(http.getString());
    } else {
      Serial.printf("[HTTP] PUT %s... failed, error: %s\n", tipo.c_str(), http.errorToString(httpResponseCode).c_str());
    }

    http.end();
  } else {
    Serial.println("WiFi no está conectado");
  }
}
