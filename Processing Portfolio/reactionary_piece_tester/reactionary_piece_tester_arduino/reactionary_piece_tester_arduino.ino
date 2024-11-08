#include <PulseSensorPlayground.h>

const int PulseWire = 0;       // Pulse Sensor purple wire connected to analog pin 0
const int LED13 = 13;          // The on-board Arduino LED, close to pin 13.
int Threshold = 550;           // Determine which Signal to "count as a beat" and which to ignore.

PulseSensorPlayground pulseSensor; // Creates an instance of the PulseSensorPlayground object called "pulseSensor"

void setup() {
  Serial.begin(9600);          // For Serial Monitor
  pulseSensor.analogInput(PulseWire);
  pulseSensor.blinkOnPulse(LED13);       // Blinks the LED on pin 13 with heartbeat.
  pulseSensor.setThreshold(Threshold);

  if (pulseSensor.begin()) {
    Serial.println("PulseSensor object created!");
  }
}

void loop() {
  int myBPM = pulseSensor.getBeatsPerMinute();  // Calculates BPM
  if (pulseSensor.sawStartOfBeat()) {           // Constantly test to see if "a beat happened".
    Serial.println(myBPM);                      // Print the BPM value.
  }
  delay(20);                                    // recommended 20ms delay to keep from overloading the serial port
}
