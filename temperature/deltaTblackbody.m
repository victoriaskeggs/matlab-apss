function deltaTemp = deltaTblackbody(s, T, SA, m, sigma)
% This function calculates the change in temperature of a blackbody.

deltaTemp = sigma*T^4*SA/s/m;