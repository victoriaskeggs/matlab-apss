function [ maxCurrents ] = retrieveMaxCurrentsFor( lengths, loadVoltages )
% This function runs the Java orbital simulation for tethers with every 
% combination of given length and load voltage. It returns the maximum 
% current induced along each tether over an orbit. All orbital
% characteristics besides length and load voltage are assumed as default.

% Inputs:   lengths         an array of tether lengths to test
%           loadVoltages    an array of voltage loads on the tether
% Output:   maxCurrents     a 2D array of maximum current for each length
%                           and load voltage combination

SIMULATION_TIME = 1.5;  % time to run the simulation in hours
TIME_STEP = 1000;       % timestep for the simulation in ms
CATHODE_VOLTAGE = 200;  % voltage of cathode
HUGE_MASS = 10000;      % stop the satellite crashing into the earth

settings = getDefaultSimulatorValues();
settings.mass = HUGE_MASS;
maxCurrents = zeros(length(lengths), length(loadVoltages));

% Run the simulation for each load voltage and tether length
% Populate maximum currents through the tether
for i = 1:length(lengths)
    for j = 1:length(loadVoltages)
        settings.length = lengths(i);
        settings.bias = CATHODE_VOLTAGE - loadVoltages(j);
        states = simulate(settings, TIME_STEP, SIMULATION_TIME);
        maxCurrents(i, j) = max([states.current]);
    end
end

end

