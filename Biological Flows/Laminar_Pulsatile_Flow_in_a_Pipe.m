% Example 11.13 Laminar pulsatile flow in a pipe
function Example11_13
omega = 2*pi;
nu = 5e-6;
A = -1e6;
nr = 30;
rmax = 0.004;
r = linspace(0, rmax, nr);
nt = 16; tmax=2*2*pi/omega;
t = linspace(0, tmax, nt);
u = pdepe(1, @Pulse, @PulseIC, @PulseBC, r, t, [], omega, A, nu);
hold on
for ijd = 1:nt
    plot(u(ijd,:)/(A/omega)+(ijd-1), r/rmax, 'k')
    plot(u(ijd,:)/(A/omega)+(ijd-1), -r/rmax, 'k')
    plot([(ijd-1), (ijd-1)], [-1,1], ':k')
end
xlabel('u_z/(A/\omega)')
ylabel('r/R')
ylabel('t')
function [c, f, s] = Pulse(r, t, u, DuDr, omega, A, nu)
c = 1.0;
f = nu*DuDr;
s = A*sin(omega*t);
function u0 = PulseIC(r, omega, A, nu)
u0 = 0;
function [pl, ql, pr, qr] = PulseBC(rl, ul, rr, ur, t, omega, A, nu)
pl = 0;
ql = 1;
pr = 0;
qr = ur;