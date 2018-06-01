clear;close all;clc
%% calibrate:
load all_calib_thrust_data
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
x % read from gauge
y=[0;72;100;172;200;272;300;372;500];% known mass (gram) on the sensor
mass_function = fit(x',y,'poly1')
% Linear model Poly1:
%      mass_function(x) = p1*x + p2
%      Coefficients (with 95% confidence bounds):
%        p1 =      0.4947  (0.4912, 0.4983)
%        p2 =      -7.689  (-9.52, -5.858)
figure
plot(mass_function,'--',x,y','k.');
xlabel('Reading from load cell')
ylabel('Mass (gr)')
%%
arm_motor=8.2/100;
arm_gauge=23/100;
%%

% In the follwing code, select a text file to be read for example
% 'Motor1_11.1.txt', then change the name of file to be saved in
% save('Motor1_114') and also in saveas(gcf,[pwd
% ['Motor1_114_Current' ],'.fig']); and
% saveas(gcf,[pwd ['Motor1_120_Current' ],'.eps'],'epsc2');

%% Read File
filename = 'F:\FDCL Mahdis Git\Motor_Tests\tiger_thrust_for_Ctau\thrust_tets_148.txt'
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
thrust=arm_gauge.*Weight/arm_motor;% N
%torque=arm_gauge.*Weight;
%%
% cell arrays:
for j=1:22
    j
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
%Torque_avg=cell2mat(Torque_avg);

% size(Thrust_avg)
% size(Torque_avg)
% Torque_thrust_function = fit(Thrust_avg',Torque_avg','poly1')
% figure
% plot(Torque_thrust_function,'--',Thrust_avg,Torque_avg','k.');
% xlabel('Thrust avg (N)')
% ylabel('Torque avg (Nm)')

save('Ctau_148')

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

% saveas(gcf,[pwd ['C_tau_148thrust' ],'.fig']);
% saveas(gcf,[pwd ['C_tau_148thrust' ],'.eps'],'epsc2');

save('thrusts_data.mat','Command_avg','Thrust_avg')