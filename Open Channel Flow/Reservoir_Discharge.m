% Example 11.12 Reservoir discharge
function Example11_12
yr = 3.0;
g = 9.81;
b = 1.5;
m = 30;
S0 = 0.001;
n = 0.014;
yw = linspace(0, yr, 100);
Qbernoulli = sqrt(2*g*b^2*(yr-yw).*(2*yw+yw.^2/(b*m)).^2);
plot(Qbernoulli, yw, 'k-')
hold on
axis([0, 30, 0, 3.0])
xlabel('Volume flow rate, Q (m^3/s)')
ylabel('y_w (m)')
A = b*yw.*(2+yw/(b*m));
P = 2*(b+yw*sqrt(1+1/m^2));
Rh = A./P;
Qmanning = A.*(Rh.^0.6666*sqrt(S0))/n;
plot(Qmanning, yw, 'k--');
legend('Bernoulli Eqn.', 'Manning Eqn.', 'Location', 'SouthEast')
ywflow = fzero(@Q2526, [8.5*0.3048, 9.5*0.3048], [], b, m, S0, n, g, yr);
Awflow = b*ywflow*(2+ywflow/(b*m));
Qflow = Awflow*sqrt(2*g*(yr-ywflow));
text(5, 2.7, 'Subcritical Flow')
text(5, 2.5, ['Q = ' num2str(Qflow, 4) ' m^3/s'])
text(5, 2.3, ['y_{w} = ' num2str(ywflow, 4) ' m'] )
plot(Qflow, ywflow, 'ks')
ywcrit = fzero(@Q12, 6, [], b, m, yr);
Awcrit = b*ywcrit*(2+ywcrit/(b*m));
Qcrit = Awcrit*sqrt(2*g*(yr-ywcrit));
text(18, 2.2, 'Critical Flow Point')
text(19, 2.0, ['Q_{c} = ' num2str(Qcrit, 4) ' m^3/s'])
text(19, 1.8, ['y_{wc} = ' num2str(ywcrit, 4) ' m'] )
plot(Qcrit, ywcrit, 'ks')
function A = Q2526(y, b, m, S0, n, g, yr)
A = (b*y*(2+y/(b*m)))*(((b*y*(2+y/(b*m)))...
/(2*(b+y*sqrt(1+1/m^2))))^0.6666*sqrt(S0))/n-...
sqrt(2*g*b^2*(yr-y)*(2*y+y^2/(b*m))^2);
function B = Q12(ywc, b, m, yr)
B = ywc+0.5*b*ywc*(2+ywc/(b*m))/(2*b+2*ywc/m)-yr;