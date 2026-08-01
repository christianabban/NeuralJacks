function [y_FE,y_BE,y_ME,y_RK,t45,y45] = HH_solvers(y0,t,dt,tspan)
N = length(t);

y_FE = zeros(N,4);
y_BE = zeros(N,4);
y_ME = zeros(N,4);
y_RK = zeros(N,4);

y_FE(1,:) = y0;
y_BE(1,:) = y0;
y_ME(1,:) = y0;
y_RK(1,:) = y0;

for i = 1:N-1
    % Solving Forward Euler step
    k1 = HHmodel(t(i),y_FE(i,:));
    y_FE(i+1,:) = y_FE(i,:) + dt*k1';

    % Solving Backward Euler step
    % Backward Euler is implicit, so y(i+1) is found by solving
    % g = y(i) + dt*f(t(i+1),g) with Newton iteration each step
    yold = y_BE(i,:);
    g = yold;
    for it = 1:20
        F = g - yold - dt*HHmodel(t(i+1),g)';
        if norm(F) < 1e-10
            break
        end
        J = zeros(4,4);
        for c = 1:4
            e = zeros(1,4);
            e(c) = 1e-7;
            Fe = (g+e) - yold - dt*HHmodel(t(i+1),g+e)';
            J(:,c) = (Fe - F)'/1e-7;
        end
        g = g - (J\F')';
    end
    y_BE(i+1,:) = g;

    % Solving Modified Euler step
    k1 = HHmodel(t(i),y_ME(i,:));
    yp = y_ME(i,:) + dt*k1';
    k2 = HHmodel(t(i+1),yp);
    y_ME(i+1,:) = y_ME(i,:) + (dt/2)*(k1'+k2');

    % Solving RK4 step
    k1 = HHmodel(t(i),y_RK(i,:));
    k2 = HHmodel(t(i)+dt/2,y_RK(i,:)+dt*k1'/2);
    k3 = HHmodel(t(i)+dt/2,y_RK(i,:)+dt*k2'/2);
    k4 = HHmodel(t(i)+dt,y_RK(i,:)+dt*k3');
    y_RK(i+1,:) = y_RK(i,:) + (dt/6)*(k1'+2*k2'+2*k3'+k4');
end

% Solving ODE45 reference
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
[t45,y45] = ode45(@HHmodel,tspan,y0,opts);
end
