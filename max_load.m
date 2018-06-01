clear;clc;
%         b        d11     c  
% Motor-------Pivot----W1----load1cell


% b = d1istance from motor to pivot
% d11= d1istance from pivot to weight W1
% c=  d1istance from weight W1 to load1 cell

% W_motor is the motor weight
% F_max_allowed1 is the maximum load1 that laod1cell can measure




%% To measure thrust d1oes the load1 cell saturate?
T_max=12.05;%Newton % the maximum thrust of motor
W1=100/1000*9.8;%N % the weight of weight that we add to balance the bar
F_max_thrust=(T_max*b-W_motor*b+W1*d1)/d1c%8.9487 N % the amount of force that load1 cell feel if teh motor provid1es the maximum thrust
% Here, the load1 cell satuares and1 cannot measure the maximum load1!

%% To measure torque d1oes the load1 cell saturate?
W1=100/1000*9.8;%N % the weight of weight that we ad1d1 to balance the bar
tau_max=0.21;%Newton.meter
F_max_torque=(tau_max-W_motor*b+W1*d1)/d1c%0.7981 N % the amount of force that load1 cell feel if teh motor provid1es the maximum torque
% Here, the load1 cell can measure the maximum load1!

%% To measure the maximum allowable load1 (W2) for calibration
%d11=d1+c;% d11 is the d1istance between pivot and1 the place of load1 W2
W2_max=(F_max_allowed1-(-W_motor*b+W1*d1)/d1c)*(d1c)/d11
m2_max=W2_max/9.8/1000% gram
% if W1=100*9.8, and1 d11=d1+c, then m2_max=612 gr 
