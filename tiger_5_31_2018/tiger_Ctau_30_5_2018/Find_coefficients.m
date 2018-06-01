function Find_coefficients
clc;close all;clear
% Here the files relation between motor command and thrust for diffrent
% voltages are computed. 
motor_num=1;
load 'kuya_120' Thrust_avg Command_avg
Thrust_avg1_111=Thrust_avg;
Command_avg1_111=Command_avg;
volt_value=111;
whos  Thrust_avg1_111 
whos Command_avg1_111
command_kuya=-1.051.*Thrust_avg1_111.^2+31.65.*Thrust_avg1_111+15.98;
curvekuya=find_poly(Command_avg1_111,Thrust_avg1_111,motor_num,volt_value,command_kuya)

curve1_111=find_poly(Command_avg1_111,Thrust_avg1_111,motor_num,volt_value,command_kuya)       


load 'Motor1_114' Thrust_avg Command_avg
Thrust_avg1_114=Thrust_avg;
Command_avg1_114=Command_avg;
volt_value=114;
curve1_114=find_poly(Command_avg1_114,Thrust_avg1_114,motor_num,volt_value)


load 'Motor1_117' Thrust_avg Command_avg
Thrust_avg1_117=Thrust_avg;
Command_avg1_117=Command_avg;
volt_value=117;
curve1_117=find_poly(Command_avg1_117,Thrust_avg1_117,motor_num,volt_value)

load 'Motor1_120' Thrust_avg Command_avg
Thrust_avg1_120=Thrust_avg;
Command_avg1_120=Command_avg;
volt_value=120;
curve1_120=find_poly(Command_avg1_120,Thrust_avg1_120,motor_num,volt_value)

load 'Motor1_123' Thrust_avg Command_avg
Thrust_avg1_123=Thrust_avg;
Command_avg1_123=Command_avg;
volt_value=123;
curve1_123=find_poly(Command_avg1_123,Thrust_avg1_123,motor_num,volt_value)

load 'Motor1_126' Thrust_avg Command_avg
Thrust_avg1_126=Thrust_avg;
Command_avg1_126=Command_avg;
volt_value=126;
curve1_126=find_poly(Command_avg1_126,Thrust_avg1_126,motor_num,volt_value)
%%
motor_num=2;volt_value=1;
load 'Motor2_111' Thrust_avg Command_avg
Thrust_avg2_111=Thrust_avg;
Command_avg2_111=Command_avg;
volt_value=111;
curve2_111=find_poly(Command_avg2_111,Thrust_avg2_111,motor_num,volt_value)

load 'Motor2_114' Thrust_avg Command_avg
Thrust_avg2_114=Thrust_avg;
Command_avg2_114=Command_avg;
volt_value=114;
curve2_114=find_poly(Command_avg2_114,Thrust_avg2_114,motor_num,volt_value)

load 'Motor2_117' Thrust_avg Command_avg
Thrust_avg2_117=Thrust_avg;
Command_avg2_117=Command_avg;
volt_value=117;
curve2_117=find_poly(Command_avg2_117,Thrust_avg2_117,motor_num,volt_value)

load 'Motor2_120' Thrust_avg Command_avg
Thrust_avg2_120=Thrust_avg;
Command_avg2_120=Command_avg;
volt_value=120;
curve2_120=find_poly(Command_avg2_120,Thrust_avg2_120,motor_num,volt_value)

load 'Motor2_123' Thrust_avg Command_avg
Thrust_avg2_123=Thrust_avg;
Command_avg2_123=Command_avg;
volt_value=123;
curve2_123=find_poly(Command_avg2_123,Thrust_avg2_123,motor_num,volt_value)

load 'Motor2_126' Thrust_avg Command_avg
Thrust_avg2_126=Thrust_avg;
Command_avg2_126=Command_avg;
volt_value=126;
curve2_126=find_poly(Command_avg2_126,Thrust_avg2_126,motor_num,volt_value)
%%
motor_num=3;volt_value=1;
load 'Motor3_111' Thrust_avg Command_avg
Thrust_avg3_111=Thrust_avg;
Command_avg3_111=Command_avg;
volt_value=111;
curve3_111=find_poly(Command_avg3_111,Thrust_avg3_111,motor_num,volt_value)

load 'Motor3_114' Thrust_avg Command_avg
Thrust_avg3_114=Thrust_avg;
Command_avg3_114=Command_avg;
volt_value=114;
curve3_114=find_poly(Command_avg3_114,Thrust_avg3_114,motor_num,volt_value)

load 'Motor3_117' Thrust_avg Command_avg
Thrust_avg3_117=Thrust_avg;
Command_avg3_117=Command_avg;
volt_value=117;
curve3_117=find_poly(Command_avg3_117,Thrust_avg3_117,motor_num,volt_value)

load 'Motor3_120' Thrust_avg Command_avg
Thrust_avg3_120=Thrust_avg;
Command_avg3_120=Command_avg;
volt_value=120;
curve3_120=find_poly(Command_avg3_120,Thrust_avg3_120,motor_num,volt_value)

load 'Motor3_123' Thrust_avg Command_avg
Thrust_avg3_123=Thrust_avg;
Command_avg3_123=Command_avg;
volt_value=123;
curve3_123=find_poly(Command_avg3_123,Thrust_avg3_123,motor_num,volt_value)

