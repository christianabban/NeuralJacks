function dydt = HHmodel(~,y)
V = y(1);
m = y(2);
h = y(3);
n = y(4);

% Parameters
Cm = 1;
gNa = 120;
gK = 36;
gL = 0.3;
ENa = 55;
EK = -77;
EL = -54.387;

% Applied current
I = 10;

if abs(V+40) < 1e-7
    am = 1;
else
    am = 0.1*(V+40)/(1-exp(-(V+40)/10));
end

% Computing gate rates
bm = 4*exp(-(V+65)/18);
ah = 0.07*exp(-(V+65)/20);
bh = 1/(1+exp(-(V+35)/10));

if abs(V+55) < 1e-7
    an = 0.1;
else
    an = 0.01*(V+55)/(1-exp(-(V+55)/10));
end

bn = 0.125*exp(-(V+65)/80);

% HH Differential equations
dV = (I - gNa*m^3*h*(V-ENa) - gK*n^4*(V-EK) - gL*(V-EL))/Cm;
dm = am*(1-m) - bm*m;
dh = ah*(1-h) - bh*h;
dn = an*(1-n) - bn*n;

dydt = [dV; dm; dh; dn];
end
