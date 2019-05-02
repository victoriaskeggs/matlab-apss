function maxStress = calculateMaxStress(diameter, density, L, massOfSat, massOfWeight)
% This function finds the maximum stress in the tether (Pa)

m1 = massOfSat; %kg, sat
m2 = massOfWeight; %kg, weight
r1 = 400000; %m, rad of sat end from earth center
rho = density .* pi ./ 4 .* diameter .^ 2; %kg/m, linear density of tether
mu = 3.986004418e14; %earth grav parameter

mT = rho .* L; %mass of tether

r2 = r1 - L;   %radius of weight from earth center
rT = (r1 + r2) ./ 2; %radius of tether CoM from earth center
r0 = (m1 .* r1 + m2 .* r2 + mT .* rT) ./ (m1+m2+mT); %radius of CoM from earth center

omega = sqrt(mu ./ r0 .^ 3); %angular velocity of the sat

T1 = m1 .* r1 .* omega .^ 2 - mu .* m1 ./ r1 .^ 2; %tension at sat end
T2 = mu .* m2 ./ r2 .^ 2 - m2 .* r2 .* omega .^ 2;  %tension at weight end

%tension in cable
r = repmat(linspace(0, 1)', size(r2)) .* (r1 - r2) + r2;
c = T1 + r1 .^ 2 .* omega .^ 2 .* rho ./ 2 + mu .* rho ./ r1;
T = -r .^ 2 .* omega .^ 2 .* rho ./ 2 - mu .* rho ./ r + c;
stress = T ./ (pi ./ 4 .* diameter .^ 2);

maxStress = max(stress);