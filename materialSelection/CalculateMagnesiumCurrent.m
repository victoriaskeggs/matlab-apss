% Calculate current in 1800m long magnesium alloy tether. 0.35mm diameter.

% Override defaults where neccessary
settings = getDefaultSimulatorValues();
settings.diameter = 0.35e-3; % m
settings.length = 1800; % m
settings.conductivity = 1/43.9e-9; % S/m
settings.bias = 50;
settings.mass = 1000000;

% Run the simulation program
timeToSimulate = 6; % time in hours
states = simulate(settings, 1000, timeToSimulate);

% Retrieve the currents at each state simulated
currents = arrayfun(@(state) state.current, states);

disp(max(currents))
% max current is 0.2942 A