% Example 11.5 Flow rates from three connected reservoirs
function Example11_5
d = [0.3, 0.5, 0.4];
el = [1000, 4000, 2000];
k = [0.6, 0.6, 0.6]*1e-3;
h = [120, 100, 80];
hg = fzero(@ReservoirSumQ, 110, [], d, el, k, h);
[sq, q] = ReservoirSumQ(hg, d, el, k, h);
disp(['Elevation h_sub_p = ' num2str(hg) ' m'])
disp(['Q1 = ' num2str(q(1)) ' m^3/s Q2 = ' num2str(q(2))...
' m^3/s Q3 = ' num2str(q(3)) ' m^3/s'])
function [sq, q] = ReservoirSumQ(hg, d, el, k, h)
cv = 2*9.81*d./el;
ro = d/1.002e-6;
dk = d./k;
qd = 0.25*pi*d.^2;
frictguess = (2*log10(3.7*dk)).^-2;
hh = h-hg;
for n = 1:length(d)
    if hh(n) == 0
        q(n) = 0;
    else
        lambda = fzero(@ResFriction, frictguess(n), [], dk(n), hh(n), cv(n), ro(n));
        q(n) = sign(hh(n))*sqrt(cv(n)*abs(hh(n))/lambda)*qd(n);
    end
end
sq = sum(q);
function x = PipeFrictionCoeff(el, re, dk)
if dk>100000|dk == 0
    x = el-(2*log10(re*sqrt(el)/2.51))^-2;
else
    x = el-(2*log10(2.51/re/sqrt(el)+0.27/dk))^-2;
end
function lamb = ResFriction(lambda, dk, dh, cv, ro)
ren = sqrt(cv*abs(dh)/lambda)*ro;
lamb = PipeFrictionCoeff(lambda, ren, dk);