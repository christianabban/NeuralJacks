clc;
clear;
close all;

%% Initial Values: when the neuron is at normal state
V0 = -70;
%gate variables
m0 = 0.05;
h0 = 0.60;
n0 = 0.32;
y0 = [V0 m0 h0 n0];

%% Euler method for voltage-time plots
dt = 0.05;
t = 0:dt:50;
[t45,y45] = ode45(@HHmodel,t,y0);
V = y45(:,1);
m = y45(:,2);
h = y45(:,3);
n = y45(:,4);

%% parameter sensitivty analysis - m, n, h
%values
values = [0.01 0.50 0.99];
names = {'m','h','n'};
titles = {'Na^+ Activation','Na^+ Inactivation','K^+ Activation'};
cols = [0.00 0.42 0.75; 0.85 0.20 0.12; 0.12 0.58 0.25];

% Sensitivity analysis for m
[~,ym1] = ode45(@HHmodel,t,[V0 0.01 h0 n0]);
[~,ym2] = ode45(@HHmodel,t,[V0 0.50 h0 n0]);
[~,ym3] = ode45(@HHmodel,t,[V0 0.99 h0 n0]);

% Sensitivity analysis for h
[~,yh1] = ode45(@HHmodel,t,[V0 m0 0.01 n0]);
[~,yh2] = ode45(@HHmodel,t,[V0 m0 0.50 n0]);
[~,yh3] = ode45(@HHmodel,t,[V0 m0 0.99 n0]);

% Sensitivity analysis for n
[~,yn1] = ode45(@HHmodel,t,[V0 m0 h0 0.01]);
[~,yn2] = ode45(@HHmodel,t,[V0 m0 h0 0.50]);
[~,yn3] = ode45(@HHmodel,t,[V0 m0 h0 0.99]);

Vm1 = ym1(:,1); Vm2 = ym2(:,1); Vm3 = ym3(:,1);
Vh1 = yh1(:,1); Vh2 = yh2(:,1); Vh3 = yh3(:,1);
Vn1 = yn1(:,1); Vn2 = yn2(:,1); Vn3 = yn3(:,1);

videoFile = 'hh_parameter_sensitivity.mp4';
vidObj = VideoWriter(videoFile,'MPEG-4');
vidObj.FrameRate = 12;
open(vidObj);

%% FIGURE 1 - gate value sensitivity
figA = figure('Position',[100 100 1280 720]);

% Plotting reference voltage
subplot(4,1,1)
refLine = plot(t(1),V(1),'k','LineWidth',2);
hold on
yline(-55,'r--','Threshold')
yline(V0,'b--','Resting')
hold off
xlim([0 50])
ylim([-85 60])
grid on
title('Reference Action Potential')
ylabel('Voltage (mV)')

% Plotting m sensitivity
subplot(4,1,2)
hold on
Lm1 = plot(t(1),Vm1(1),'LineWidth',1.5);
Lm2 = plot(t(1),Vm2(1),'LineWidth',1.5);
Lm3 = plot(t(1),Vm3(1),'LineWidth',1.5);
yline(-55,'k--')
hold off
xlim([0 50]); ylim([-85 60]); grid on
title('Varying m - Na^+ Activation')
ylabel('Voltage (mV)')
legend('m = 0.01','m = 0.5','m = 0.99','Location','eastoutside')

% Plotting h sensitivity
subplot(4,1,3)
hold on
Lh1 = plot(t(1),Vh1(1),'LineWidth',1.5);
Lh2 = plot(t(1),Vh2(1),'LineWidth',1.5);
Lh3 = plot(t(1),Vh3(1),'LineWidth',1.5);
yline(-55,'k--')
hold off
xlim([0 50]); ylim([-85 60]); grid on
title('Varying h - Na^+ Inactivation')
ylabel('Voltage (mV)')
legend('h = 0.01','h = 0.5','h = 0.99','Location','eastoutside')

% Plotting n sensitivity
subplot(4,1,4)
hold on
Ln1 = plot(t(1),Vn1(1),'LineWidth',1.5);
Ln2 = plot(t(1),Vn2(1),'LineWidth',1.5);
Ln3 = plot(t(1),Vn3(1),'LineWidth',1.5);
yline(-55,'k--')
hold off
xlim([0 50]); ylim([-85 60]); grid on
title('Varying n - K^+ Activation')
ylabel('Voltage (mV)')
xlabel('Time (ms)')
legend('n = 0.01','n = 0.5','n = 0.99','Location','eastoutside')

sgtitle('Reference Action Potential and Initial Gate Value Sensitivity')

for k = 1:16:length(t)
    a = 1:k;
    % Updating reference voltage
    set(refLine,'XData',t(a),'YData',V(a))
    % Updating m sensitivity
    set(Lm1,'XData',t(a),'YData',Vm1(a))
    set(Lm2,'XData',t(a),'YData',Vm2(a))
    set(Lm3,'XData',t(a),'YData',Vm3(a))
    % Updating h sensitivity
    set(Lh1,'XData',t(a),'YData',Vh1(a))
    set(Lh2,'XData',t(a),'YData',Vh2(a))
    set(Lh3,'XData',t(a),'YData',Vh3(a))
    % Updating n sensitivity
    set(Ln1,'XData',t(a),'YData',Vn1(a))
    set(Ln2,'XData',t(a),'YData',Vn2(a))
    set(Ln3,'XData',t(a),'YData',Vn3(a))
    drawnow
    writeVideo(vidObj,getframe(figA));
