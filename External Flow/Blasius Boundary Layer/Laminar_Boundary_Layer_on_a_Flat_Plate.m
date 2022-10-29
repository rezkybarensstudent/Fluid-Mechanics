% Example 11.7 Laminar boundary layer on a flat plate
function Example11_7
solinit = bvpinit(linspace(0, 8, 9), @Blasiusguess);
sol = bvp4c(@Blasius, @Blasiusbc, solinit);
x = linspace(0, 8, 100);
y = deval(sol, x);
plot(x, y(1,:), 'k-', x, y(2,:), 'k--', x, y(3,:), 'k-.')
xlabel('\eta')
ylabel('f, df/d\eta, d^2f/d\eta^2')
legend('f', 'df/d\eta', 'd^2f/d\eta^2')
ylim([0 2.5])
disp(['d^2f(0)/dn^2 = ' num2str(y(3,1))])
function dydx = Blasius(x, y)
dydx = [y(2); y(3); -0.5*y(1)*y(3)];
function res = Blasiusbc(ya, yb)
res = [ya(1); ya(2); yb(2)-1];
function y = Blasiusguess(x)
y(1) = x;
y(2) = x^0.5;
y(3) = 5-x;