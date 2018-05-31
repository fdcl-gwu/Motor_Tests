close all;clear;
clc
% In the follwing code, select a text file to be read for example
% 'Motor1_11.1.txt', then change the name of file to be saved in
% save('Motor1_114') and also in saveas(gcf,[pwd
% ['Motor1_114_Current' ],'.fig']); and
% saveas(gcf,[pwd ['Motor1_120_Current' ],'.eps'],'epsc2');

%% Read File
filename = 'F:\FDCL Mahdis Git\Motor_Calibration\kuya_120.txt';
delimiter = ',';
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);

Command = dataArray{:, 1};         % 40 : 250
Current = dataArray{:, 2};      % Must be 255
State = dataArray{:, 3};
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
% find the relation between saved data from gauge and mass
% x=[461;190;94];% read from gauge
% y=[500;203;103];% known mass (gram) on the sensor
% mass_function = fit(x,y,'poly1')
% % for example to if reading from sensor is 10, thebn weight is "mass_function(10)" 
% figure
% plot(mass_function,'--',x',y','k.');
% Linear model Poly1:
%      weight_function(x) = p1*x + p2
%      Coefficients (with 95% confidence bounds):
%        p1 =       1.085  (0.9419, 1.228)
%        p2 =     -0.7357  (-42.62, 41.15)
%% for Kalpesh
x=[0;410];% read from gauge
y=[0;200];% known mass (gram) on the sensor
mass_function = fit(x,y,'poly1')
figure
plot(mass_function,'--',x',y','k.');
arm_thrust=(310-240)/1000%
arm_gauge=240/1000%
%%
% arm_thrust=176.5/1000;
% arm_gauge=236/1000;
Weight=9.8*mass_function(Omega_read)/1000;% kg
thrust=arm_gauge.*Weight/arm_thrust;% N
%%
% cell arrays:
for j=1:22
    A{j} =find(Command==40+(j-1)*10);
    Command_avg{j}=40+(j-1)*10;
    init_state{j}=find(State(A{j})==255,1)+150;%A{j}(1)+% 150=350*3/7, 350=7700/21
                           % do not use 3 first seconds of data
    Current_avg{j}=mean(Current(A{j}(init_state{j}:end)));
    Temp_avg{j}=mean(Temp(A{j}(init_state{j}:end)));
    RPM_Hz_avg{j}=mean(RPM_Hz(A{j}(init_state{j}:end)));
    RPM_avg{j}=mean(RPM(A{j}(init_state{j}:end)));
    MAH_avg{j}=mean(MAH(A{j}(init_state{j}:end)));
    Volt_avg{j}=mean(Volt(A{j}(init_state{j}:end)));
    Weight_avg{j}=mean(Weight(A{j}(init_state{j}:end)));

    Thrust_avg{j}=mean(thrust(A{j}(init_state{j}:end)));
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

save('kuya_120')

AxesFont_f=16;font_f=16;
set(gcf,'DefaultAxesFontSize',AxesFont_f);
scatter(Command_avg,Current_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Current_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'kuya_120_Currentfig');
saveas(gcf,'kuya_120_Current','epsc2');
figure
scatter(Command_avg,Temp_avg)
xlabel('Command_avg');ylabel('Temp_avg')
saveas(gcf,'kuya_120_Temp.fig');
saveas(gcf,'kuya_120_Temp.eps','epsc2');
figure
scatter(Command_avg,RPM_Hz_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('RPM_Hz_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'kuya_120_RPM_Hz.fig');
saveas(gcf,'kuya_120_RPM_Hz.eps','epsc2');
figure
scatter(Command_avg,RPM_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('RPM_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'kuya_120_RPM.fig');
saveas(gcf,'kuya_120_RPM.eps','epsc2');
figure
scatter(Command_avg,MAH_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('MAH_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'kuya_120_MAH.fig');
saveas(gcf,'kuya_120_MAH.eps','epsc2');
figure
scatter(Command_avg,Volt_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Volt_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'kuya_120_Volt.fig');
saveas(gcf,'kuya_120_Volt.eps','epsc2');
figure
scatter(Command_avg,Weight_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Weight_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'kuya_120_wieght.fig');
saveas(gcf,'kuya_120_wieght.eps','epsc2');


figure
scatter(Command_avg,Thrust_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Thrust_avg (N)','fontsize',font_f,'interpreter','latex')
saveas(gcf,[pwd ['kuya_120_thrust' ],'.fig']);
saveas(gcf,[pwd ['kuya_120_thrust' ],'.eps'],'epsc2');








