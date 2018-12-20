function [ dt ] = CalculateDeltaTension( theta, r, dr )

% Lorentz force components
F_xL = 0.2475e-6;

p_at = 3.89e-12; % atmospheric density
cd = 2.2; % drag constant
w = 1.13e-3; %angular speed
d = 0.5e-3 ; % diameter of tether

dt = 0.5 * p_at * cd * (r * w)^2 * d * dr * cd / sin( theta ) ...
    - F_xL * dr / ( cos(theta) * sin(theta) );

end