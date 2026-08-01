clc;
clear;
close all;

%%  Hodgkin-Huxley Model: Phase Portraits

tspan = [0 40];
dt = 0.05;
t = tspan(1):dt:tspan(2);
N = length(t);

V0 = -70;
m0 = 0.05;
h0 = 0.60;

% Three K+ activation cases (columns)
[A_FE,A_BE,A_ME,A_RK,tA,A_45] = HH_solvers([V0 m0 h0 0.05],t,dt,tspan);
[B_FE,B_BE,B_ME,B_RK,tB,B_45] = HH_solvers([V0 m0 h0 0.32],t,dt,tspan);
[C_FE,C_BE,C_ME,C_RK,tC,C_45] = HH_solvers([V0 m0 h0 0.80],t,dt,tspan);

% Solver colours
%  FIGURE 1
% V vs n  (membrane voltage vs K+ gate)
% FIGURE 2
% V vs m  (membrane voltage vs Na+ gate)
%  FIGURE 3
% n vs m  (K+ gate vs Na+ gate)
% FIGURE 4 Combined 3×3 grid of the phase portaits
figure('Position',[100 100 1280 720]);

% Plotting V-n phase portrait
subplot(3,3,1)
plot(A_FE(:,1),A_FE(:,4),'r')
hold on
plot(A_BE(:,1),A_BE(:,4),'b')
plot(A_ME(:,1),A_ME(:,4),'g')
plot(A_RK(:,1),A_RK(:,4),'m')
plot(A_45(:,1),A_45(:,4),'k','LineWidth',2)
hold off
title('n_0 = 0.05  V_m vs n')
xlabel('V_m (mV)')
ylabel('n')
xlim([-80 55])
ylim([0 1])
axis square
grid on
legend('Forward Euler','Backward Euler','Modified Euler','RK4','ODE45','Location','northwest','FontSize',7)

% Plotting V-n phase portrait
subplot(3,3,2)
plot(B_FE(:,1),B_FE(:,4),'r')
hold on
plot(B_BE(:,1),B_BE(:,4),'b')
plot(B_ME(:,1),B_ME(:,4),'g')
plot(B_RK(:,1),B_RK(:,4),'m')
plot(B_45(:,1),B_45(:,4),'k','LineWidth',2)
hold off
title('n_0 = 0.32  V_m vs n')
xlabel('V_m (mV)')
ylabel('n')
xlim([-80 55])
ylim([0 1])
axis square
grid on

% Plotting V-n phase portrait
subplot(3,3,3)
plot(C_FE(:,1),C_FE(:,4),'r')
hold on
plot(C_BE(:,1),C_BE(:,4),'b')
plot(C_ME(:,1),C_ME(:,4),'g')
plot(C_RK(:,1),C_RK(:,4),'m')
plot(C_45(:,1),C_45(:,4),'k','LineWidth',2)
hold off
title('n_0 = 0.80  V_m vs n')
xlabel('V_m (mV)')
ylabel('n')
xlim([-80 55])
ylim([0 1])
axis square
grid on

% Plotting V-m phase portrait
subplot(3,3,4)
plot(A_FE(:,1),A_FE(:,2),'r')
hold on
plot(A_BE(:,1),A_BE(:,2),'b')
plot(A_ME(:,1),A_ME(:,2),'g')
plot(A_RK(:,1),A_RK(:,2),'m')
plot(A_45(:,1),A_45(:,2),'k','LineWidth',2)
hold off
title('n_0 = 0.05  V_m vs m')
xlabel('V_m (mV)')
ylabel('m')
xlim([-80 55])
ylim([0 1])
axis square
grid on

% Plotting V-m phase portrait
subplot(3,3,5)
plot(B_FE(:,1),B_FE(:,2),'r')
hold on
plot(B_BE(:,1),B_BE(:,2),'b')
plot(B_ME(:,1),B_ME(:,2),'g')
plot(B_RK(:,1),B_RK(:,2),'m')
plot(B_45(:,1),B_45(:,2),'k','LineWidth',2)
hold off
title('n_0 = 0.32  V_m vs m')
xlabel('V_m (mV)')
ylabel('m')
xlim([-80 55])
ylim([0 1])
axis square
grid on

