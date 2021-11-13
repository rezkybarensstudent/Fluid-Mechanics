% Temperature and Pressure Variation as a Function of Altitude

% Gravitational Constant
g = 9.81;
% Atmospheric Pressure
P0 = 101330;
% Individual Gas Constant
R = 287.13;
% Number of Points
np = 60;
% Temperature
TC = [15, -56.5, -56.4, -44.5, -2.5];
% Elevation
z = [0, 11000, 20100, 32200, 47300];
% Generate linearly spaced vectors
zz = linspace(z(1), z(end), np);
% Spline used to smooth noisy data and perform interpolation.
t = spline(z, TC+273.15, zz);
% Subplot divides the current figure into rectangular panes that are numbered row-wise.
subplot(1, 2, 1)
% Plot function in Matlab is used to create a graphical representation of some data.
plot(t-273.15, zz/1000, 'k-', TC, z/1000, 'ks')
% Axis equal sets the aspect ratio so that the data units are the same in every direction.
axis([-65, 20, 0, 50])
% Temperature Label
xlabel('Temperature (\circC)')
% Elevation Label
ylabel('Elevation (km)')
% Subplot 2
subplot(1, 2, 2)
% Create an array of all zeros
P = zeros(np,1);
gR = g/R;
gg = @(h, z, TC) (1./spline(z, TC+273.15, h));
for k = 1:np;
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
