clear;close all;clc
%% calibrate:
load thrusts_data 
w=RPM_avg;% 
V=Volt_avg;
C=Current_avg;

load torques_data
Thrust=Thrust_avg;
Torque=Torque_avg;
AxesFont_f=16;font_f=16;
[fitresult, gof] = createFit_Q_w_i(w, C, Torque)% w must be in Hz

[fitresult, gof] = createFit_V_w_i(w, C, V)


size(Thrust_avg)
size(Torque_avg)
Torque_thrust_function = fit(Thrust_avg',Torque_avg','poly1')
figure
set(gcf,'DefaultAxesFontSize',AxesFont_f);
plot(Torque_thrust_function,'--',Thrust_avg,Torque_avg','k.');
xlabel('Thrust (N)','interpreter','latex')
ylabel('Torque (Nm)','interpreter','latex')


Torque_w_function = fit(w',Torque_avg','poly2')
figure
set(gcf,'DefaultAxesFontSize',AxesFont_f);
plot(Torque_w_function,'--',w,Torque_avg','k.');
xlabel('Rotational speed (rpm)','interpreter','latex')
ylabel('Torque (Nm)','interpreter','latex')
%% Data from motor manual:
% T_avg_manual=[4.508;6.958;8.526;10.584;12.054];
% Torque_avg_manual=[0.08;0.13;0.15;0.19;0.21];
% Torque_thrust_function_manual = fit(T_avg_manual,Torque_avg_manual,'poly1')
% %figure
% hold on
% plot(Torque_thrust_function_manual,'-- r.',T_avg_manual,Torque_avg_manual','r.');
% xlabel('Thrust avg (N)')
% ylabel('Torque avg (Nm)')
% legend('Test data','Test fit','Manual data','Manual fit')
%title('From motor manual')
%% Plot for mour test
% font_f=16;
% figure
% scatter(Command_avg,Thrust_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('Thrust_avg (N)','fontsize',font_f,'interpreter','latex')
% saveas(gcf,[pwd ['C_tau_148thrust' ],'.fig']);
% saveas(gcf,[pwd ['C_tau_148thrust' ],'.eps'],'epsc2');
% 
% figure
% scatter(Command_avg,Torque_avg)
% xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
% ylabel('Torque_avg (Nm)','fontsize',font_f,'interpreter','latex')
% saveas(gcf,[pwd ['C_tau_148torque' ],'.fig']);
% saveas(gcf,[pwd ['C_tau_148torque' ],'.eps'],'epsc2');
% 
% figure
% scatter(Thrust_avg,Torque_avg)
% xlabel('Thrust_avg (N)','fontsize',font_f,'interpreter','latex');
% ylabel('Torque_avg (Nm)','fontsize',font_f,'interpreter','latex')
% saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.fig']);
% saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.eps'],'epsc2');
% 
% 
% figure
% scatter(Command_avg,Torque_avg./Thrust_avg)
% xlabel('Command_avg ','fontsize',font_f,'interpreter','latex');
% ylabel('Torque_avg/Thrust_avg','fontsize',font_f,'interpreter','latex')
% saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.fig']);
% saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.eps'],'epsc2');

