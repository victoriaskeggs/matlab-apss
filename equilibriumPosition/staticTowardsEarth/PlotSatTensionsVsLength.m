% This script plots the tension in the tether along the length of the
% tether.

% TODO: update constants to default simulator values

lengths = 0:1:2000;
N = length(lengths);
satTension = zeros(1, N);

%todo input the diameter of the tether for accurate mass. 
d = 0.0003; % m, diameter of the tether
mTotal = 1.3; %kg, sat
m2 = 0.05; %kg, weight
r1 = 400000; %m, rad of sat end from earth center
rho = 1738; %kg/m^3, density of Mg
A = (pi*d^2)/4; %m^2 cross sectional area of the tether assuming cylindrical
mu = 3.986004418*10^14; %earth grav parameter

% Length of the tether in metres
for i=1:N
    L = lengths(i);
    mT = rho*L*A; %mass of tether
    m1 = mTotal - mT - m2; % mass of the satellite without tether
    
    r2 = r1-L;   %radius of weight from earth center
    rT = (r1+r2)/2; %radius of tether CoM from earth center
    r0 = (m1*r1 + m2*r2 + mT*rT)/(m1+m2+mT); %radius of CoM from earth center
    
    omega = sqrt(mu/r0^3); %angular velocity of the sat
    
    satTension(i) = m1*r1*omega^2 - mu*m1/r1^2; %tension at sat end
end

close()
plot(lengths, satTension)
title("Tension on Satellite End of Tether vs Length")
xlabel("Lengths (m)")
ylabel("Tension at Satellite End (N)")
