% Properties of a Reservoir

function Properties_of_a_Reservoir
% Variabel a
a = 5.0;
% Length (1)
L = 10.0;
% Length (2)
B = 10.0;
% Density
rho = 1000;
% Gravitational Constant
g = 9.81;
% Velocity Components
W = 100000;
La = L/a;
% theta generate linearly spaced vector
theta = linspace(0.0, pi/2, 100);
% The Volume Ratio
VVw = @(theta,La) (cos(theta)+0.5*La*cos(theta).*sin(theta));
% Create figure window
figure(1)
% Create axes in tiled positions
subplot(1, 2, 1)
% Plot
plot(theta*180/pi, VVw(theta,La), 'k')
% Set axis limits and aspect ratios
axis([0.0, 90.0, 0.0, 1.5])
% V/V_w Label
ylabel('V/V_w')
% \theta (\circ) Label
xlabel('\theta (\circ)')
% Display or hide axes grid lines
grid on
% Retain current plot when adding new plots
hold on
% Create MaxTheta Function
MaxTheta = @(theta, La) (1-VVw(theta, La));
% Root of nonlinear function
ThetaMaxDeg = fzero(MaxTheta, [0.01, pi/2.0], [], La)*180/pi;
% Plot
plot(ThetaMaxDeg, 1.0, 'sk')
% Specifies Text object properties using one or more name-value pairs.
% num2str for convert numbers to character array
text(10, 0.95, ['\theta_{max}= ', num2str(ThetaMaxDeg, 4) ' circ'])
% Create VVwNeg Function
VVwNeg = @(theta, La) (-VVw(theta, La));
% Find minimum of single-variable function on fixed interval
[ThetaMaxVol, VVwMax] = fminbnd(VVwNeg, 0.0, ThetaMaxDeg*pi/180, [], La);
% Plot
plot(ThetaMaxVol*180/pi, -VVwMax, 'ks')
% Add text descriptions to data points
text(10, -VVwMax+0.13, ['V_{max}/V_w = ' num2str(-VVwMax, 4)])
text(10, -VVwMax+0.05, [' \theta_V = ' num2str(ThetaMaxVol*180/pi, 4)...
' \circ '])
% Create axes in tiled positions
subplot(1,2,2)
% theta generate linearly spaced vector
theta = linspace(0.01, ThetaMaxDeg*pi/180);
% Plot
plot(theta*180.0/pi, h(theta, La, a), 'k-')
% h (m) Label
ylabel('h (m)')
% \theta (\circ) Label
xlabel('\theta (\circ)')
% Display or hide axes grid lines
grid on
% Create figure window
figure(2)
% Plot
plot(theta*180.0/pi, Frod(theta, L, B, rho, g, W, La, a)*10^-6, 'k-')
% Retain current plot when adding new plots
hold on
% Find minimum of single-variable function on fixed interval
[FrodThetaMin, FrodMin] = fminbnd(@Frod, 0.0, ThetaMaxDeg*pi/180, [], L, B, rho, g, W, La, a);
% Plot
plot(FrodThetaMin*180/pi, FrodMin*1e-6, 'ks')
% Add text descriptions to data points
text(FrodThetaMin*180/pi, FrodMin*1e-6-0.1, ['F_{rod, min} = '...
num2str(FrodMin*1e-6, 4) ' MN'])
text(FrodThetaMin*180/pi, FrodMin*1e-6-0.22, ['\theta_F = '...
num2str(FrodThetaMin*180/pi, 4) ' \circ'])
% Set or query y-axis limits
ylim([0.4, 2.4])
% F_{rod} (MN) Label
ylabel('F_{rod} (MN)')
% \theta (\circ) Label
xlabel('\theta (\circ)')
% Display or hide axes grid lines
grid on
% Declare function name, inputs, and outputs
function Fr = Frod(theta, L, B, rho, g, W, La, a)
D = (L*sin(theta+acos(cos(theta)/sqrt(2))));
Fr = ((B*rho*g*h(theta, La, a).^3)./(6*cos(theta).^2)+0.5*W*L*sin(theta))./D;
% Declare function name, inputs, and outputs
function f = h(theta, La, a)
f = (-a./tan(theta).*(1-sqrt(1+2*La*tan(theta))));