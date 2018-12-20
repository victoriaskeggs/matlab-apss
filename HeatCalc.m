%input parameters
%constants
sigma = 5.67*10^-8; %W/m^2.K^4, Stefan-Boltzmann constant
Hsun = 64*10^6; %W/m^2, power density at the sun's surface
Rearth = 150*10^9; %m, distance of earth from sun's center
Rsun = 695*10^6; %m, radius of sun
Hearth = Hsun * Rsun^2/Rearth^2; %W/m^2, power density at earth's distance

%dependent on material
rho = 2700; %g/m^3, density 
s = 0.902*1000; %J/kgC, heat capacity of aluminium
Re = 2.65*10^-8; %Ohm.m, resistivity in wire

%dependent on tether dimensions
D = 0.5*10^-3; %m, diameter of tether
l = 100; %m, length of tether
Ac = pi / 4 * D^2; %m^2, cross sectional area
V =  Ac * l; %m^3, volume of tether
m = rho * V; %kg, mass of tether
SA = pi*D*l; %m^2, surface area of tether, not including ends.

%conditions
T0 = 280; %K, initial temperature
I = 30*10^-3; %A, current in tether
period = 7200; %s, orbital period
%-------------------------------------------------

tspan = [0 period*2];

[t,T] = ode45(@(t,T) deltaTcurrent(s, m, Ac, Re, l, I) + deltaTsun(s, m, D, l, Hearth, period, t) - deltaTblackbody(s, T, SA, m, sigma), tspan, T0);

figure

plot(t, T)
axis([0 period*2 0 400])
title('Heat of cable over time')
xlabel('Time from intial condition (s)')
ylabel('Temperature (K)')




