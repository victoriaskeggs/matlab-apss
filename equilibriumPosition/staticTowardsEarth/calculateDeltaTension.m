function [ dt ] = calculateDeltaTension( theta, r, dr )
% This function calculates the tension gradient between two very close 
% points on the tether.

% Input:    theta   the angle between the two points on the tether
%           r       distance from earth the two points are at (m)

% TODO: get default values

% Lorentz force components
F_xL = 0.2475e-6;

p_at = 3.89e-12; % atmospheric density
cd = 2.2; % drag constant
w = 1.13e-3; %angular speed
d = 0.5e-3 ; % diameter of tether

dt = 0.5 * p_at * cd * (r * w)^2 * d * dr * cd / sin( theta ) ...
    - F_xL * dr / ( cos(theta) * sin(theta) );

end