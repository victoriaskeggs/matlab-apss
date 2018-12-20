function [] = plotLengthVersusDiameter(yieldStrength, density, massOfSat, massOfWeight)

lengths = zeros(100, 1);
diameters = linspace(0.01*10^-3, 1*10^-3, 100);

for i = 1:length(diameters)
    lengths(i) = findMaxLength(yieldStrength, diameters(i), density, massOfSat, massOfWeight);
end

plot(diameters, lengths)