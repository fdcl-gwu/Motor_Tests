clear;close all;clc

path = "../tiger_u3_apc10x4p7/";
motor_calibration_file = path + 'motor_calib_16p4.txt';

y=[0; 72; 100; 172; 500; 600];  % W2 (gram) on the sensor

calib0 = import_text_data(path + "calib_0.txt");
calib72 = import_text_data(path + "calib_72.txt");
calib100 = import_text_data(path + "calib_100.txt");
calib172 = import_text_data(path + "calib_172.txt");
calib500 = import_text_data(path + "calib_500.txt");
calib600 = import_text_data(path + "calib_600.txt");


% length of the arm from pivot to the motor in meters
arm_motor = 18.5 / 100;

% length of the arm from pivot to the load cell in meters
arm_load_cell = 24.5 / 100;  


save all_calib_thrust_data

%% Reading calibration data:

% load all_calib_thrust_data
x(1)=mean(keep_last_2000(calib0));
x(2)=mean(keep_last_2000(calib72));
x(3)=mean(keep_last_2000(calib100));
x(4)=mean(keep_last_2000(calib172));
x(5)=mean(keep_last_2000(calib500));
x(6)=mean(keep_last_2000(calib600));

%% Meter Calibration
% Find the relationship between reading from load cell and weights

mass_function = fit(x', y, 'poly1')

figure
plot(x, mass_function(x), '--', x, y', 'k.');
title('Meter Calibration');
xlabel('Meter Reading');
ylabel('Mass (grams)');

%% Motor Calibration

delimiter = ',';
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(motor_calibration_file,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, ...
    'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);

Command = dataArray{:, 1};     % 10 : 250
Current = dataArray{:, 2};      
State = dataArray{:, 3};       % Must be 255
Temp = dataArray{:, 4};
RPM_Hz = dataArray{:, 5};
MAH = dataArray{:, 6};
Volt = dataArray{:, 7};
Omega_read = dataArray{:, 8};

clearvars filename delimiter formatSpec fileID dataArray ans;

% Variable scalings
Current = Current / 10;
Volt = Volt ./ 10;
RPM = RPM_Hz .* 60;

Weight= 9.8 * mass_function(Omega_read) / 1000;  % kg
thrust = arm_load_cell .* Weight / arm_motor;  % N

for j = 1:25  % Arduino sends 10:10:250
    A{j} = find(Command == 10 + (j - 1) * 10);
    Command_avg{j} = 10 + (j - 1) * 10;
    init_state{j} = find(State(A{j}) == 255, 1) + 150;
    Current_avg{j} = mean(Current(A{j}(init_state{j}:end)));
    Temp_avg{j} = mean(Temp(A{j}(init_state{j}:end)));
    RPM_Hz_avg{j} = mean(RPM_Hz(A{j}(init_state{j}:end)));
    RPM_avg{j} = mean(RPM(A{j}(init_state{j}:end)));
    MAH_avg{j} = mean(MAH(A{j}(init_state{j}:end)));
    Volt_avg{j} = mean(Volt(A{j}(init_state{j}:end)));
    Weight_avg{j} = mean(Weight(A{j}(init_state{j}:end)));

    Thrust_avg{j} = mean(thrust(A{j}(init_state{j}:end)));
    %Torque_avg{j}=mean(torque(A{j}(init_state{j}:end)));
end

Command_avg = cell2mat(Command_avg);
init_state = cell2mat(init_state);
Current_avg = cell2mat(Current_avg);
Temp_avg = cell2mat(Temp_avg);
RPM_Hz_avg = cell2mat(RPM_Hz_avg);
RPM_avg = cell2mat(RPM_avg);
MAH_avg = cell2mat(MAH_avg);
Volt_avg = cell2mat(Volt_avg);
Weight_avg = cell2mat(Weight_avg);
Thrust_avg = cell2mat(Thrust_avg);


calibration_curve = fit(Thrust_avg', Command_avg', 'poly2')

figure
plot(Thrust_avg, calibration_curve(Thrust_avg), '--', ...
    Thrust_avg, Command_avg, 'k.');
xlabel('Thrust (N)')
ylabel('Throttle Command')
title('Motor Calibration Curve')

% % Now find the inverse of 2nd order polynomial:
% Command_avg_inversepoly2=sqrt((Thrust_avg-p3)/p1+p2^2/4/p1/p1)-p2/2/p1;
% 
% figure
% plot(Thrust_avg,Command_avg_inversepoly2,'--',Thrust_avg,Command_avg,'k.');
% xlabel('Thrust (N)')
% ylabel('Throttle')
% title('throttle=sqrt((Thrust-p3)/p1+p2^2/4/p1/p1)-p2/2/p1')
% 
% %>>>>>>>>>>>>>use "cftool" for the curve fitting <<<<<< 
% % from cftool: Type cftool in matlab comamnd line:
% %Coefficients (with 95% confidence bounds):
% a =       129.9 ;% (100.1, 159.8)
% b =       0.3666 ;% (0.3092, 0.4241)
% c =      -96.73 ;% (-127.8, -65.62)
% Thrust_to_throttle_func = a.*Thrust_avg.^b+c;
% % check other numbers:
% t1= a*0^b+c
% t2 = a*14^b+c
% %%
% % to save in diffrent folder saveas(gcf,[pwd
% % ['Motor1_114_Current' ],'.fig']); and
% % saveas(gcf,[pwd ['Motor1_120_Current' ],'.eps'],'epsc2');
% figure
% AxesFont_f=16;font_f=16;
% set(gcf,'DefaultAxesFontSize',AxesFont_f);
% 
% Power_avg=Volt_avg.*Current_avg;
% scatter(Command_avg,Power_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('Power_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148Powerfig');
% saveas(gcf,'C_tau_148Power','epsc2');
% 
% scatter(Command_avg,Current_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('Current_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148Currentfig');
% saveas(gcf,'C_tau_148Current','epsc2');
% figure
% scatter(Command_avg,Temp_avg)
% xlabel('Command_avg');ylabel('Temp_avg')
% saveas(gcf,'C_tau_148Temp.fig');
% saveas(gcf,'C_tau_148Temp.eps','epsc2');
% figure
% scatter(Command_avg,RPM_Hz_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('RPM_Hz_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148RPM_Hz.fig');
% saveas(gcf,'C_tau_148RPM_Hz.eps','epsc2');
% figure
% scatter(Command_avg,RPM_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('RPM_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148RPM.fig');
% saveas(gcf,'C_tau_148RPM.eps','epsc2');
% figure
% scatter(Command_avg,MAH_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('MAH_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148MAH.fig');
% saveas(gcf,'C_tau_148MAH.eps','epsc2');
% figure
% scatter(Command_avg,Volt_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('Volt_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148Volt.fig');
% saveas(gcf,'C_tau_148Volt.eps','epsc2');
% figure
% scatter(Command_avg,Weight_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('Weight_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148wieght.fig');
% saveas(gcf,'C_tau_148wieght.eps','epsc2');
% figure
% scatter(Command_avg,Thrust_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('Thrust_avg (N)','fontsize',font_f,'interpreter','latex')
% saveas(gcf,'C_tau_148thrust.fig');
% saveas(gcf,'C_tau_148thrust.eps','epsc2');
% %% saving the requied data to find C_tau
% save('thrusts_data.mat','Command_avg','Thrust_avg')
