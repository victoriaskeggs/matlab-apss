function [states] = simulate(settings, simTimestep, timeToRun)
% This function runs the Java orbital simulation for a given time period
% and retrieves data such as current, voltage, accerelation etc.

% Inputs:   settings    a struct containing orbital characteristics
%           simTimestep period of time between two internal states of the
%                       simulation (in ms) - around 1000
%           timeToRun   time in hours in run the simulation for
% Output:   states      an array of structs containing information about
%                       the state of the satellite at a given time

import brownshome.apss.* java.time.*

if settings.towardsEarth
    cableFunction = CableFunction.towardsGravity(settings.length);
else
    cableFunction = CableFunction.acrossVelocity(settings.length);
end

orbitCharacteristics = OrbitCharacteristics(settings.eccentricity, settings.sma, ...
    settings.inclination, settings.argOfPeriapsis, settings.trueAnomaly, settings.longOfAscendingNode);

satellite = Satellite(cableFunction, settings.bias, settings.mass, ...
    settings.diameter, settings.conductivity, settings.density);

% Runs the simulation for timeToRun hours, with a sampling period of 5
% seconds and a timestep of simTimeStep
rawOutput = APSSSimulator.runHeadlessSimulation(satellite, orbitCharacteristics, ...
    Duration.ofHours(timeToRun), Duration.ofSeconds(5), Duration.ofMillis(simTimestep));

matrix = toArray(rawOutput);
states = arrayfun(@struct, matrix)';

end
