% Pressure Distribution in the Sstandard Atmosphere
% Temperature and Pressure Variation as a Function of Altitude

% The Acceleration of Gravity (m/s^2)
g = 9.81;
% Pressure (Pa)
P0 = 101330;
% The Perfect Gas Constant (J/(kg K))
R = 287.13;
% Number of Points
np = 60;
% Temperature (In Celsius)
TC = [15, -56.5, -56.4, -44.5, -2.5];
% The Vertical Cartesian Coordinate (Elevation (m))
z = [0, 11000, 20100, 32200, 47300];
% Generate Linearly Spaced Vectors
zz = linspace(z(1), z(end), np);
% Cubic Spline Data Interpolation
t = spline(z, TC+273.15, zz);
% Create Axes in Tiled Positions
subplot(1, 2, 1)
% 2-D Line Plot
plot(t-273.15, zz/1000, 'k-', TC, z/1000, 'ks')
% Set Axis Limits and Aspect Ratios
axis([-65, 20, 0, 50])
% Temperature Label
xlabel('Temperature (\circC)')
% Elevation Label
ylabel('Elevation (km)')
% Subplot 2
subplot(1, 2, 2)
% Create An Array of All Zeros
P = zeros(np,1);
% The Acceleration of Gravity/The Perfect Gas Constant
gR = g/R;
gg = @(h, z, TC) (1./spline(z, TC+273.15, h));
for k = 1:np
    Intg = quadl(gg, 0.1, zz(k), [], [], z, TC);
    P(k) = P0*exp(-gR*Intg);
end
% Plot 2
plot(P/1000, zz/1000, 'k-')
% Axis 2
axis([0, 110, 0, 50])
% Elevation Label 2
ylabel('Elevation (km)')
% Pressure Label
xlabel('Pressure (kPa)')