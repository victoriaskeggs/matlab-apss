function deltaTemp = deltaTcurrent(s, m, Ac, Re, l, I) 

R = Re*l/Ac; %ohms, resistance of tether
Pcurrent = I^2*R; %W, power due to current

deltaTemp = Pcurrent / s / m; %degrees/s, increase in temp due to current per time