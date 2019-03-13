function [ chosenSettings, maximumForce ] = calculateOptimalParameters( ...
    inputSettings, ...
    massLimit, volumeLimit, powerLimit, currentLimit, minimumSurvivalPercentage, strengthSafetyFactor, ...
    maximumDiameter, minimumDiameter, maximumStress)
%CALCULATEOPTIMALPARAMETERS Computes all tether input parameters.
%   This performs a binary search for the maximum length limit taking into
%   account all of the limits. Then the sample space is searched for the
%   optimal maximum force value.

N = 200;

[ survivalL, survivalD ] = ingestSurvivabilityData('probabilities.csv', minimumSurvivalPercentage);

% Compute the maxLength based on mass and volume
combinedVolLimit = min(volumeLimit, massLimit / inputSettings.density);

diameters = linspace(minimumDiameter, maximumDiameter, N);

% Compute the survival limit
minSurvivalD = min(survivalD);
maxSurvivalD = max(survivalD);

low = diameters < minSurvivalD;
high = diameters > maxSurvivalD;
inRange = ~low & ~high;

% Limited by volume / mass
lengths = combinedVolLimit ./ (pi .* diameters .^ 2 ./ 4);

% Limited by survival and / or volume / mass
lengths(inRange) = min(...
    lengths(inRange), ...
    interp1(survivalD, survivalL, diameters(inRange))...
    );

% For each of those points, find the strength limit
stress = calculateMaxStress(diameters, inputSettings.density, lengths, ...
    inputSettings.mass - inputSettings.maxTetherMass - inputSettings.massOfWeight, inputSettings.massOfWeight);
overStress = (stress .* strengthSafetyFactor) > maximumStress;

% Binary search, WITH VECTORS, TAKE THAT MATLAB
maxLengths = lengths(overStress);
minLengths = zeros(size(maxLengths));
overStressDiameters = diameters(overStress);

for i = 1:50
    mid = (maxLengths + minLengths) ./ 2;
    stress = calculateMaxStress(overStressDiameters, inputSettings.density, mid, ...
        inputSettings.mass - inputSettings.maxTetherMass - inputSettings.massOfWeight, inputSettings.massOfWeight);
    test = (stress .* strengthSafetyFactor) > maximumStress;
    
    minLengths(test) = mid(test);
    maxLengths(~test) = mid(~test);
end

figure;
title("Largest possible length");
plot(diameters .* 1000, lengths);
xlabel("Diameter (mm)");
ylabel("Length (m)");

lengths(overStress) = (maxLengths + minLengths) ./ 2;

% Maximum force is always found at maximum length
[bestLength, maxIndex] = max(lengths);
bestDiam = diameters(maxIndex);

inputSettings = inputSettings;
inputSettings.length = bestLength;
inputSettings.diameter = bestDiam;

[maximumForce, chosenSettings] = findForceFromSize(inputSettings, powerLimit, currentLimit);

end