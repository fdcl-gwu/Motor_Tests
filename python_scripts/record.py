"""
This code records serial data as an array of strings
"""

import serial

connected = False

location='/dev/cu.usbmodem1A12401'

ser = serial.Serial(location, 9600)

## loop until the arduino tells us it is ready
while not connected:
    serin = ser.read()
    connected = True

text_file = open('../tiger_u3_apc10x4p7/motor_calib_16p4.txt', 'w') #name of target file
#recommended file name format: <path><motor><input_voltage><type>.txt
#(type: v1, v2, nothing, etc)

n = 1

while True:
    if ser.inWaiting():
        x = ser.read()
        text_file.write(str(x.decode('utf-8')))
        print(str(x.decode('utf-8')), end='')

        if x.decode('utf-8') == '\n':
            print('saved ' + str(n) + ' lines ')
            n += 1
text_file.close()
ser.close()
