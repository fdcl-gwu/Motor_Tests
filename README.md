# Motor_Tests
This repository includes the code to 

# Setting-up the repository
Open a Terminal in the desired place and clone the repo :

    ```
    git clone https://github.com/fdcl-gwu/Motor_Tests
    cd Motor_Tests
    cd python_scripts
    ```

# Installing Arduino UNO
Download the latest version of Arduino from https://www.arduino.cc/en/Main/Software . For the specific computer for the motor test, download the Arduino IDE for Linux 64 bits. Then save it, and extract it. Arduino will be executed from there. In the extracted folder, open a new terminal, and to install it, type the command ./install.sh
(Source: https://www.arduino.cc/en/Guide/Linux/ )

When it is installed, open Arduino IDE, from Tools, select board, and then select the appropriate board (for example UNO).

Then connect Arduino board with USB to the computer. 

# Calibrating the Meter

# Running a Motor Test
1) Attach the motor to the test rig as shown in test_rig_setup.jpg. Measure the distance between the pivot and motor (b) and the pivot and sensor (d), preferably using calipers.

2) Connect the arduino to the force sensor and the ESC using the following connections:  
   **ESC <---> Arduino**  
   C <---> A5  
   D <---> A4  
   Gnd <---> Gnd 

   **Sensor <---> Arduino**  
   10 <---> A0  
   12 <---> Gnd  

3) Set up the force sensor.  
   _NOTE: The force sensor may need a few minutes to warm up. Values may start higher or lower than expected but will normalize after several minutes._

4) Run a force calibration:
    1. Upload strain_reader.ino to the arduino.
    2. From folder "python_scripts", open record.py. Update the line "text_file = open('/home/mbshbn/Documents/Motor_Tests/Results/calib_0.txt', 'w')" with the location and the name of the text file for data which will be saved later. A recommended text file name for no weight is 'calib_0.txt'. Also, Update the line "location='/dev/ttyACM0'" with the specefic port name corresponding to the arduino. To find the port name, in the Terminal write:
    ```
    ls /dev/tty*
    ```
    3. With no weight on the sensor aside from the rig, run record.py for several seconds to determine the reading with zero thrust. To do this, open a Terminal in the folder called "python_scripts" located inside the "Motor_Tests", and type the following in the Terminal
:
    ```
    python record.py
    ```
    4. Add a known mass, for example 46 gr, to the rig and run record.py again. Make sure to change the file name in record.py; A recommended file name, for 46 gr mass, is 'calib_46.txt'. You should now have two text files that contain a single column of data read from the force sensor.
    5. Repeat step 4, for different masses. Make sure that you do not add overload the load cell. The maximum alloawable mass for calibration can be found using the provided Matlab mfile in the MAotor_Tests folder. For the current configuration, it is 612 gram.

5) Attach a power supply to the motor and set it at a specific voltage, checking with a multimeter. Voltage may drift during the tests so be prepared to adjust the supply accordingly. For Tiger 700rpm moter with 11*3.7L propellers set voltage to 14.8 v.

6) Upload step_test.ino and run record.py (remember to update the file name, recommended file name is'<motor><voltage>v2.txt'). Make sure that the propellers are blowing wind donside, otherwise reverse two of the motor wires. This should take about 15 mins. 

7) Repeat steps 4-6 for each voltage you want to test. Let the motor cool between each test to keep the data consistent. It is important to do a force calibration before or after every test as the force sensor's readings could change.

8) Run analysis.py to filter data and format it for graphing. Be sure to update the file paths and tailor the data analysis to fit your own needs.

# Using the Motor Data
Using the data from analysis.py, you can run escVolt2cmd.py, escVolt2cmd_send.py, inputVolt2cmd.py, or inputVolt2cmd_send.py. Before running either of the send programs, do a force calibration, input the v1, v2, d, b, and m values into cmd_reader.ino, and then upload cmd_reader to the arduino. 
- inputVolt2cmd.py calculates the proper command given a desired force and input voltage
- inputVolt2cmd_send.py does the calculations of inputVolt2cmd.py and sends the command to the ESC.
- escVolt2cmd_send.py reads voltage from the esc, takes a desired force and calculates the proper command. It continuously updates the command based on the changing voltage.
- escVot2cmd.py simulates the behavior of escVolt2cmd_send.py by predicting the voltage change from a command change.

Data from the following motors is included:
- robbe Roxxy BL-Motor 2827-35, 760kv. 10x4.5 prop
- tiger mn3110-17, 700kv. 10x4.7 prop

