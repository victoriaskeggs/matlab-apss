function [states] = simulate(settings, simTimestep)
% Takes a settings struct, converts it into the Java objects needed to run the
% simulation. 

% This function then takes the output from the Java code and
% converts it into an array of structs, each struct holding the state of
% the satellite at that time.

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

rawOutput = APSSSimulator.runHeadlessSimulation(satellite, orbitCharacteristics, ...
    Duration.ofHours(6), Duration.ofSeconds(5), Duration.ofMillis(simTimestep));

matrix = toArray(rawOutput);
states = arrayfun(@struct, matrix)';

end
