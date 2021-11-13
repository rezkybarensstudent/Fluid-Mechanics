% Properties of a Reservoir

function Properties_of_a_Reservoir
a = 5.0;
% Characteristic Length
L = 10.0;
B = 10.0;
rho = 1000;
% Gravitational Constant
g = 9.81;
% Velocity Components
W = 100000;
La = L/a;
theta = linspace(0.0, pi/2, 100);
VVw = @(theta,La) (cos(theta)+0.5*La*cos(theta).*sin(theta));
figure(1)
subplot(1,2,1)
plot(theta*180/pi, VVw(theta,La), 'k')
axis([0.0, 90.0, 0.0, 1.5])
ylabel('V/V_w')
xlabel('\theta (\circ)')
grid on
hold on
MaxTheta = @(theta, La) (1-VVw(theta, La));
ThetaMaxDeg = fzero(MaxTheta, [0.01, pi/2.0], [], La)*180/pi;
plot(ThetaMaxDeg, 1.0, 'sk')
text(10, 0.95, ['\theta_{max}= ', num2str(ThetaMaxDeg, 4) ' circ'])
VVwNeg = @(theta, La) (-VVw(theta, La));
[ThetaMaxVol, VVwMax] = fminbnd(VVwNeg, 0.0, ThetaMaxDeg*pi/180, [], La);
plot(ThetaMaxVol*180/pi, -VVwMax, 'ks')
text(10, -VVwMax+0.13, ['V_{max}/V_w = ' num2str(-VVwMax, 4)])
text(10, -VVwMax+0.05, [' \theta_V = ' num2str(ThetaMaxVol*180/pi, 4)...
' \circ '])
subplot(1,2,2)
theta = linspace(0.01, ThetaMaxDeg*pi/180);
plot(theta*180.0/pi, h(theta, La, a), 'k-')
ylabel('h (m)')
xlabel('\theta (\circ)')
grid on
figure(2)
plot(theta*180.0/pi, Frod(theta, L, B, rho, g, W, La, a)*10^-6, 'k-')
hold on
[FrodThetaMin, FrodMin] = fminbnd(@Frod, 0.0, ThetaMaxDeg*pi/180, [], L, B, rho, g, W, La, a);
plot(FrodThetaMin*180/pi, FrodMin*1e-6, 'ks')
text(FrodThetaMin*180/pi, FrodMin*1e-6-0.1, ['F_{rod, min} = '...
num2str(FrodMin*1e-6, 4) ' MN'])
text(FrodThetaMin*180/pi, FrodMin*1e-6-0.22, ['\theta_F = '...
num2str(FrodThetaMin*180/pi, 4) ' \circ'])
ylim([0.4, 2.4])
ylabel('F_{rod} (MN)')
xlabel('\theta (\circ)')
grid on
function Fr = Frod(theta, L, B, rho, g, W, La, a)
D = (L*sin(theta+acos(cos(theta)/sqrt(2))));
Fr = ((B*rho*g*h(theta, La, a).^3)./(6*cos(theta).^2)+0.5*W*L*sin(theta))./D;
function f = h(theta, La, a)
f = (-a./tan(theta).*(1-sqrt(1+2*La*tan(theta))));
