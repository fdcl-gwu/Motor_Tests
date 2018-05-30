clear;clc;
%            b        d1     c  
% Motor-------Pivot----W1----loadcell


% b = distance from motor to pivot
% d1= distance from pivot to weight W1
% c=  distance from weight W1 to load cell

% W_motor is the motor weight
% F_max_allowed is the maximum load that laodcell can measure

F_max_allowed=0.6*9.8%=5.88 N
dc=23/100;%meter
W_motor=126/1000*9.8;%N
b=17.3/100;%m
d=19.1/100;%meter

%% To measure thrust does the load cell saturate?
T_max=12.05;%Newton % the maximum thrust of motor
W1=100/1000*9.8;%N % the weight of weight that we add to balance the bar
F_max_thrust=(T_max*b-W_motor*b+W1*d)/dc%8.9487 N % the amount of force that load cell feel if teh motor provides the maximum thrust
% Here, the load cell satuares and cannot measure the maximum load!

%% To measure torque does the load cell saturate?
W1=100/1000*9.8;%N % the weight of weight that we add to balance the bar
tau_max=0.21;%Newton.meter
F_max_torque=(tau_max-W_motor*b+W1*d)/dc%0.7981 N % the amount of force that load cell feel if teh motor provides the maximum torque
% Here, the load cell can measure the maximum load!
