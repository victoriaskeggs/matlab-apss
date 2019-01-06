function deltaTemp = deltaTsun(s, m, D, l, Hearth, period, t) 

SAsunfacing = D*l; %m^2, sun facing surface area of tether
Psun = Hearth*SAsunfacing; %W, power due to sun heating

if mod(floor(t * 2 / period), 2) == 1
    deltaTemp = 0;
else
    deltaTemp = Psun / s / m; %degrees/s, increase in temp due to sun per time
end

