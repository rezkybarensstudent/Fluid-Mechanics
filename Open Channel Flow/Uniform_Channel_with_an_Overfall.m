% Example 11.11 Uniform channel with an overfall
function Example11_11
g = 9.81;
m = 0.6667;
b = 3.0;
n = 0.025;
Q = 30.0;
hold on
for slope = [0.0010:0.0005:0.0025]
    y0 = fzero(@Manning, 6, [], Q, n, b, m, slope);
    yc = fzero(@Q26, 3, [], Q, g, b, m);
    [y, x] = ode45(@dchannel, [yc, 0.975*y0], 0, [], yc, y0, slope);
    plot(x, y, 'k-')
    if slope == 0.001
        text(x(end), y(end)+0.05, ['S_0 = ' num2str(slope, '%6.4f') ', y_0 = ' ...
            num2str(y0, 4) ' m'], 'HorizontalAlignment', 'Left')
    else
        text(x(end)-30, y(end), ['S_0 = ' num2str(slope, '%6.4f') ', y_0 = ' ...
            num2str(y0, 4) ' m'], 'HorizontalAlignment', 'Right')
    end
end
axis([-900, 0, 1, 2.2])
xlabel('x (m)')
ylabel('Water depth, y (m)')
function dydx = dchannel(y, x, yc, y0, slope)
dydx(1) = 1/slope*(1-(yc/y(1))^3)/(1-(y0/y(1))^(10/3));
function A = Manning(y, Q, n, b, m, slope)
A = Q-1.0/n*b*y*(2+y/(b*m))*(b*y*(2+y/(b*m))/(2*(b+y*sqrt(1+1/m^2))))^0.667*slope^0.5;
function B = Q26(y, Q, g, b, m)
B = Q^2-g*(b*y*(2+y/(b*m)))^3/(2*b+2*y/m);
