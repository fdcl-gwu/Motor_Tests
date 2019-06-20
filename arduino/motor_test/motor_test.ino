#include "Wire.h"

#define TWI_BLCTRL_BASEADDR 0x52
#define TWI_BLCTRL_BASEADDR_READ 0x53

int motor_command = 10;

void setup() {
  Wire.begin();
  Serial.begin(9600);
  delay(1000);
}


void send_command(int cmd) {
  Wire.beginTransmission((TWI_BLCTRL_BASEADDR + (0 << 1)) >> 1);
  Wire.write(cmd);
  Wire.endTransmission();
}


void loop() {
  if (Serial.available()) {
    String input = Serial.readStringUntil('\n');
    motor_command = input.toInt();
  }
  
  send_command(motor_command);
}