% Plotting V-m phase portrait
subplot(3,3,6)
plot(C_FE(:,1),C_FE(:,2),'r')
hold on
plot(C_BE(:,1),C_BE(:,2),'b')
plot(C_ME(:,1),C_ME(:,2),'g')
plot(C_RK(:,1),C_RK(:,2),'m')
plot(C_45(:,1),C_45(:,2),'k','LineWidth',2)
hold off
title('n_0 = 0.80  V_m vs m')
xlabel('V_m (mV)')
ylabel('m')
xlim([-80 55])
ylim([0 1])
axis square
grid on

% Plotting m-n phase portrait
subplot(3,3,7)
plot(A_FE(:,2),A_FE(:,4),'r')
hold on
plot(A_BE(:,2),A_BE(:,4),'b')
plot(A_ME(:,2),A_ME(:,4),'g')
plot(A_RK(:,2),A_RK(:,4),'m')
plot(A_45(:,2),A_45(:,4),'k','LineWidth',2)
hold off
title('n_0 = 0.05  m vs n')
xlabel('m')
ylabel('n')
xlim([0 1])
ylim([0 1])
axis square
grid on

% Plotting m-n phase portrait
subplot(3,3,8)
plot(B_FE(:,2),B_FE(:,4),'r')
hold on
plot(B_BE(:,2),B_BE(:,4),'b')
plot(B_ME(:,2),B_ME(:,4),'g')
plot(B_RK(:,2),B_RK(:,4),'m')
plot(B_45(:,2),B_45(:,4),'k','LineWidth',2)
hold off
title('n_0 = 0.32  m vs n')
xlabel('m')
ylabel('n')
xlim([0 1])
ylim([0 1])
axis square
grid on

% Plotting m-n phase portrait
subplot(3,3,9)
plot(C_FE(:,2),C_FE(:,4),'r')
hold on
plot(C_BE(:,2),C_BE(:,4),'b')
plot(C_ME(:,2),C_ME(:,4),'g')
plot(C_RK(:,2),C_RK(:,4),'m')
plot(C_45(:,2),C_45(:,4),'k','LineWidth',2)
hold off
title('n_0 = 0.80  m vs n')
xlabel('m')
ylabel('n')
xlim([0 1])
ylim([0 1])
axis square
grid on

sgtitle('Hodgkin-Huxley Phase Portraits')

%% PHASE PLANE: vector field and nullclines in the V-n plane
% m is set to its steady state m_inf(V) and h is held fixed, reducing the
% 4D system to 2D so that nullclines can be drawn
h_fix = 0.60;
Vg = linspace(-80,55,26);
ng = linspace(0,1,26);
[VV,NN] = meshgrid(Vg,ng);
dV = zeros(size(VV));
dN = zeros(size(VV));

for i = 1:numel(VV)
    v = VV(i);
    if abs(v+40) < 1e-7
        am = 1;
    else
        am = 0.1*(v+40)/(1-exp(-(v+40)/10));
    end
    bm = 4*exp(-(v+65)/18);
    minf = am/(am+bm);
    d = HHmodel(0,[v minf h_fix NN(i)]);
    dV(i) = d(1);
    dN(i) = d(4);
end

% arrows normalised so direction is visible (dV is much larger than dn)
L = sqrt(dV.^2 + dN.^2);
U = dV./L;
W = dN./L;

figure('Position',[100 100 1280 720]);
%  vector field with quiver
quiver(VV,NN,U,W,0.6,'Color',[0.6 0.6 0.6])
hold on
%  V nullcline using contour
contour(VV,NN,dV,[0 0],'r','LineWidth',2)
% Plotting n nullcline
contour(VV,NN,dN,[0 0],'b','LineWidth',2)
% Plotting ODE45 phase paths
plot(A_45(:,1),A_45(:,4),'m','LineWidth',1.5)
plot(B_45(:,1),B_45(:,4),'g','LineWidth',1.5)
plot(C_45(:,1),C_45(:,4),'k','LineWidth',1.5)
hold off
xlabel('V_m (mV)')
ylabel('n')
title('V-n Phase Plane with Nullclines')
xlim([-80 55])
ylim([0 1])
axis square
legend('Vector field','dV/dt = 0','dn/dt = 0','n_0 = 0.05','n_0 = 0.32','n_0 = 0.80','Location','eastoutside')
grid on

