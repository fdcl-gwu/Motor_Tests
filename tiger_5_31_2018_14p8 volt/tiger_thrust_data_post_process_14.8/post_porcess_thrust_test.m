clear;close all;clc
%% reading calibration data:
load all_calib_thrust_data
% Do not use the first and the last parts of data 
size(calib0)
x(1)=mean(calib0(1000:4000));
size(calib72)
x(2)=mean(calib72(1000:4000));
size(calib100)
x(3)=mean(calib100(1000:2500));%%%
size(calib172)
x(4)=mean(calib172(1000:2500));
size(calib200)
x(5)=mean(calib200(1000:2200));
size(calib272)
x(6)=mean(calib272(1000:3000));
size(calib300)
x(7)=mean(calib300(1000:3900));
size(calib372)
x(8)=mean(calib372(1000:3900));
size(calib500)
x(9)=mean(calib500(1000:3500));
%% Find the relationship between reading from load cell and weights
x % reading from load cell
y=[0;72;100;172;200;272;300;372;500];% known mass (gram) on the sensor
mass_function = fit(x',y,'poly1')
% mass_function = 
%      Linear model Poly1:
%      mass_function(x) = p1*x + p2
%      Coefficients (with 95% confidence bounds):
%        p1 =      0.4959  (0.4806, 0.5113)
%        p2 =      -18.28  (-26.98, -9.576)
figure
plot(mass_function,'--',x,y','k.');
xlabel('Reading from load cell')
ylabel('Mass (gr)')
%%
arm_motor=8.2/100;
arm_load_cell=23/100;
%% Read File
filename = 'F:\FDCL Mahdis Git\Motor_Tests\tiger_5_31_2018\tiger_thrust_data_post_process_14.8\thrust_tets_148.txt'
delimiter = ',';
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
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
%% Variable scalings
Current=Current/10;
Volt=Volt./10;
RPM=RPM_Hz.*60;

Weight=9.8*mass_function(Omega_read)/1000;% kg
thrust=arm_load_cell.*Weight/arm_motor;% N
%%
% cell arrays:
for j=1:22
    A{j} =find(Command==10+(j-1)*10);
    Command_avg{j}=10+(j-1)*10;
    init_state{j}=find(State(A{j})==255,1)+150;% A{j}(1)+% 150=350*3/7, 350=7700/21
                                               % do not use 3 first seconds of data
    Current_avg{j}=mean(Current(A{j}(init_state{j}:end)));
    Temp_avg{j}=mean(Temp(A{j}(init_state{j}:end)));
    RPM_Hz_avg{j}=mean(RPM_Hz(A{j}(init_state{j}:end)));
    RPM_avg{j}=mean(RPM(A{j}(init_state{j}:end)));
    MAH_avg{j}=mean(MAH(A{j}(init_state{j}:end)));
    Volt_avg{j}=mean(Volt(A{j}(init_state{j}:end)));
    Weight_avg{j}=mean(Weight(A{j}(init_state{j}:end)));

    Thrust_avg{j}=mean(thrust(A{j}(init_state{j}:end)));
    %Torque_avg{j}=mean(torque(A{j}(init_state{j}:end)));
end
Command_avg=cell2mat(Command_avg);
init_state=cell2mat(init_state);
Current_avg=cell2mat(Current_avg);
Temp_avg=cell2mat(Temp_avg);
RPM_Hz_avg=cell2mat(RPM_Hz_avg);
RPM_avg=cell2mat(RPM_avg);
MAH_avg=cell2mat(MAH_avg);
Volt_avg=cell2mat(Volt_avg);
Weight_avg=cell2mat(Weight_avg);
Thrust_avg=cell2mat(Thrust_avg);

<<<<<<< HEAD:tiger_5_31_2018/tiger_thrust_data_post_process/post_porcess_thrust_test.m

mass_function = fit(Command_avg,Thrust_avg,'poly1')


save('thrust_data_148')
=======
Thrust_throttle_func = fit(Thrust_avg',Command_avg','poly2')
% Linear model Poly2:
%      Thrust_throttle_func(x) = p1*x^2 + p2*x + p3
%      Coefficients (with 95% confidence bounds):
%        p1 =      -1.784  (-2.176, -1.392)
%        p2 =       38.45  (34.62, 42.28)
%        p3 =       6.359  (-0.6873, 13.4)
figure
plot(Thrust_throttle_func,'--',Thrust_avg,Command_avg,'k.');
xlabel('Thrust (N)')
ylabel('Throttle')


%save('thrust_data_148')
>>>>>>> mahdis:tiger_5_31_2018_14p8 volt/tiger_thrust_data_post_process_14.8/post_porcess_thrust_test.m
%%
% to save in diffrent folder saveas(gcf,[pwd
% ['Motor1_114_Current' ],'.fig']); and
% saveas(gcf,[pwd ['Motor1_120_Current' ],'.eps'],'epsc2');

AxesFont_f=16;font_f=16;
set(gcf,'DefaultAxesFontSize',AxesFont_f);
scatter(Command_avg,Current_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Current_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148Currentfig');
saveas(gcf,'C_tau_148Current','epsc2');
figure
scatter(Command_avg,Temp_avg)
xlabel('Command_avg');ylabel('Temp_avg')
saveas(gcf,'C_tau_148Temp.fig');
saveas(gcf,'C_tau_148Temp.eps','epsc2');
figure
scatter(Command_avg,RPM_Hz_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('RPM_Hz_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148RPM_Hz.fig');
saveas(gcf,'C_tau_148RPM_Hz.eps','epsc2');
figure
scatter(Command_avg,RPM_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('RPM_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148RPM.fig');
saveas(gcf,'C_tau_148RPM.eps','epsc2');
figure
scatter(Command_avg,MAH_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('MAH_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148MAH.fig');
saveas(gcf,'C_tau_148MAH.eps','epsc2');
figure
scatter(Command_avg,Volt_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Volt_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148Volt.fig');
saveas(gcf,'C_tau_148Volt.eps','epsc2');
figure
scatter(Command_avg,Weight_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Weight_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148wieght.fig');
saveas(gcf,'C_tau_148wieght.eps','epsc2');
figure
scatter(Command_avg,Thrust_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Thrust_avg (N)','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148thrust.fig');
saveas(gcf,'C_tau_148thrust.eps','epsc2');
%% saving the requied data to find C_tau
save('thrusts_data.mat','Command_avg','Thrust_avg')