function rev = calculateAngularSpeed(values, timestep)
% This script calculates the minimum maximum angular orbital speed that the
% satellite will need to rotate at in order to keep spinning past the point
% of maximum torque.

% Input:    values      a struct containing satellite properties
%           timestep    period of time between two internal states of the
%                       simulation (in ms) - around 1000
% Output:   rev         the angular speed of the tether in revolutions per minute

% Find the maximum torque from the system
TIME_TO_SIMULATE = 6; % time in hours
states = simulate(values, timestep, TIME_TO_SIMULATE);
T_net = max(arrayfun(@(state) state.netTorque.length(), states));

% Define constants
d = values.diameter; % diameter of the tether (m)
l_density = values.density * pi * (d/2)^2; % linear density of the cubesat (kg/m)
m_cube = values.mass - values.maxTetherMass - values.massOfWeight; % mass of the cubesat (kg)
l_cube = values.cubesatLength; % length of cube (m)
m_tether = values.length * l_density; % mass of the tether (kg)

% COM of the system - distance from the centre of mass of the cubesat to
% the centre of mass of the system
com = (l_cube + values.length)*(m_tether / ( 2 * (m_cube + m_tether)));

% Inertia of a cube rotating about its centre of mass
I_cube_com = m_cube*l_cube^2/6;

% Intertia of a cube rotating about the centre of mass of the system
I_cube = I_cube_com + m_cube*com^2;

% Inertia of the tether - assumes tether is straight
x = com - l_cube/2; % distance from the point where the tether joins the 
                    % CubeSat to the centre of mass of the system
I_tether = l_density * ((values.length - x)^3 + x^3)/3;

% Total inertia of the system
I = I_cube_com + I_cube + I_tether;

% Max angular speed for spin
wmax = sqrt(2*pi()*T_net/I); % rad s-1

% Calculate revolutions per orbit (revs per 90 mins)
rev = wmax*60*90/(2*pi());

end