%% 3D PHASE SPACE
figure('Position',[100 100 1280 720]);

% Plotting reduced K phase space
subplot(1,3,1)
plot3(A_45(:,1),A_45(:,2),A_45(:,4),'r','LineWidth',1.5)
hold on
scatter3(A_45(1,1),A_45(1,2),A_45(1,4),70,'k','filled')
hold off
xlabel('V_m (mV)'); ylabel('m'); zlabel('n')
title('n_0 = 0.05')
grid on; view(-37.5,30)
xlim([-80 55]); ylim([0 1]); zlim([0 1])

% Plotting normal K phase space
subplot(1,3,2)
plot3(B_45(:,1),B_45(:,2),B_45(:,4),'b','LineWidth',1.5)
hold on
scatter3(B_45(1,1),B_45(1,2),B_45(1,4),70,'k','filled')
hold off
xlabel('V_m (mV)'); ylabel('m'); zlabel('n')
title('n_0 = 0.32')
grid on; view(-37.5,30)
xlim([-80 55]); ylim([0 1]); zlim([0 1])

% Plotting excessive K phase space
subplot(1,3,3)
plot3(C_45(:,1),C_45(:,2),C_45(:,4),'g','LineWidth',1.5)
hold on
scatter3(C_45(1,1),C_45(1,2),C_45(1,4),70,'k','filled')
hold off
xlabel('V_m (mV)'); ylabel('m'); zlabel('n')
title('n_0 = 0.80')
grid on; view(-37.5,30)
xlim([-80 55]); ylim([0 1]); zlim([0 1])

sgtitle('Hodgkin-Huxley 3D Phase Space')

refA = interp1(tA,A_45,t','pchip');
refB = interp1(tB,B_45,t','pchip');
refC = interp1(tC,C_45,t','pchip');

videoFile = 'hh_phase_portraits.mp4';
vidObj = VideoWriter(videoFile,'MPEG-4');
vidObj.FrameRate = 12;
open(vidObj);

figA = figure('Position',[100 100 1280 720]);

%  voltage traces
subplot(2,1,1)
hold on
LA = plot(t(1),refA(1,1),'r','LineWidth',1.8);
LB = plot(t(1),refB(1,1),'b','LineWidth',1.8);
LC = plot(t(1),refC(1,1),'g','LineWidth',1.8);
hold off
xlim(tspan)
ylim([-85 60])
grid on
title('Voltage Trace')
xlabel('Time (ms)')
ylabel('mV')
legend('n_0 = 0.05','n_0 = 0.32','n_0 = 0.80','Location','eastoutside')

%  animated phase plane
subplot(2,1,2)
contour(VV,NN,dV,[0 0],'r','LineWidth',2)
hold on
contour(VV,NN,dN,[0 0],'b','LineWidth',2)
PA = plot(refA(1,1),refA(1,4),'r','LineWidth',1.5);
PB = plot(refB(1,1),refB(1,4),'b','LineWidth',1.5);
PC = plot(refC(1,1),refC(1,4),'g','LineWidth',1.5);
hold off
xlabel('V_m (mV)')
ylabel('n')
title('V-n Phase Plane')
xlim([-80 55])
ylim([0 1])
axis square
grid on

sgtitle('Hodgkin-Huxley Phase Portrait Evolution')

for k = 1:10:N
    a = 1:k;
    % Updating voltage traces
    set(LA,'XData',t(a),'YData',refA(a,1))
    set(LB,'XData',t(a),'YData',refB(a,1))
    set(LC,'XData',t(a),'YData',refC(a,1))
    % Updating phase paths
    set(PA,'XData',refA(a,1),'YData',refA(a,4))
    set(PB,'XData',refB(a,1),'YData',refB(a,4))
    set(PC,'XData',refC(a,1),'YData',refC(a,4))
    drawnow
    writeVideo(vidObj,getframe(figA));
end

fprintf('  animation finished\n');
close(vidObj);
fprintf('Video saved as: %s\n',videoFile);
