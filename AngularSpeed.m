function rev = AngularSpeed(T_net)
% This script calculates the minimum maximum angular orbital speed that the
% satellite will need to rotate at in order to keep spinning past the point
% of maximum torque.

% Define constants
d = 0.0005; % diameter of the tether (m)
density = 0.0012; % linear density of the cubesat (kg/m)
m_cube = 1.2; % mass of the cubesat (kg)
L_cube = 0.01; % length of cube (m)
L_tether = 200; % length of the tether (m)
m_tether_1 = density * L_tether; % mass of the tether

% Inertia of a cube rotating about its centre of mass
I_cube_com = m_cube*L_cube^2/6;

% Intertia of a cube rotating about the centre of mass of the system
I_cube = I_cube_com + m_cube*d^2;

% Inertia of the tether
I_tether = m_tether_1*L_tether^2/3;

% Total inertia of the system
I = I_cube_com + I_cube + I_tether;

% Max angular speed for spin
wmax = sqrt(2*pi()*T_net/I); % rad s-1

% Calculate revolutions per orbit (revs per 90 mins)
rev = wmax*60*90/(2*pi());

end

