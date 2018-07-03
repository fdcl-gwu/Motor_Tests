clear;close all;clc
%% Import text data:
% First import each text file as a numeric matrix. In matlab set "Output
% Type" as "Numeric Matrix", shown in the figure.

% Or use the following:
calib0 = import_text_data("calib_0.txt");
calib72 = import_text_data("calib_72.txt");

calib100 = import_text_data("calib_100.txt");
calib110 = import_text_data("calib_110.txt");
calib120 = import_text_data("calib_120.txt");
calib172 = import_text_data("calib_172.txt");

calib200 = import_text_data("calib_200.txt");
calib220 = import_text_data("calib_220.txt");
calib272 = import_text_data("calib_272.txt");

calib300 = import_text_data("calib_300.txt");
calib320 = import_text_data("calib_320.txt");
calib372 = import_text_data("calib_372.txt");

calib400 = import_text_data("calib_400.txt");
calib410 = import_text_data("calib_410.txt");
calib420 = import_text_data("calib_420.txt");
calib440 = import_text_data("calib_440.txt");
calib450 = import_text_data("calib_450.txt");
calib472 = import_text_data("calib_472.txt");

calib500 = import_text_data("calib_500.txt");
calib510 = import_text_data("calib_510.txt");
calib520 = import_text_data("calib_520.txt");
calib540 = import_text_data("calib_540.txt");
calib572 = import_text_data("calib_572.txt");
calib592 = import_text_data("calib_592.txt");

calib620 = import_text_data("calib_620.txt");

save all_calib_thrust_data
%% reading calibration data:
% load all_calib_thrust_data
% Do not use the first and the last parts of data 
x(1)=mean(keep_last_2000(calib0));
x(2)=mean(keep_last_2000(calib72));

x(3)=mean(keep_last_2000(calib100));%%%
x(4)=mean(keep_last_2000(calib110));%%%
x(5)=mean(keep_last_2000(calib120));%%%
x(6)=mean(keep_last_2000(calib172));%%%

x(7)=mean(keep_last_2000(calib200));
x(8)=mean(keep_last_2000(calib220));
x(9)=mean(keep_last_2000(calib272));

x(10)=mean(keep_last_2000(calib300));
x(11)=mean(keep_last_2000(calib320));
x(12)=mean(keep_last_2000(calib372));

x(13)=mean(keep_last_2000(calib400));
x(14)=mean(keep_last_2000(calib410));
x(15)=mean(keep_last_2000(calib420));
x(16)=mean(keep_last_2000(calib440));
x(17)=mean(keep_last_2000(calib450));
x(18)=mean(keep_last_2000(calib472));

x(19)=mean(keep_last_2000(calib500));
x(20)=mean(keep_last_2000(calib510));
x(21)=mean(keep_last_2000(calib520));
x(22)=mean(keep_last_2000(calib540));
x(23)=mean(keep_last_2000(calib572));
x(24)=mean(keep_last_2000(calib592));

x(25)=mean(keep_last_2000(calib620));

