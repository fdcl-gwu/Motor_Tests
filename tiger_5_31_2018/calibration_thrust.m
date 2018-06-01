clear;close all;clc
%% calibrate:
load thrusts_data 
load torques_data

size(Thrust_avg)
size(Torque_avg)
Torque_thrust_function = fit(Thrust_avg',Torque_avg','poly1')
figure
plot(Torque_thrust_function,'--',Thrust_avg,Torque_avg','k.');
xlabel('Thrust avg (N)')
ylabel('Torque avg (Nm)')

font_f=16;
figure
scatter(Command_avg,Thrust_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Thrust_avg (N)','fontsize',font_f,'interpreter','latex')
saveas(gcf,[pwd ['C_tau_148thrust' ],'.fig']);
saveas(gcf,[pwd ['C_tau_148thrust' ],'.eps'],'epsc2');

figure
scatter(Command_avg,Torque_avg)
xlabel('Command_avg','fontsize',font_f,'interpreter','latex');
ylabel('Torque_avg (Nm)','fontsize',font_f,'interpreter','latex')
saveas(gcf,[pwd ['C_tau_148torque' ],'.fig']);
saveas(gcf,[pwd ['C_tau_148torque' ],'.eps'],'epsc2');

figure
scatter(Thrust_avg,Torque_avg)
xlabel('Thrust_avg (N)','fontsize',font_f,'interpreter','latex');
ylabel('Torque_avg (Nm)','fontsize',font_f,'interpreter','latex')
saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.fig']);
saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.eps'],'epsc2');


figure
scatter(Command_avg,Torque_avg./Thrust_avg)
xlabel('Command_avg ','fontsize',font_f,'interpreter','latex');
ylabel('Torque_avg/Thrust_avg','fontsize',font_f,'interpreter','latex')
saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.fig']);
saveas(gcf,[pwd ['C_tau_148torquethrust' ],'.eps'],'epsc2');


T_avg_manual=[4.508;6.958;8.526;10.584;12.054];
Torque_avg_manual=[0.08;0.13;0.15;0.19;0.21];
Torque_thrust_function_manual = fit(T_avg_manual,Torque_avg_manual,'poly1')
figure
plot(Torque_thrust_function_manual,'--',T_avg_manual,Torque_avg_manual','k.');
xlabel('Thrust avg (N)')
ylabel('Torque avg (Nm)')