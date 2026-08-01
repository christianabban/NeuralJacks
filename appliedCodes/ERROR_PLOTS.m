clc;
clear;
close all;

%% ERROR PLOTS USING ODE45 AS REFERENCE
%% SIMULATION PARAMETERS
tspan = [0 40];
dt = 0.01;
t = tspan(1):dt:tspan(2);
N = length(t);

V0 = -70;
m0 = 0.05;
h0 = 0.60;

% Potassium activation cases
n0_cases = linspace(0.05,0.80,10);
nCases = length(n0_cases);
floor_val = 1e-6;

Err = zeros(nCases,4,N);

% index of the normal case, used for the line comparison
[~,inorm] = min(abs(n0_cases - 0.32));

%% loop
for c = 1:nCases
    y0 = [V0 m0 h0 n0_cases(c)];
  
    %% ODE45 REFERENCE
    [yFE,yBE,yME,yRK,t45,y45] = HH_solvers(y0,t,dt,tspan);
    V45 = interp1(t45,y45(:,1),t,'pchip');
    Err(c,1,:) = max(abs(yFE(:,1)' - V45),floor_val);
    Err(c,2,:) = max(abs(yBE(:,1)' - V45),floor_val);
    Err(c,3,:) = max(abs(yME(:,1)' - V45),floor_val);
    Err(c,4,:) = max(abs(yRK(:,1)' - V45),floor_val);
end

E_FE = squeeze(log10(Err(:,1,:)));
E_BE = squeeze(log10(Err(:,2,:)));
E_ME = squeeze(log10(Err(:,3,:)));
E_RK = squeeze(log10(Err(:,4,:)));

%% match t and n0 case for array
[T,NGRID] = meshgrid(t,n0_cases);

%% surfaces
figure('Position',[100 100 1280 720]);

%   plot of Forward Euler surface
subplot(2,2,1)
surf(T,NGRID,E_FE,'EdgeColor','none')
colormap turbo
colorbar
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('Forward Euler')
view(45,35)
grid on

%   plot of Backward Euler surface
subplot(2,2,2)
surf(T,NGRID,E_BE,'EdgeColor','none')
colorbar
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('Backward Euler')
view(45,35)
grid on

%   plot  Modified Euler surface
subplot(2,2,3)
surf(T,NGRID,E_ME,'EdgeColor','none')
colorbar
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('Modified Euler')
view(45,35)
grid on

%   plot  RK4 surface
subplot(2,2,4)
surf(T,NGRID,E_RK,'EdgeColor','none')
colorbar
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('RK4')
view(45,35)
grid on

sgtitle('Error Surfaces')

%% mesh
figure('Position',[100 100 1280 720]);

%  Forward Euler mesh
subplot(2,2,1)
mesh(T,NGRID,E_FE)
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('Forward Euler')
view(45,35)
grid on

%  Backward Euler mesh
subplot(2,2,2)
mesh(T,NGRID,E_BE)
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('Backward Euler')
view(45,35)
grid on

%  Modified Euler mesh
subplot(2,2,3)
mesh(T,NGRID,E_ME)
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('Modified Euler')
view(45,35)
grid on

%  RK4 mesh
subplot(2,2,4)
mesh(T,NGRID,E_RK)
xlabel('Time (ms)')
ylabel('n_0')
zlabel('log_{10}|Error|')
title('RK4')
view(45,35)
grid on

sgtitle('Error Mesh')

%% contour
figure('Position',[100 100 1280 720]);

%  Forward Euler contour
subplot(2,2,1)
contourf(T,NGRID,E_FE,12,'LineColor','none')
colormap turbo
colorbar
xlabel('Time (ms)')
ylabel('n_0')
title('Forward Euler')

% Backward Euler contour
subplot(2,2,2)
contourf(T,NGRID,E_BE,12,'LineColor','none')
colorbar
xlabel('Time (ms)')
ylabel('n_0')
title('Backward Euler')

%   plot  Modified Euler contour
subplot(2,2,3)
contourf(T,NGRID,E_ME,12,'LineColor','none')
colorbar
xlabel('Time (ms)')
ylabel('n_0')
title('Modified Euler')

%  RK4 contour
subplot(2,2,4)
contourf(T,NGRID,E_RK,12,'LineColor','none')
colorbar
xlabel('Time (ms)')
ylabel('n_0')
title('RK4')

sgtitle('Error Contours')

%% COMBINED ERROR COMPARISON:NORMAL POTASSIUM ACTIVATION
e1 = E_FE(inorm,:);
e2 = E_BE(inorm,:);
e3 = E_ME(inorm,:);
e4 = E_RK(inorm,:);

figA = figure('Position',[100 100 1280 720]);
hold on
%   Forward Euler error
L1 = plot(t(1),e1(1),'r','LineWidth',1.4);
%    Backward Euler error
L2 = plot(t(1),e2(1),'b','LineWidth',1.4);
%   plot of Modified Euler error
L3 = plot(t(1),e3(1),'g','LineWidth',1.4);
%   plot of RK4 error
L4 = plot(t(1),e4(1),'m','LineWidth',1.4);
hold off
xlabel('Time (ms)')
ylabel('log_{10}|Error|')
title('Normal Potassium Activation Error')
legend('Forward Euler','Backward Euler','Modified Euler','RK4','Location','southeast')
xlim(tspan)
ylim([-6 2])
grid on

videoFile = 'hh_error_surfaces.mp4';
vidObj = VideoWriter(videoFile,'MPEG-4');
vidObj.FrameRate = 12;
open(vidObj);

for k = 1:40:N
    a = 1:k;
    % Forward Euler error
    set(L1,'XData',t(a),'YData',e1(a))
    % Updating Backward Euler error
    set(L2,'XData',t(a),'YData',e2(a))
    %Modified Euler error
    set(L3,'XData',t(a),'YData',e3(a))
    % Updating RK4 error
    set(L4,'XData',t(a),'YData',e4(a))
    drawnow
    writeVideo(vidObj,getframe(figA));
end

fprintf('  animation finished\n');
close(vidObj);
fprintf('Video saved as: %s\n',videoFile);
