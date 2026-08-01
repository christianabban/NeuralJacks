clc;
clear;
close all;

%% Hodgkin-Huxley Model: Effect of Sodium Activation on the Action Potential

tspan = [0 40];
dt = 0.01;
t = tspan(1):dt:tspan(2);
N = length(t);

V0 = -65;
h0 = 0.60;
n0 = 0.32;

% Three sodium activation cases
%  FORWARD EULER
%  MODIFIED EULER
%  RUNGE-KUTTA 4
%  ODE45
[A_FE,A_BE,A_ME,A_RK,tA,A_45] = HH_solvers([V0 0.01 h0 n0],t,dt,tspan);
[B_FE,B_BE,B_ME,B_RK,tB,B_45] = HH_solvers([V0 0.05 h0 n0],t,dt,tspan);
[C_FE,C_BE,C_ME,C_RK,tC,C_45] = HH_solvers([V0 0.50 h0 n0],t,dt,tspan);

refA = interp1(tA,A_45,t,'pchip');
refB = interp1(tB,B_45,t,'pchip');
refC = interp1(tC,C_45,t,'pchip');

videoFile = 'hh_sodium_activation.mp4';
vidObj = VideoWriter(videoFile,'MPEG-4');
vidObj.FrameRate = 12;
open(vidObj);

%% first  - voltage, phase path and gate probabilities
figA = figure('Position',[100 100 1280 720]);

% Plotting sodium voltage cases
subplot(2,2,[1 2])
hold on
LA = plot(t(1),refA(1,1),'r','LineWidth',1.8);
LB = plot(t(1),refB(1,1),'b','LineWidth',1.8);
LC = plot(t(1),refC(1,1),'g','LineWidth',1.8);
yline(-55,'k--')
hold off
xlim(tspan)
ylim([-85 60])
grid on
title('Membrane Voltage Over Time')
xlabel('Time (ms)')
ylabel('mV')
legend([LA LB LC],'m_0 = 0.01','m_0 = 0.05','m_0 = 0.50','Location','eastoutside')

%  sodium phase path
subplot(2,2,3)
hold on
PA = plot(refA(1,1),refA(1,2),'r','LineWidth',1.5);
PB = plot(refB(1,1),refB(1,2),'b','LineWidth',1.5);
PC = plot(refC(1,1),refC(1,2),'g','LineWidth',1.5);
hold off
xlabel('V_m (mV)')
ylabel('m')
title('Na^+ Phase Path')
grid on
xlim([-80 55])
ylim([0 1])
axis square

%  reference gates
subplot(2,2,4)
gateBar = bar([refB(1,2) refB(1,3) refB(1,4)]);
set(gca,'XTickLabel',{'m','h','n'})
ylabel('Gate Probability')
title('Normal Case Gates: Na^+ act, Na^+ inact, K^+ act')
ylim([0 1])
grid on

sgtitle('Hodgkin-Huxley Sodium Activation')

for k = 1:40:N
    a = 1:k;
    % Updating sodium voltage cases
    set(LA,'XData',t(a),'YData',refA(a,1))
    set(LB,'XData',t(a),'YData',refB(a,1))
    set(LC,'XData',t(a),'YData',refC(a,1))
    % Updating sodium phase path
    set(PA,'XData',refA(a,1),'YData',refA(a,2))
    set(PB,'XData',refB(a,1),'YData',refB(a,2))
    set(PC,'XData',refC(a,1),'YData',refC(a,2))
    % Updating reference gates
    set(gateBar,'YData',[refB(k,2) refB(k,3) refB(k,4)])
    drawnow
    writeVideo(vidObj,getframe(figA));
end

fprintf('  animation 1 finished\n');

%% second
% figure
figB = figure('Position',[100 100 1280 720]);

% Plotting sodium activation cases
subplot(2,2,[1 2])
hold on
CA = plot(t(1),refA(1,1),'r','LineWidth',1.8);
CB = plot(t(1),refB(1,1),'b','LineWidth',1.8);
CC = plot(t(1),refC(1,1),'g','LineWidth',1.8);
yline(-55,'k--')
hold off
xlabel('Time (ms)')
ylabel('Membrane Voltage (mV)')
title('Sodium Activation Cases')
legend([CA CB CC],'m_0 = 0.01','m_0 = 0.05','m_0 = 0.50','Location','eastoutside')
grid on
xlim(tspan)
ylim([-85 60])

% Plotting solver peak comparison
subplot(2,2,3)
hold on
% Plotting Forward Euler
Z1 = plot(t(1),B_FE(1,1),'r','LineWidth',1.2);
% Plotting Backward Euler
Z2 = plot(t(1),B_BE(1,1),'b','LineWidth',1.2);
% Plotting Modified Euler
Z3 = plot(t(1),B_ME(1,1),'g','LineWidth',1.2);
% Plotting RK4
Z4 = plot(t(1),B_RK(1,1),'m','LineWidth',1.2);
% Plotting ODE45 reference
Z5 = plot(t(1),refB(1,1),'k','LineWidth',1.2);
hold off
xlim([1.6 2.8])
ylim([-45 50])
title('Normal Case Peak')
xlabel('Time (ms)')
ylabel('mV')
grid on
legend([Z1 Z2 Z3 Z4 Z5],'Forward Euler','Backward Euler','Modified Euler','RK4','ODE45','Location','southeast')

% Plotting sodium phase space
subplot(2,2,4)
hold on
SA = plot3(refA(1,1),refA(1,2),refA(1,3),'r','LineWidth',1.5);
SB = plot3(refB(1,1),refB(1,2),refB(1,3),'b','LineWidth',1.5);
SC = plot3(refC(1,1),refC(1,2),refC(1,3),'g','LineWidth',1.5);
hold off
xlabel('V_m (mV)')
ylabel('m')
zlabel('h')
title('Na^+ Phase Space')
grid on
view(-37.5,30)
xlim([-80 55])
ylim([0 1])
zlim([0 1])
legend([SA SB SC],'m_0 = 0.01','m_0 = 0.05','m_0 = 0.50','Location','eastoutside')

sgtitle('Hodgkin-Huxley Sodium Activation')

for k = 1:40:N
    a = 1:k;
    % Updating sodium activation cases
    set(CA,'XData',t(a),'YData',refA(a,1))
    set(CB,'XData',t(a),'YData',refB(a,1))
    set(CC,'XData',t(a),'YData',refC(a,1))
    % Updating solver peak comparison
    set(Z1,'XData',t(a),'YData',B_FE(a,1))
    set(Z2,'XData',t(a),'YData',B_BE(a,1))
    set(Z3,'XData',t(a),'YData',B_ME(a,1))
    set(Z4,'XData',t(a),'YData',B_RK(a,1))
    set(Z5,'XData',t(a),'YData',refB(a,1))
    % Updating sodium phase space
    set(SA,'XData',refA(a,1),'YData',refA(a,2),'ZData',refA(a,3))
    set(SB,'XData',refB(a,1),'YData',refB(a,2),'ZData',refB(a,3))
    set(SC,'XData',refC(a,1),'YData',refC(a,2),'ZData',refC(a,3))
    drawnow
    writeVideo(vidObj,getframe(figB));
end

fprintf('  animation 2 finished\n');

close(vidObj);
fprintf('Video saved as: %s\n',videoFile);
