% Force on a Planar Gate
% Properties of a Reservoir

function Properties_of_a_Reservoir
% Distance (m)
a = 5.0;
% Length (m)
L = 10.0;
% The Width of The Reservoir in The Direction Normal to The Page (m)
B = 10.0;
% Density
rho = 1000;
% The Acceleration of Gravity (m/s^2)
g = 9.81;
% Force (N)
W = 100000;
% Length/Ddistance
La = L/a;
% Generate Linearly Spaced Vector
theta = linspace(0.0, pi/2, 100);
% The Total Volume of Water
VVw = @(theta,La) (cos(theta)+0.5*La*cos(theta).*sin(theta));
% Create Figure Window
figure(1)
% Create Axes in Tiled Positions
subplot(1, 2, 1)
% 2-D Line Plot
plot(theta*180/pi, VVw(theta,La), 'k')
% Set Axis Limits and Aspect Ratios
axis([0.0, 90.0, 0.0, 1.5])
% Volume/The Total Volume Label
ylabel('V/V_w')
% \theta (\circ) Label
xlabel('\theta (\circ)')
% Display or Hide Axes Grid Lines
grid on
% Retain Current Plot When Adding New Plots
hold on
% Create MaxTheta Function
MaxTheta = @(theta, La) (1-VVw(theta, La));
% Root of Nonlinear Function
ThetaMaxDeg = fzero(MaxTheta, [0.01, pi/2.0], [], La)*180/pi;
% Plot
plot(ThetaMaxDeg, 1.0, 'sk')
% Specifies Text Object Properties Using One or More Name-Value Pairs and
% num2str for Convert Numbers to Character Array
text(10, 0.95, ['\theta_{max}= ', num2str(ThetaMaxDeg, 4) ' circ'])
% Create VVwNeg Function
VVwNeg = @(theta, La) (-VVw(theta, La));
% Find Minimum of Single-Variable Function on Fixed Interval
[ThetaMaxVol, VVwMax] = fminbnd(VVwNeg, 0.0, ThetaMaxDeg*pi/180, [], La);
% Plot
plot(ThetaMaxVol*180/pi, -VVwMax, 'ks')
% Add Text Descriptions to Data Points
text(10, -VVwMax+0.13, ['V_{max}/V_w = ' num2str(-VVwMax, 4)])
text(10, -VVwMax+0.05, [' \theta_V = ' num2str(ThetaMaxVol*180/pi, 4)...
' \circ '])
% Create Axes in Tiled Positions
subplot(1,2,2)
% Generate Linearly Spaced Vector
theta = linspace(0.01, ThetaMaxDeg*pi/180);
% Plot
plot(theta*180.0/pi, h(theta, La, a), 'k-')
% h (m) Label
ylabel('h (m)')
% \theta (\circ) Label
xlabel('\theta (\circ)')
% Display or Hide Axes Grid Lines
grid on
% Create Figure Window
figure(2)
% Plot
plot(theta*180.0/pi, Frod(theta, L, B, rho, g, W, La, a)*10^-6, 'k-')
% Retain Current Plot When Adding New Plots
hold on
% Find Minimum of Single-Variable Function On Fixed Interval
[FrodThetaMin, FrodMin] = fminbnd(@Frod, 0.0, ThetaMaxDeg*pi/180, [], L, B, rho, g, W, La, a);
% Plot
plot(FrodThetaMin*180/pi, FrodMin*1e-6, 'ks')
% Add Text Descriptions to Data Points
text(FrodThetaMin*180/pi, FrodMin*1e-6-0.1, ['F_{rod, min} = '...
num2str(FrodMin*1e-6, 4) ' MN'])
text(FrodThetaMin*180/pi, FrodMin*1e-6-0.22, ['\theta_F = '...
num2str(FrodThetaMin*180/pi, 4) ' \circ'])
% Set or Query y-axis Limits
ylim([0.4, 2.4])
% F_{rod} (MN) Label
ylabel('F_{rod} (MN)')
% \theta (\circ) Label
xlabel('\theta (\circ)')
% Display or Hide Axes Grid Lines
grid on
% Declare Function Name, Inputs, and Outputs
function Fr = Frod(theta, L, B, rho, g, W, La, a)
D = (L*sin(theta+acos(cos(theta)/sqrt(2))));
Fr = ((B*rho*g*h(theta, La, a).^3)./(6*cos(theta).^2)+0.5*W*L*sin(theta))./D;
% Declare Function Name, Inputs, and Outputs
function f = h(theta, La, a)
f = (-a./tan(theta).*(1-sqrt(1+2*La*tan(theta))));
