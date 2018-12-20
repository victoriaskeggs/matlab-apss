m1 = 10; %kg, sat
m2 = 1; %kg, weight
r1 = 400000; %m, rad of sat end from earth center
L = 100; %m, length of tether
rho = 9.8*10^-5; %kg/m, linear density of tether
mu = 3.986004418*10^14; %earth grav parameter

mT = rho*L; %mass of tether

r2 = r1-L;   %radius of weight from earth center
rT = (r1+r2)/2; %radius of tether CoM from earth center
r0 = (m1*r1 + m2*r2 + mT*rT)/(m1+m2+mT); %radius of CoM from earth center

omega = sqrt(mu/r0^3) %angular velocity of the sat

T1 = m1*r1*omega^2 - mu*m1/r1^2 %tension at sat end
T2 = mu*m2/r2^2 - m2*r2*omega^2  %tension at weight end

%tension in cable 
r = linspace(r2,r1,100);
c = T1 + r1^2*omega^2*rho/2 + mu*rho/r1;
T = -r.^2 * omega^2 * rho / 2 - mu * rho ./ r + c

plot(r,T)