end

fprintf('  figure 1 animation finished\n');

%% visualisations
%% figure 2
figB = figure('Position',[100 100 1280 720]);

%  reference voltage
subplot(2,2,[1 2])
refB = plot(t(1),V(1),'k','LineWidth',2);
hold on
yline(-55,'r--','Threshold')
yline(V0,'b--','Resting')
hold off
xlabel('Time (ms)')
ylabel('Membrane Voltage (mV)')
title('Reference Action Potential')
grid on
xlim([0 50])
ylim([-85 60])

%  gate dynamics
subplot(2,2,3)
hold on
gm = plot(t(1),m(1),'LineWidth',1.5);
gh = plot(t(1),h(1),'LineWidth',1.5);
gn = plot(t(1),n(1),'LineWidth',1.5);
hold off
xlabel('Time (ms)')
ylabel('Gate Probability')
title('Gate Dynamics')
legend('m','h','n','Location','east')
grid on
xlim([0 50])
ylim([0 1])

%  gate bar chart
subplot(2,2,4)
barPlot = bar([m(1) h(1) n(1)]);
set(gca,'XTickLabel',{'m','h','n'})
ylabel('Gate Probability')
title('Gate Probabilities: Na^+ act, Na^+ inact, K^+ act')
grid on
ylim([0 1])

sgtitle('Hodgkin-Huxley Parameter Sensitivity')

for k = 1:16:length(t)
    a = 1:k;
    % Updating reference voltage
    set(refB,'XData',t(a),'YData',V(a))
    % Updating gate dynamics
    set(gm,'XData',t(a),'YData',m(a))
    set(gh,'XData',t(a),'YData',h(a))
    set(gn,'XData',t(a),'YData',n(a))
    % Updating gate bar chart
    set(barPlot,'YData',[m(k) h(k) n(k)])
    drawnow
    writeVideo(vidObj,getframe(figB));
end

fprintf('  figure 2 animation finished\n');

%% figure 3
figC = figure('Position',[100 100 1280 720]);

% Plotting m sensitivity
subplot(3,1,1)
hold on
Dm1 = plot(t(1),Vm1(1),'LineWidth',1.5);
Dm2 = plot(t(1),Vm2(1),'LineWidth',1.5);
Dm3 = plot(t(1),Vm3(1),'LineWidth',1.5);
yline(-55,'k--')
hold off
title('Varying m - Na^+ Activation')
ylabel('Voltage (mV)')
grid on
xlim([0 50]); ylim([-85 60])
legend('m = 0.01','m = 0.5','m = 0.99','Location','eastoutside')

% Plotting h sensitivity
subplot(3,1,2)
hold on
Dh1 = plot(t(1),Vh1(1),'LineWidth',1.5);
Dh2 = plot(t(1),Vh2(1),'LineWidth',1.5);
Dh3 = plot(t(1),Vh3(1),'LineWidth',1.5);
yline(-55,'k--')
hold off
title('Varying h - Na^+ Inactivation')
ylabel('Voltage (mV)')
grid on
xlim([0 50]); ylim([-85 60])
legend('h = 0.01','h = 0.5','h = 0.99','Location','eastoutside')

% Plotting n sensitivity
subplot(3,1,3)
hold on
Dn1 = plot(t(1),Vn1(1),'LineWidth',1.5);
Dn2 = plot(t(1),Vn2(1),'LineWidth',1.5);
Dn3 = plot(t(1),Vn3(1),'LineWidth',1.5);
yline(-55,'k--')
hold off
title('Varying n - K^+ Activation')
ylabel('Voltage (mV)')
xlabel('Time (ms)')
grid on
xlim([0 50]); ylim([-85 60])
legend('n = 0.01','n = 0.5','n = 0.99','Location','eastoutside')

sgtitle('Initial Gate Value Sensitivity')

for k = 1:16:length(t)
    a = 1:k;
    % Updating m sensitivity
    set(Dm1,'XData',t(a),'YData',Vm1(a))
    set(Dm2,'XData',t(a),'YData',Vm2(a))
    set(Dm3,'XData',t(a),'YData',Vm3(a))
    %  h sensitivity
    set(Dh1,'XData',t(a),'YData',Vh1(a))
    set(Dh2,'XData',t(a),'YData',Vh2(a))
    set(Dh3,'XData',t(a),'YData',Vh3(a))
    %  n sensitivity
    set(Dn1,'XData',t(a),'YData',Vn1(a))
    set(Dn2,'XData',t(a),'YData',Vn2(a))
    set(Dn3,'XData',t(a),'YData',Vn3(a))
    drawnow
    writeVideo(vidObj,getframe(figC));
end

fprintf('  figure 3 animation finished\n');
close(vidObj);
fprintf('Video saved as: %s\n',videoFile);