load 'Motor3_126' Thrust_avg Command_avg
Thrust_avg3_126=Thrust_avg;
Command_avg3_126=Command_avg;
volt_value=126;
curve3_126=find_poly(Command_avg3_126,Thrust_avg3_126,motor_num,volt_value)
%%
motor_num=4;volt_value=1;
load 'Motor4_111' Thrust_avg Command_avg
Thrust_avg4_111=Thrust_avg;
Command_avg4_111=Command_avg;
volt_value=111;
curve4_111=find_poly(Command_avg4_111,Thrust_avg4_111,motor_num,volt_value)

load 'Motor4_114' Thrust_avg Command_avg
Thrust_avg4_114=Thrust_avg;
Command_avg4_114=Command_avg;
volt_value=114;
curve4_114=find_poly(Command_avg4_114,Thrust_avg4_114,motor_num,volt_value)

load 'Motor4_117' Thrust_avg Command_avg
Thrust_avg4_117=Thrust_avg;
Command_avg4_117=Command_avg;
volt_value=117;
curve4_117=find_poly(Command_avg4_117,Thrust_avg4_117,motor_num,volt_value)

load 'Motor4_120' Thrust_avg Command_avg
Thrust_avg4_120=Thrust_avg;
Command_avg4_120=Command_avg;
volt_value=120;
curve4_120=find_poly(Command_avg4_120,Thrust_avg4_120,motor_num,volt_value)

load 'Motor4_123' Thrust_avg Command_avg
Thrust_avg4_123=Thrust_avg;
Command_avg4_123=Command_avg;
volt_value=123;
curve4_123=find_poly(Command_avg4_123,Thrust_avg4_123,motor_num,volt_value)

load 'Motor4_126' Thrust_avg Command_avg
Thrust_avg4_126=Thrust_avg;
Command_avg4_126=Command_avg;
volt_value=126;
curve4_126=find_poly(Command_avg4_126,Thrust_avg4_126,motor_num,volt_value)
save Thrust_command_funcs curve1_111 curve1_114 curve1_117 curve1_120 curve1_123 curve1_126 ...
curve2_111 curve2_114 curve2_117 curve2_120 curve2_123 curve2_126 ...
curve3_111 curve3_114 curve3_117 curve3_120 curve3_123 curve3_126 ...
curve4_111 curve4_114 curve4_117 curve4_120 curve4_123 curve4_126
end
function curve_kuya=find_poly(Command_avg,Thrust_avg,motor_num,volt_value,command_kuya)
%Thrust_avg=cell2mat(Thrust_avg);
[curve] = fit(Command_avg',Thrust_avg','poly2');
[curve_kuya] = fit(Thrust_avg',Command_avg','poly2');
if volt_value==111
    figure
end
if motor_num==1
%     hold on
%     plot(curve,'--',Command_avg',Thrust_avg','k.');
%     xlabel('Average command');
%     ylabel('Average thrust');
%     title('Motor 1')
%     if volt_value==126
%         legend('111 v','111 v','114 v','114 v','117 v','117 v', '120 v','120 v', '123 v','123 v', '126v','126v')
%     saveas(gcf,[pwd ['/figures-coef/Motor1' ],'.fig']);
%     saveas(gcf,[pwd ['/figures-coef/Motor1' ],'.eps'],'epsc2');
%     end
    figure
    plot(curve_kuya,'--',Thrust_avg',Command_avg','k.');
    hold on
    plot(Thrust_avg,command_kuya)
elseif motor_num==2
    hold on
    plot(curve,'--',Command_avg',Thrust_avg','k.');
    xlabel('Average command');
    ylabel('Average thrust');
    title('Motor 2')
    if volt_value==126
        legend('111 v','111 v','114 v','114 v','117 v','117 v', '120 v','120 v', '123 v','123 v', '126v','126v')
    saveas(gcf,[pwd ['/figures-coef/Motor2' ],'.fig']);
    saveas(gcf,[pwd ['/figures-coef/Motor2' ],'.eps'],'epsc2');
    end
    
elseif motor_num==3
    hold on
    plot(curve,'--',Command_avg',Thrust_avg','k.');
    xlabel('Average command');
    ylabel('Average thrust');
    title('Motor 3')
    if volt_value==126
        legend('111 v','111 v','114 v','114 v','117 v','117 v', '120 v','120 v', '123 v','123 v', '126v','126v')
    saveas(gcf,[pwd ['/figures-coef/Motor3' ],'.fig']);
    saveas(gcf,[pwd ['/figures-coef/Motor3' ],'.eps'],'epsc2');
    end
    
elseif motor_num==4
    hold on
    plot(curve,'--',Command_avg',Thrust_avg','k.');
    xlabel('Average command');
    ylabel('Average thrust');
    title('Motor 4')
    if volt_value==126
        legend('111 v','111 v','114 v','114 v','117 v','117 v', '120 v','120 v', '123 v','123 v', '126v','126v')
    
    saveas(gcf,[pwd ['/figures-coef/Motor4' ],'.fig']);
    saveas(gcf,[pwd ['/figures-coef/Motor4' ],'.eps'],'epsc2');
    end
end

end
