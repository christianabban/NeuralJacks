function interactive_visualization
clc;
close all;

%% INTERACTIVE MEMBRANE VOLTAGE OVER TIME
V0 = -70;
m0 = 0.05;
h0 = 0.60;
n0 = 0.32;

fig = uifigure('Name','Interactive Membrane Voltage','Position',[100 100 1280 720]);
gridLayout = uigridlayout(fig,[1 2]);
gridLayout.ColumnWidth = {260,'1x'};

% Plotting controls
controlPanel = uipanel(gridLayout,'Title','Controls');
controlPanel.Layout.Row = 1;
controlPanel.Layout.Column = 1;
controlGrid = uigridlayout(controlPanel,[14 1]);
controlGrid.RowHeight = {30,45,30,45,30,45,30,45,30,45,30,45,40,'1x'};

uilabel(controlGrid,'Text','Input Current I');
currentSlider = uislider(controlGrid,'Limits',[0 20],'Value',10);

uilabel(controlGrid,'Text','Initial Voltage V_0');
voltageSlider = uislider(controlGrid,'Limits',[-85 -50],'Value',V0);

uilabel(controlGrid,'Text','Initial m Gate');
mSlider = uislider(controlGrid,'Limits',[0.01 0.99],'Value',m0);

uilabel(controlGrid,'Text','Initial h Gate');
hSlider = uislider(controlGrid,'Limits',[0.01 0.99],'Value',h0);

uilabel(controlGrid,'Text','Initial n Gate');
nSlider = uislider(controlGrid,'Limits',[0.01 0.90],'Value',n0);

uilabel(controlGrid,'Text','Simulation End Time');
timeSlider = uislider(controlGrid,'Limits',[10 80],'Value',50);

updateButton = uibutton(controlGrid,'Text','Update Plot');

% Plotting membrane voltage over time
axV = uiaxes(gridLayout);
axV.Layout.Row = 1;
axV.Layout.Column = 2;
title(axV,'Membrane Voltage Over Time')
xlabel(axV,'Time (ms)')
ylabel(axV,'Membrane Voltage (mV)')
grid(axV,'on')

updateButton.ButtonPushedFcn = @(~,~) update_plot();
currentSlider.ValueChangingFcn = @(~,event) slider_preview(currentSlider,event.Value);
voltageSlider.ValueChangingFcn = @(~,event) slider_preview(voltageSlider,event.Value);
mSlider.ValueChangingFcn = @(~,event) slider_preview(mSlider,event.Value);
hSlider.ValueChangingFcn = @(~,event) slider_preview(hSlider,event.Value);
nSlider.ValueChangingFcn = @(~,event) slider_preview(nSlider,event.Value);
timeSlider.ValueChangingFcn = @(~,event) slider_preview(timeSlider,event.Value);

update_plot();

function slider_preview(slider,value)
slider.Value = value;
end

function update_plot()
    Iapp = currentSlider.Value;
    VStart = voltageSlider.Value;
    mStart = mSlider.Value;
    hStart = hSlider.Value;
    nStart = nSlider.Value;
    Tend = timeSlider.Value;

    t = 0:0.02:Tend;
    y0 = [VStart mStart hStart nStart];

    % Solving with input current
    [~,y] = ode45(@(tt,yy) HHmodel_interactive(tt,yy,Iapp),t,y0);
    V = y(:,1);

    % Plotting membrane voltage over time
    cla(axV)
    plot(axV,t,V,'k','LineWidth',1.8)
    hold(axV,'on')
    yline(axV,-55,'r--','Threshold')
    yline(axV,VStart,'b--','Initial V')
    hold(axV,'off')
    xlim(axV,[0 Tend])
    ylim(axV,[-85 60])
    title(axV,'Membrane Voltage Over Time')
    xlabel(axV,'Time (ms)')
    ylabel(axV,'Membrane Voltage (mV)')
    grid(axV,'on')
end

function dydt = HHmodel_interactive(~,y,Iapp)
V = y(1);
m = y(2);
h = y(3);
n = y(4);

Cm = 1;
gNa = 120;
gK = 36;
gL = 0.3;
ENa = 55;
EK = -77;
EL = -54.387;

if abs(V+40) < 1e-7
    am = 1;
else
    am = 0.1*(V+40)/(1-exp(-(V+40)/10));
end

bm = 4*exp(-(V+65)/18);
ah = 0.07*exp(-(V+65)/20);
bh = 1/(1+exp(-(V+35)/10));

if abs(V+55) < 1e-7
    an = 0.1;
else
    an = 0.01*(V+55)/(1-exp(-(V+55)/10));
end

bn = 0.125*exp(-(V+65)/80);

dV = (Iapp - gNa*m^3*h*(V-ENa) - gK*n^4*(V-EK) - gL*(V-EL))/Cm;
dm = am*(1-m) - bm*m;
dh = ah*(1-h) - bh*h;
dn = an*(1-n) - bn*n;

dydt = [dV; dm; dh; dn];
end

end
