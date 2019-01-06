function [] = plotLengthVersusDiameter(yieldStrength, density, massOfSat, massOfWeight)
% This script plots the maximum length a tether with specified properties
% could sustain at various diameters.

% Input:    yieldStrength   yield strength of the tether material (Pa)
%           density         density of the tether (kg/m^3)
%           massOfSat       mass of the cube (kg)
%           massOfWeight    mass of the weight at the end of tether (kg)

lengths = zeros(100, 1);
diameters = linspace(0.01*10^-3, 1*10^-3, 100);

for i = 1:length(diameters)
    lengths(i) = findMaxLength(yieldStrength, diameters(i), density, massOfSat, massOfWeight);
end

plot(diameters, lengths)