/*
   file DFRobot_PH_TempComp_Test.ino

   This is the sample code and library for a Cheap Analog pH Sensor, derriven from the work that DFRobot did for their Gravity: Analog pH Sensor / Meter Kit V2, SKU: SEN0161-V2
   
   In order to guarantee precision, a temperature sensor such as DS18B20 is needed, to execute automatic temperature compensation.
   You can send commands in the serial monitor to execute the calibration.
   Serial Commands:
     enterph -> enter the calibration mode
     calph   -> calibrate with the standard buffer solution, two buffer solutions(4.0 and 7.0) will be automaticlly recognized
     exitph  -> save the calibrated parameters and exit from calibration mode

   Copyright   GNU Lesser General Public License

   version  V1.1
   date  2019-04
*/

#include "DFRobot_PH.h"
#include <EEPROM.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#define PH_PIN A0
#define ONE_WIRE_BUS 2
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

float voltage, phValue, temperature = 25;
DFRobot_PH ph;

void setup()
{
  Serial.begin(115200);
  ph.begin();
  sensors.begin();
}

void loop()
{

  static unsigned long timepoint = millis();
  if (millis() - timepoint > 1000U) {                 //time interval: 1s
    timepoint = millis();
    temperature = readTemperature();                  // read your temperature sensor to execute temperature compensation
    voltage = analogRead(PH_PIN) / 1024.0 * 5000;     // read the voltage
    phValue = ph.readPH(voltage, temperature);        // convert voltage to pH with temperature compensation
    Serial.print("temperature:");
    Serial.print(temperature, 1);
    Serial.print("^C  pH:");
    Serial.println(phValue, 2);
  }
  ph.calibration(voltage, temperature);               // calibration process by Serail CMD

}

float readTemperature()
{
  sensors.requestTemperatures();
  float i = sensors.getTempCByIndex(0);
  return (i);
}
