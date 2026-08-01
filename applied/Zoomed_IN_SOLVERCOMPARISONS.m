clc;
clear;
close all;

%% INITIAL CONDITIONS
V0 = -70;
m0 = 0.05;
h0 = 0.60;
n0 = 0.32;
y0 = [V0 m0 h0 n0];

dt = 0.01;
Tend = 50;
t = 0:dt:Tend;
N = length(t);

%% ODE45 SOLUTION
[y_FE,y_BE,y_ME,y_RK,t45,y45] = HH_solvers(y0,t,dt,[0 Tend]);

V_FE = y_FE(:,1);
V_BE = y_BE(:,1);
V_ME = y_ME(:,1);
V_RK = y_RK(:,1);
V_45 = interp1(t45,y45(:,1),t,'pchip')';

% zoom windows, matched to the boxes drawn on the full trace
peak_box = [2.0 -45 1.2 95];
trough_box = [4.5 -78 2.0 35];

%% COMPARISON PLOT
fig = figure('Position',[100 100 1280 720]);

videoFile = 'hh_solver_comparison_zoomed.mp4';
vidObj = VideoWriter(videoFile,'MPEG-4');
vidObj.FrameRate = 12;
open(vidObj);

for k = 1:50:N
    a = 1:k;
    % Plotting full solver comparison
    subplot(2,2,[1 2])
    % Plotting Forward Euler
    plot(t(a),V_FE(a),'r','LineWidth',1.4)
    hold on
    % Plotting Backward Euler
    plot(t(a),V_BE(a),'b','LineWidth',1.4)
    %  Modified Euler
    plot(t(a),V_ME(a),'g','LineWidth',1.4)
    %  RK4
    plot(t(a),V_RK(a),'m','LineWidth',1.4)
    %  ODE45 reference
    plot(t(a),V_45(a),'k','LineWidth',1.4)
    yline(-55,'k--')
    rectangle('Position',peak_box,'LineStyle','--')
    rectangle('Position',trough_box,'LineStyle','--')
    hold off
    xlabel('Time (ms)')
    ylabel('Membrane Voltage (mV)')
    title('Action Potential Solver Comparison')
    legend('Forward Euler','Backward Euler','Modified Euler','Runge Kutta 4','ODE45','Location','eastoutside')
    grid on
    xlim([0 Tend])
    ylim([-85 60])

    %spike peak zoom
    subplot(2,2,3)
    % Plotting Forward Euler
    plot(t(a),V_FE(a),'r','LineWidth',1.4)
    hold on
    % Plotting Backward Euler
    plot(t(a),V_BE(a),'b','LineWidth',1.4)
    % Plotting Modified Euler
    plot(t(a),V_ME(a),'g','LineWidth',1.4)
    % Plotting RK4
    plot(t(a),V_RK(a),'m','LineWidth',1.4)
    % Plotting ODE45 reference
    plot(t(a),V_45(a),'k','LineWidth',1.4)
    hold off
    xlim([2.0 3.2])
    ylim([-45 50])
    title('Spike Peak')
    xlabel('Time (ms)')
    ylabel('mV')
    grid on

    %  trough zoom
    subplot(2,2,4)
    % Plotting Forward Euler
    plot(t(a),V_FE(a),'r','LineWidth',1.4)
    hold on
    % Plotting Backward Euler
    plot(t(a),V_BE(a),'b','LineWidth',1.4)
    % Plotting Modified Euler
    plot(t(a),V_ME(a),'g','LineWidth',1.4)
    % Plotting RK4
    plot(t(a),V_RK(a),'m','LineWidth',1.4)
    % Plotting ODE45 reference
    plot(t(a),V_45(a),'k','LineWidth',1.4)
    hold off
    xlim([4.5 6.5])
    ylim([-78 -43])
    title('Repolarisation Trough')
    xlabel('Time (ms)')
    ylabel('mV')
    grid on

    sgtitle('Hodgkin-Huxley Numerical Solver Behaviour')
    drawnow
    writeVideo(vidObj,getframe(fig));
end

close(vidObj);
fprintf('Video saved as: %s\n',videoFile);
