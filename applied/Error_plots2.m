clc;
clear;
close all;

%% HH Potassium Activation error plots

tspan = [0 40];
dt = 0.01;
t = tspan(1):dt:tspan(2);
N = length(t);

V0 = -65;
m0 = 0.05;
h0 = 0.60;
% Solver colours
floor_val = 1e-6;

% Forward Euler
% Backward Euler
% Modified Euler
% RK4
% ODE45 as the reference

[A_FE,A_BE,A_ME,A_RK,tA,A_45] = HH_solvers([V0 m0 h0 0.05],t,dt,tspan);
[B_FE,B_BE,B_ME,B_RK,tB,B_45] = HH_solvers([V0 m0 h0 0.32],t,dt,tspan);
[C_FE,C_BE,C_ME,C_RK,tC,C_45] = HH_solvers([V0 m0 h0 0.80],t,dt,tspan);

RefA = interp1(tA,A_45(:,1),t,'pchip');
RefB = interp1(tB,B_45(:,1),t,'pchip');
RefC = interp1(tC,C_45(:,1),t,'pchip');

A1 = max(abs(A_FE(:,1)' - RefA),floor_val);
A2 = max(abs(A_BE(:,1)' - RefA),floor_val);
A3 = max(abs(A_ME(:,1)' - RefA),floor_val);
A4 = max(abs(A_RK(:,1)' - RefA),floor_val);

B1 = max(abs(B_FE(:,1)' - RefB),floor_val);
B2 = max(abs(B_BE(:,1)' - RefB),floor_val);
B3 = max(abs(B_ME(:,1)' - RefB),floor_val);
B4 = max(abs(B_RK(:,1)' - RefB),floor_val);

C1 = max(abs(C_FE(:,1)' - RefC),floor_val);
C2 = max(abs(C_BE(:,1)' - RefC),floor_val);
C3 = max(abs(C_ME(:,1)' - RefC),floor_val);
C4 = max(abs(C_RK(:,1)' - RefC),floor_val);

%   All three cases 
figure('Position',[100 100 1280 720]);

% Plotting Forward Euler error
subplot(3,4,1)
fill([t fliplr(t)],[log10(A1) -6*ones(1,N)],'r','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(A1),'r','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
title('Forward Euler')
ylabel({'n_0 = 0.05','log_{10}|Error|'})

% Plotting Backward Euler error
subplot(3,4,2)
fill([t fliplr(t)],[log10(A2) -6*ones(1,N)],'b','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(A2),'b','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
title('Backward Euler')

% Plotting Modified Euler error
subplot(3,4,3)
fill([t fliplr(t)],[log10(A3) -6*ones(1,N)],'g','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(A3),'g','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
title('Modified Euler')

% Plotting RK4 error
subplot(3,4,4)
fill([t fliplr(t)],[log10(A4) -6*ones(1,N)],'m','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(A4),'m','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
title('RK4')

% Plotting Forward Euler error
subplot(3,4,5)
fill([t fliplr(t)],[log10(B1) -6*ones(1,N)],'r','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(B1),'r','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
ylabel({'n_0 = 0.32','log_{10}|Error|'})

% Plotting Backward Euler error
subplot(3,4,6)
fill([t fliplr(t)],[log10(B2) -6*ones(1,N)],'b','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(B2),'b','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on

% Plotting Modified Euler error
subplot(3,4,7)
fill([t fliplr(t)],[log10(B3) -6*ones(1,N)],'g','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(B3),'g','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on

% Plotting RK4 error
subplot(3,4,8)
fill([t fliplr(t)],[log10(B4) -6*ones(1,N)],'m','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(B4),'m','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on

% Plotting Forward Euler error
subplot(3,4,9)
fill([t fliplr(t)],[log10(C1) -6*ones(1,N)],'r','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(C1),'r','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
ylabel({'n_0 = 0.80','log_{10}|Error|'})
xlabel('Time (ms)')

% Plotting Backward Euler error
subplot(3,4,10)
fill([t fliplr(t)],[log10(C2) -6*ones(1,N)],'b','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(C2),'b','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
xlabel('Time (ms)')

% Plotting Modified Euler error
subplot(3,4,11)
fill([t fliplr(t)],[log10(C3) -6*ones(1,N)],'g','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(C3),'g','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
xlabel('Time (ms)')

% Plotting RK4 error
subplot(3,4,12)
fill([t fliplr(t)],[log10(C4) -6*ones(1,N)],'m','FaceAlpha',0.25,'EdgeColor','none')
hold on
plot(t,log10(C4),'m','LineWidth',1.2)
hold off
ylim([-6 2]); xlim(tspan); grid on
xlabel('Time (ms)')

sgtitle('Hodgkin-Huxley Error Grid')

figure('Position',[100 100 1280 720]);

% Plotting reduced K reference and errors
subplot(3,2,1)
plot(t,RefA,'k','LineWidth',1.5)
yyaxis right
plot(t,log10(A1),'r')
hold on
plot(t,log10(A2),'b')
plot(t,log10(A3),'g')
plot(t,log10(A4),'m')
hold off
ylabel('log_{10}|Error|'); ylim([-6 2])
yyaxis left
ylabel('V_m (mV)'); ylim([-85 60]); xlim(tspan); grid on
title('Reduced K^+ Activation')

%Plotting reduced K error map
subplot(3,2,2)
imagesc(t,1:4,[log10(A1);log10(A2);log10(A3);log10(A4)])
axis normal
colormap turbo; caxis([-6 2]); colorbar
set(gca,'YTick',1:4,'YTickLabel',{'FE','BE','ME','RK4'})
title('n_0 = 0.05 Error Map')

%Plotting normal K reference and errors
subplot(3,2,3)
plot(t,RefB,'k','LineWidth',1.5)
yyaxis right
plot(t,log10(B1),'r')
hold on
plot(t,log10(B2),'b')
plot(t,log10(B3),'g')
plot(t,log10(B4),'m')
hold off
ylabel('log_{10}|Error|'); ylim([-6 2])
yyaxis left
ylabel('V_m (mV)'); ylim([-85 60]); xlim(tspan); grid on
title('Normal K^+ Activation')

%Plotting normal K error map
subplot(3,2,4)
imagesc(t,1:4,[log10(B1);log10(B2);log10(B3);log10(B4)])
axis normal
caxis([-6 2]); colorbar
set(gca,'YTick',1:4,'YTickLabel',{'FE','BE','ME','RK4'})
title('n_0 = 0.32 Error Map')

% Plotting excessive K reference and errors
subplot(3,2,5)
plot(t,RefC,'k','LineWidth',1.5)
yyaxis right
plot(t,log10(C1),'r')
hold on
plot(t,log10(C2),'b')
plot(t,log10(C3),'g')
plot(t,log10(C4),'m')
hold off
ylabel('log_{10}|Error|'); ylim([-6 2])
yyaxis left
ylabel('V_m (mV)'); ylim([-85 60]); xlim(tspan); grid on
title('Excessive K^+ Activation')
xlabel('Time (ms)')

% Plotting excessive K error map
subplot(3,2,6)
imagesc(t,1:4,[log10(C1);log10(C2);log10(C3);log10(C4)])
axis normal
caxis([-6 2]); colorbar
set(gca,'YTick',1:4,'YTickLabel',{'FE','BE','ME','RK4'})
title('n_0 = 0.80 Error Map')
xlabel('Time (ms)')

sgtitle('Reference Voltage and Solver Error')

videoFile = 'hh_error_grid.mp4';
vidObj = VideoWriter(videoFile,'MPEG-4');
vidObj.FrameRate = 12;
open(vidObj);

figA = figure('Position',[100 100 1280 720]);

%  reduced K animation
subplot(3,1,1)
R1 = plot(t(1),RefA(1),'k','LineWidth',1.5);
yyaxis right
hold on
E11 = plot(t(1),log10(A1(1)),'r');
E12 = plot(t(1),log10(A2(1)),'b');
E13 = plot(t(1),log10(A3(1)),'g');
E14 = plot(t(1),log10(A4(1)),'m');
hold off
ylabel('log_{10}|Error|'); ylim([-6 2])
yyaxis left
ylabel('V_m (mV)'); ylim([-85 60]); xlim(tspan); grid on
title('Reduced K^+ Activation')

% Plotting normal K animation
subplot(3,1,2)
R2 = plot(t(1),RefB(1),'k','LineWidth',1.5);
yyaxis right
hold on
E21 = plot(t(1),log10(B1(1)),'r');
E22 = plot(t(1),log10(B2(1)),'b');
E23 = plot(t(1),log10(B3(1)),'g');
E24 = plot(t(1),log10(B4(1)),'m');
hold off
ylabel('log_{10}|Error|'); ylim([-6 2])
yyaxis left
ylabel('V_m (mV)'); ylim([-85 60]); xlim(tspan); grid on
title('Normal K^+ Activation')

% Plotting excessive K animation
subplot(3,1,3)
R3 = plot(t(1),RefC(1),'k','LineWidth',1.5);
yyaxis right
hold on
E31 = plot(t(1),log10(C1(1)),'r');
E32 = plot(t(1),log10(C2(1)),'b');
E33 = plot(t(1),log10(C3(1)),'g');
E34 = plot(t(1),log10(C4(1)),'m');
hold off
ylabel('log_{10}|Error|'); ylim([-6 2])
yyaxis left
ylabel('V_m (mV)'); ylim([-85 60]); xlim(tspan); grid on
xlabel('Time (ms)')
title('Excessive K^+ Activation')

sgtitle('Reference Voltage and Solver Error')

for k = 1:40:N
    a = 1:k;
    %  reduced K traces
    set(R1,'XData',t(a),'YData',RefA(a))
    set(E11,'XData',t(a),'YData',log10(A1(a)))
    set(E12,'XData',t(a),'YData',log10(A2(a)))
    set(E13,'XData',t(a),'YData',log10(A3(a)))
    set(E14,'XData',t(a),'YData',log10(A4(a)))
    % Updating normal K traces
    set(R2,'XData',t(a),'YData',RefB(a))
    set(E21,'XData',t(a),'YData',log10(B1(a)))
    set(E22,'XData',t(a),'YData',log10(B2(a)))
    set(E23,'XData',t(a),'YData',log10(B3(a)))
    set(E24,'XData',t(a),'YData',log10(B4(a)))
    % excessive K traces
    set(R3,'XData',t(a),'YData',RefC(a))
    set(E31,'XData',t(a),'YData',log10(C1(a)))
    set(E32,'XData',t(a),'YData',log10(C2(a)))
    set(E33,'XData',t(a),'YData',log10(C3(a)))
    set(E34,'XData',t(a),'YData',log10(C4(a)))
    drawnow
    writeVideo(vidObj,getframe(figA));
end

fprintf('  animation finished\n');
close(vidObj);
fprintf('Video saved as: %s\n',videoFile);
