"""
This code records serial data as an array of strings
"""

from __future__ import print_function
import serial

connected = False

location='/dev/ttyACM0'

ser = serial.Serial(location, 9600)

## loop until the arduino tells us it is ready
while not connected:
    serin = ser.read()
    connected = True

text_file = open('../tiger_mn3110-17_T9545/motor_calib_16p4.txt', 'w') #name of target file
#recommended file name format: <path><motor><input_voltage><type>.txt
#(type: v1, v2, nothing, etc)

n = 1

while True:
    if ser.inWaiting():
        x = ser.read()
        # text_file.write(str(x.decode('utf-8')))
        text_file.write(str(x))
        print(str(x.decode('utf-8')), end='')

        if x.decode('utf-8') == '\n':
            print('saved ' + str(n) + ' lines ')
            n += 1
text_file.close()
ser.close()
