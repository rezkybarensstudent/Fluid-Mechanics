% Laminar Flow in a Horizontal Pipe with Circular Cross Section
% Laminar Flow in a Pipe that is Started from Rest

function Laminar_Flow_in_a_Pipe_that_is_Started_from_Rest
% The kinematic viscosity
nu = 0.00038;
% Mass per unit volume
rho = 1000;
% Pressure Gradient
dPdz = -1e6;
nr = 100;
rmax = 0.005;
nt = 15;
tmax = 0.07;
% Generate linearly spaced vector
r = linspace(0, rmax, nr);
% Generate linearly spaced vector
t = linspace(0, tmax, nt);
u = pdepe(1, @pdPipe, @pdPipeIC, @pdPipeBC, r, t, [], nu, rho, dPdz);
hold on
% for loop to repeat specified number of times
for ijd = [2, 3, 4, 6, nt]
    plot(u(ijd,:), r*1000, 'k')
    if ijd == nt
        text(u(ijd,20), rmax*0.25*1000, [num2str(tmax*1000, 4) ' ms'])
    elseif ijd == 2
        text(u(ijd,20), rmax*0.25*1000, ['t = ' num2str(t(ijd)*1000, 4) ' ms'])
    else
        text(u(ijd,20), rmax*0.25*1000, [num2str(t(ijd)*1000, 4) ' ms'])
    end
end
% Label x-axis
xlabel('Axial Velocity, u_z (m/s)')
% Label y-axis
ylabel('r (mm)')
% Add text descriptions to data points
text(0.5*u(nt,1), 0.8*rmax*1000, ['u_z(0,' num2str(t(nt)) ') = '...
num2str(u(nt,1),5)' m/s'])
function [c,f,s] = pdPipe(r, t, u, DuDr, nu, rho, dPdz)
c = 1.0/nu;
f = DuDr;
s = -dPdz/(rho*nu);
function u0 = pdPipeIC(r, nu, rho, dPdz)
u0 = 0;
function [pl, ql, pr, qr] = pdPipeBC(rl, ul, rr, ur, t, nu, rho, dPdz)
pl = 1;
ql = 0;
pr = 0;
qr = ur;