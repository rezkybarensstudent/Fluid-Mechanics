% Example 11.4 Flow rate in a pipe
function Example11_4
D = 0.04;
g = 9.81;
nu = 1.2e-6;
Re = fzero(@ColebrookFriction, [1e3, 1e7], [], nu, g, D);
disp(['Re = ', num2str(Re, 7)])
disp(['Flow Rate = ' num2str(pi*D*Re*nu/4, 4) ' m^3/s'])
function value = ColebrookFriction(Re, nu, g, D)
lambda = 2*g*D^3/(nu*Re)^2;
value = 1/sqrt(lambda)+2*log10(2.51/(Re*sqrt(lambda)));