function deltaTemp = deltaTblackbody(s, T, SA, m, sigma) 

deltaTemp = sigma*T^4*SA/s/m;