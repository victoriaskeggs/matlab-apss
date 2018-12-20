function [states] = simulate(settings, simTimestep)

%import brownshome.apss.* java.time.Duration
import brownshome.apss.* java.time.*

if settings.towardsEarth
    cableFunction = CableFunction.towardsGravity(settings.length);
else
    cableFunction = CableFunction.acrossVelocity(settings.length);
end

orbitCharacteristics = OrbitCharacteristics(settings.eccentricity, settings.sma, ...
    settings.inclination, settings.argOfPeriapsis, settings.trueAnomaly, settings.longOfAscendingNode);

satellite = Satellite(cableFunction, settings.bias, settings.mass, settings.diameter, settings.conductivity);

rawOutput = APSSSimulator.runHeadlessSimulation(satellite, orbitCharacteristics, ...
    Duration.ofHours(6), Duration.ofSeconds(5), Duration.ofMillis(simTimestep));

matrix = toArray(rawOutput);
states = arrayfun(@struct, matrix)';

end
