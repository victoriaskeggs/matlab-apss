function maxLength = findMaxLength(yieldStrength, diameter, density, massOfSat, massOfWeight)
% This function calculates the maximum length the tether could be. The
% tether's length is constrained such that the tension in the cable will
% not exceed its yield stress (with a safety factor), the mass of the cable
% will not exceed a maximum allowed mass and the volume of the cable will
% not exceed what can fit in the deployment mechanism.

% Find max volume and mass of the cable
currentMaxStress = 0;
safetyFactor = 4;
currentLength = 1;
maxAllowedMass = 0.3;
tetherMass = 0;
[maxLength, ~] = calculateMaxLengthDueToVolume(diameter);

% Increase the length of the tether until one of the conditions is violated
while currentMaxStress*safetyFactor < yieldStrength && tetherMass <= maxAllowedMass && currentLength < maxLength
    
    currentMaxStress = findMaxStress(diameter, density, currentLength, massOfSat, massOfWeight);    
    currentLength = currentLength + 1;
    tetherMass = pi/4 * diameter^2 * currentLength * density;
    
end

maxLength = currentLength;

end
