clear all;
close all;

x = 0:0.1:15;

y1 = 76.66 * x .^ 0.4989 - 29.16; % MN3110 APC
y2 = 105.2 * x .^ 0.4679 - 45.09; % MN3110 9545
y3 = 80.9 * x .^ 0.464 - 38.83; % U3 APC
y4 = 61.01 * x .^ 0.5634 - 11.35; % MN3110 APC Old

figure;
plot(y1, x, y2, x, y3, x, y4, x);
xlim([0, 250])
legend('y1', 'y2', 'y3', 'y4')
xlabel('Thrust (N)')
ylabel('Throttle Command')
title('Inverse Motor Calibration Curve')


figure;
plot(x, y1, x, y2, x, y3, x, y4);
ylim([0, 250])
legend('y1', 'y2', 'y3', 'y4')
xlabel('Throttle Command')
ylabel('Thrust (N)')
title('Motor Calibration Curve')

%% Data shown on the Omega ADC, saved by hand

% length of the arm from pivot to the motor in meters
arm_motor = 18.5 / 100;

% length of the arm from pivot to the load cell in meters
arm_load_cell = 24.2 / 100; 

cmd = 10:10:250;

w1 = [18, 35, 48, 66, 85, 105, 123, 150, 174, 225, 257, 280, 340, 405, ...
    450, 496, 532, 605, 690, 715, 725, 772, 926, 990, 997]; % MN3110 APC
w2 = [14, 20, 30, 59, 75, 92, 106, 122, 138, 160, 170, 187, 213, 250, ...
    287, 320, 357, 410, 460, 485, 513, 549, 630, 684, 687]; % MN3110 9545
w3 = [22, 40, 60, 81, 104, 124, 145, 172, 204, 240, 270, 318, 380, 450, ...
    500, 535, 572, 687, 758, 785, 805, 877, 1020, 1099, 1117]; % U3 APC

convert_factor = 1 / 1e3 * 9.81 * arm_load_cell / arm_motor;
th1 = w1 * convert_factor;  % N
th2 = w2 * convert_factor;  % N
th3 = w3 * convert_factor;  % N

figure;
scatter(cmd, th1);
hold on;
plot(y1, x);
title('y1');

figure;
scatter(cmd, th2);
hold on;
plot(y2, x);
title('y2');

figure;
scatter(cmd, th3);
hold on;
plot(y3, x);
title('y3');
hold off;