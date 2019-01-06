function [ theta ] = angleOfTetherTowardsEarthEstimate( thetaEstimate, r )
% This function uses an equation derived using finite element analysis to
% produce an estimate for the angle the tether makes at a specified radius.

% Input:    thetaEstimate   an estimate for the angle the tether makes (in
%                           radians)
%           r               radius to determine angle at (distance from the earth
%                           in metres)
% Output:   theta           a better estimate for the angle the tether 
%                           makes (in radians)

% TODO: get default values for atmospheric density etc

% Lorentz force components
F_xL = 0.2475e-6;
F_yL = 0;

p_at = 3.89e-12; % atmospheric density
cd = 2.2; % drag constant
w = 1.13e-3; %angular speed
d = 0.5e-3 ; % diameter of tether
mu = 3.986e14; % gravitational constant and mass of earth
p_cable = 0.00053; % density of cable

% gravitational force
F_g = (-mu * p_cable)/r^2;
% drag force
F_drag = 0.5 * p_at * cd * r^2 *w^2 * d * cos(thetaEstimate)/tan(thetaEstimate);
% centripetal force
F_centr = w^2 * r * p_cable;

theta = atan(F_xL/(F_drag - F_g + F_yL + F_centr));

end