%% Find the relationship between reading from load cell and weights
x % reading from load cell
y=[0;72; 100;110;120;172; 200;220;272; 300;320;372; 400;410;420;440;450;472;];% 500;510;520;540;572;592; 620];% known mass (gram) on the sensor
% for this 5 masses reading is the same, so do not use them!
size(y)
mass_function = fit(x(1:18)',y,'poly1')
% mass_function = 
%      Linear model Poly1:
%      mass_function(x) = p1*x + p2
%      Coefficients (with 95% confidence bounds):
%  p1 =      0.5419  (0.4979, 0.5858)
%        p2 =      -34.53  (-68.64, -0.4185)
figure
plot(mass_function,'--',x(1:18),y','k.');
xlabel('Reading from load cell')
ylabel('Mass (gr)')
%%
arm_motor=8.5/100;
arm_load_cell=23/100;
%% Read File
filename = 'Motor_16p3.txt'%F:\FDCL Mahdis Git\Motor_Tests\tiger7_2_2018_shorter_wire\
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

Thrust_from_throttle_func = fit(Command_avg',Thrust_avg','poly2')
% Linear model Poly2:
% Coefficients (with 95% confidence bounds):
%        p1 =   0.0001604  (0.000142, 0.0001787)
%        p2 =     0.01528  (0.01209, 0.01848)
%        p3 =           0  (fixed at bound)
%OR:
%      f(x) = p1*x^2 + p2*x + p3
% Coefficients (with 95% confidence bounds):
%        p1 =   0.0002036  (0.0001897, 0.0002175)
%        p2 =    0.003627  (0.0003335, 0.00692)
%        p3 =      0.6563  (0.4919, 0.8207)

figure
plot(Thrust_from_throttle_func,'--',Command_avg,Thrust_avg,'k.');
ylabel('Thrust (N)')
xlabel('Throttle')


%>>>>>>>>>>>>>use "cftool" for the curve fitting <<<<<< 
scatter(Thrust_avg,Command_avg)
xlabel('Thrust (N)')
ylabel('Throttle')
% from cftool:
%Coefficients (with 95% confidence bounds):
a =       129.9 ;% (100.1, 159.8)
b =      0.3666 ;% (0.3092, 0.4241)
c =      -96.73 ;% (-127.8, -65.62)
Thrust_to_throttle_func = a.*Thrust_avg.^b+c;
t1= a*0^b+c
t2 = a*14^b+c


% myfittype = fittype('a + b*(Thrust_avg-c)^(1/2)',...
%      'dependent',{'Command_avg'},'independent',{'Thrust_avg'},...
%      'coefficients',{'a','b','c'},'Lower',[0,0])% 'Upper',[Inf,max(cdate)]
% myfit = fit(Thrust_avg',Command_avg',myfittype)
%scatter(Thrust_avg,[B(1)./(Thrust_avg + B(2)) + B(3)])
%hold on

% % Define ‘x’ and ‘y’ here
% % Parameter Vector: b(1) = a,  b(2) = b,  b(3) = c
% yfit = @(b,x) b(1)./(Thrust_avg + b(2)) + b(3);  % Objective Function
% CF = @(b) sum((Command_avg-yfit(b,Thrust_avg)).^2);        % Cost Function
% b0 = rand(1,3)*10;                      % Initial Parameter Estimates
% [B, fv] = fminsearch(CF, b0);           % Estimate Parameters
% B(1)./(Thrust_avg + B(2))+ B(3)

% scatter(Thrust_avg,[B(1)./(Thrust_avg + B(2)) + B(3)])
% hold on


% Thrust_throttle_func = fit(Thrust_avg',Command_avg','smoothingspline')
% Thrust_throttle_func
% figure
% plot(Thrust_throttle_func,'--',Thrust_avg,Command_avg,'k.');
% ylabel('Throttle')
% xlabel('Thrust (N)')

% p1=-1.784;p2=38.45;p3=6.359;
% for i=1:size(Thrust_avg,2)
%     Command_avg_14p8(i)=p1*Thrust_avg(i)^2 + p2*Thrust_avg(i) + p3;
% end
% hold on
% scatter(Thrust_avg,Command_avg_14p8,'r');
% legend('Experimental data (16.2V)', 'fitted curve (16.2V)', 'function (14.8 V)')
%%
% to save in diffrent folder saveas(gcf,[pwd
% ['Motor1_114_Current' ],'.fig']); and
% saveas(gcf,[pwd ['Motor1_120_Current' ],'.eps'],'epsc2');
figure
AxesFont_f=16;font_f=16;
set(gcf,'DefaultAxesFontSize',AxesFont_f);

Power_avg=Volt_avg.*Current_avg;
scatter(Command_avg,Power_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Power_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,'C_tau_148Powerfig');
saveas(gcf,'C_tau_148Power','epsc2');

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