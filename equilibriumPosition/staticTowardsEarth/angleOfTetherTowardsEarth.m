function [ theta ] = angleOfTetherTowardsEarth( r )
% This function iteratively converges upon the angle the tether makes at a 
% specified radius using an equation derived from finite element analysis.

% Input:    r       distance from earth to evaluate tether angle at (in metres)
% Output:   theta   the angle the tether makes (in radians)

% An initial estimate for the angle
theta = 0.1;

% Iteratively increase the accuracy of our estimate
for i = 1 : 1000 
    theta = angleOfTetherTowardsEarthEstimate(theta, r);
end

end