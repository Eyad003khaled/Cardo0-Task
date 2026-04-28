# ESP32 - Embedded Sensor Firmware

## Overview

The ESP32 firmware is a **C/C++ embedded application** running on an ESP32 microcontroller that periodically reads temperature and humidity data from a DHT22 sensor and transmits it to the backend API via HTTP.

## What This Component Does

- **Reads sensor data** from DHT22 temperature/humidity sensor on GPIO 15
- **Validates readings** and filters out invalid (NaN) measurements
- **Maintains WiFi connection** with automatic reconnection on network drops
- **Sends HTTP POST requests** to the backend with sensor readings as JSON
- **Provides serial debugging** output at 115200 baud for troubleshooting

## Hardware Configuration

| Component | Connection |
|-----------|-----------|
| DHT22 Data Pin | GPIO 15 |
| DHT22 VCC | 3.3V |
| DHT22 GND | GND |
| Serial Monitor | USB (115200 baud) |

```
DHT22 Sensor Pinout:
PIN 1 (VCC)  → ESP32 3.3V
PIN 2 (DATA) → GPIO 15 (optional 10kΩ pull-up)
PIN 3 (NC)   → Not Connected
PIN 4 (GND)  → GND
```

## Software Architecture

### Setup Phase
```cpp
setup() {
  Serial.begin(115200);           // Initialize serial communication
  WiFi.begin(ssid, password);     // Connect to WiFi
  dht.begin();                    // Initialize DHT22 sensor
}
```

### Main Loop
```cpp
loop() {
  if (WiFi.status() == WL_CONNECTED) {
    // 1. Read sensor
    float temp = dht.readTemperature();
    float humidity = dht.readHumidity();
    
    // 2. Validate data
    if (!isnan(temp) && !isnan(humidity)) {
      
      // 3. Create JSON payload
      String json = "{\"temperature\":" + String(temp) +
                    ",\"humidity\":" + String(humidity) + "}";
      
      // 4. Send HTTP POST
      http.begin(serverUrl);
      http.addHeader("Content-Type", "application/json");
      int responseCode = http.POST(json);
      http.end();
      
      // 5. Log via serial
      Serial.print("Temp: "); Serial.println(temp);
    }
  }
  
  delay(5000);  // Wait 5 seconds before next cycle
}
```

## Key Features

| Feature | Details |
|---------|---------|
| **Sensor Read Latency** | ~300ms per reading cycle |
| **HTTP Request Time** | <1 second (typical) |
| **Update Frequency** | Every 5 seconds (configurable) |
| **Power Consumption** | Minimal; supports battery operation |
| **WiFi Reconnection** | Automatic on network dropout |

## Configuration

Edit the following in `app_main.c`:

```cpp
// WiFi Credentials
const char* ssid = "Wokwi-GUEST";
const char* password = "";

// Backend Server
const char* serverUrl = "http://angry-corners-think.loca.lt/readings";

// Sensor Pin
#define DHTPIN 15
#define DHTTYPE DHT22

// Update Frequency
delay(5000);  // 5 seconds between readings
```

## Data Payload Format

**HTTP POST to `/readings`**

```json
{
  "temperature": 25.5,
  "humidity": 60.3
}
```

### Response Handling
- **200 OK**: Reading successfully stored
- **400 Bad Request**: Invalid JSON or missing fields
- **5xx Error**: Server-side error

Serial output example:
```
Connecting to WiFi....
Connected!
Temp: 25.5 °C, Humidity: 60.3 %
Response: 200
```

## Error Handling

| Error | Cause | Recovery |
|-------|-------|----------|
| DHT read fails (NaN) | Sensor communication error | Skip reading, retry next cycle |
| WiFi disconnected | Network unavailable | Auto-reconnect in main loop |
| HTTP POST fails | Backend unreachable | Log error, continue reading |

## Libraries Used

| Library | Purpose | Version |
|---------|---------|---------|
| WiFi.h | WiFi connectivity | Arduino core |
| HTTPClient.h | HTTP communication | Arduino core |
| DHT.h | DHT22 sensor driver | Adafruit DHT Sensor |

## Serial Monitor Output

To view real-time firmware output:
- **Baud Rate**: 115200
- **USB Port**: COM port where ESP32 is connected

Example output:
```
Connecting to WiFi.
.....
Connected!
Temp: 24.8 °C, Humidity: 55.2 %
Response: 201
Temp: 24.9 °C, Humidity: 55.5 %
Response: 201
```

## Debugging Tips

1. **No WiFi connection**: Verify SSID and password in code
2. **DHT sensor fails**: Check GPIO 15 wiring and pull-up resistor
3. **HTTP errors**: Verify `serverUrl` is accessible and backend is running
4. **Gibberish in serial**: Check baud rate is set to 115200

## Integration Points

- **Sensor Input**: DHT22 on GPIO 15 (measures every 5 seconds)
- **Network Output**: HTTP POST to `/readings` endpoint
- **Serial Output**: Debug logs at 115200 baud for troubleshooting

## Development Tools

- **IDE**: Arduino IDE v1.8.19+
- **Board**: esp32 by Espressif Systems
- **Compiler**: GCC (ARM embedded toolchain)

---

**Part of**: Cardoo IoT System  
**Created**: April 2026
