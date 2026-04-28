#include <WiFi.h>
#include <HTTPClient.h>
// #include <WiFiClientSecure.h>
#include "DHT.h"

#define DHTPIN 15
#define DHTTYPE DHT22

const char* ssid = "Wokwi-GUEST";
const char* password = "";

// Use your ngrok localtunnel URL here
const char* serverUrl = "http://angry-corners-think.loca.lt/readings";

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(115200);

  WiFi.begin(ssid, password);
  Serial.print("Connecting to WiFi");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nConnected!");

  dht.begin();
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    float temp = dht.readTemperature();
    float humidity = dht.readHumidity();

    if (!isnan(temp) && !isnan(humidity)) {
      // WiFiClientSecure client;
      // client.setInsecure(); // bypass SSL

      HTTPClient http;
      http.begin(serverUrl);
      http.addHeader("Content-Type", "application/json");
      http.addHeader("User-Agent", "ESP32"); 


      String json = "{\"temperature\":" + String(temp) +
                    ",\"humidity\":" + String(humidity) + "}";

      int responseCode = http.POST(json);

      Serial.print("Response: ");
      Serial.println(responseCode);


      
      Serial.print("Temp: ");
      Serial.print(temp);
      Serial.print(" °C, Humidity: ");
      Serial.print(humidity);
      Serial.println(" %");
      

      http.end();
    }
  }

  delay(5000); // send every 5 seconds
}