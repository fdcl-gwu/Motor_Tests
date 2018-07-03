This repository includes the code and the instructions for testing motors and measuring the relation between motor thrust and torque and throttle (command). 

# Setting-up the repository
Open a Terminal in the desired folder clone the repo :

    ```
    git clone https://github.com/fdcl-gwu/Motor_Tests
    cd Motor_Tests
    cd python_scripts
    ```

# Installing Arduino UNO
Download the latest version of Arduino from https://www.arduino.cc/en/Main/Software
(for example Linux 64 bits). Then save and extract it. Arduino will be executed from there.
In the extracted folder, open a new terminal, and to install it, type the command ./install.sh

When it is installed, open Arduino IDE, select board from Tools, and then select the appropriate board (for example UNO).

Then connect Arduino board with USB to the computer. 

# Calibrating the Meter

# Some measurement before starting the test

In this section, based on the loadcell capacity, the maximum weight (W2) that will be used for calibration, and the distance of motor and load cell from pivot will be measured.
The Matlab mfile (max_load.m) to calculate the following is provided in the Motor_Tests folder .

![alt text](Photo_readme/calib.gif "Description goes here")

In the following,

W_motor is the motor weight, and

F_max_allowed is the maximum load that the laod cell can measure. From the load cell manual (Omega LACE 600G), the maximum is 0.6 kgf, which is equal to 0.6*9.8=5.88 N, and

W1 is the weight on the distance d1 from pivot to have a horizontal bar (balancing the weight of the motor on the bar).


## Measure the maximum allowable load (W2) for calibration:

In this case, the motor is not running, so there is no thrust or torque from the motor.

W2_max=(F_max_allowed(d1+c)+W_motor*b-W1*d1)/d2 (N)

m2_max=W2_max/9.8/1000 (gr)

So, do not use a weight with more than m2_max mass.

## Measure the maximum thrust that the load cell can measure:

In other words, measure the amount of force that the load cell should measure if the motor provides the maximum thrust.

T_max is the maximum thrust of the motor. For Tiger 700 motor and 11*3.7 CF propeller, it is 12.04 N.

F_max_thrust=(T_max*b-W_motor*b+W1 d1)/(d1+c) (N)

If F_max_thrust > F_max_allowed, then decrease b and increase d1+c. 


## Measure the maximum torque that the load cell can measure:

In other words, measure the amount of force that the load cell should measure if the motor provides the maximum torque.

F_max_torque=(tau_max-W_motor*b+W1*d1)/(d1+c).

Again here, if F_max_torque > F_max_allowed, then decrease b and increase d1+c. 

# Running a Motor Test
1) Attach the motor to the test rig as shown above. Measure the distance between the pivot and motor (b), the pivot and sensor (d1), and the weight W2 and pivot (d2). If d2 is set to be d1+c, calculations become simpler.
2) Connect the Arduino to the force sensor and the ESC using the following connections:  
   **ESC <---> Arduino**  
   C <---> A5  
   D <---> A4  
   Gnd <---> Gnd 

   **Sensor <---> Arduino**  
   10 <---> A0  
   12 <---> Gnd  

3) Set up the force sensor.  
   _NOTE: The force sensor may need a few minutes to warm up. Values may start higher or lower than expected but will normalize after several minutes._

4)  From folder "python_scripts", open record.py, in the folder called "python_scripts" located inside the "Motor_Tests". Update the line "location='/dev/ttyACM0'" with the specific port name corresponding to the Arduino. To find the port name, in the Terminal write:
    ```
    ls /dev/tty*
    ```
5) Run a force calibration:
    1. Upload strain_reader.ino to the Arduino.
    2. From folder "python_scripts", open record.py. Update the line "text_file = open('/home/mbshbn/Documents/Motor_Tests/Results/calib_0.txt', 'w')" with the location and the name of the text file for data which will be saved later. A recommended text file name for no weight is 'calib_0.txt'. 
    3. With no weight on the sensor aside from the rig, run record.py for several seconds to determine the reading with zero thrust. to do this open a terminal in the folder called "python_scripts" and type
    :
    ```
    python record.py
    ```
    4. Add a known mass, for example 46 gr, to the rig and run record.py again. Make sure to change the file name in record.py; A recommended file name, for 46 gr mass, is 'calib_46.txt'. You should now have two text files that contain a single column of data read from the force sensor.
    5. Repeat step 5, for different masses. Make sure that you do not overload the load cell.

6) Attach a power supply to the motor and set it at a specific voltage (Tiger 700 motor and 11*3.7 CF propeller with 14.8 V), checking with a multimeter. The Voltage may drift during the tests so be prepared to adjust the supply accordingly.

7) Upload step_test.ino and run record.py (remember to update the file name, a recommended file name is'motor_voltage.txt'). Make sure that the propellers are blowing wind downside, otherwise reverse two of the motor wires. This should take about 15 mins. 

8) Repeat steps 4-6 for each voltage you want to test. Let the motor cool between each test to keep the data consistent. It is important to do a force calibration before or after every test as the force sensor's readings could change.

# Post processing the data
1. Make a new folder, and copy all the calibration text files as well as motor test data text files in it.
2. From the folder called "Post_process_Matlab_files", copy all the three mfiles to the folder that you made it.
3. Run post_porcess_thrust_test.m (instructions are provided inside the mfile) to compute and plot all required data from the thrust test. You may change the name of the text files which you saved from your experiment.
4. Run post_porcess_torque_test.m (instructions are provided inside the mfile) to compute and plot all required data from the torque test.
5. To compute C_tau, run compute_C_tau (instructions are provided inside the mfile). 

The results of processing data for Tiger 700 motor and 11*3.7 CF propeller with 14.8 V & 16.2 V are provided, and for 14.8 is summarized  in the Report folder inside the "tiger_5_31_2018_14p8 volt" folder.
thrust=p1*throttle^2 + p2*throttle + p3.

From 14.8V:  C_tau=0.0135.

From 16.2V: p1 = 0.0002036, p2 = 0.003627, p3 = 0.6563. So, throttle=sqrt((thrust-p3)/p1+p2^2/4/p1/p1)-p2/2/p1
or you can type "cftool" in Matlab command, and fit a function to data:
![alt text](Photo_readme/fit.gif "Description goes here")

# Find voltage and throttle relationships
Run analysis.py to filter data and format it for graphing. Be sure to update the file paths and tailor the data analysis to fit your own needs.

Using the data from analysis.py, you can run escVolt2cmd.py, escVolt2cmd_send.py, inputVolt2cmd.py, or inputVolt2cmd_send.py. Before running either of the send programs, do a force calibration, input the v1, v2, d, b, and m values into cmd_reader.ino, and then upload cmd_reader to the arduino. 
- inputVolt2cmd.py calculates the proper command given the desired force and input voltage
- inputVolt2cmd_send.py does the calculations of inputVolt2cmd.py and sends the command to the ESC.
- escVolt2cmd_send.py reads voltage from the ESC, takes the desired force and calculates the proper command. It continuously updates the command based on the changing voltage.
- escVot2cmd.py simulates the behavior of escVolt2cmd_send.py by predicting the voltage change from a command change.

Data from the following motors are included:
- robbe Roxxy BL-Motor 2827-35, 760kv. 10x4.5 prop
- tiger mn3110-17, 700kv. 10x4.7 prop

