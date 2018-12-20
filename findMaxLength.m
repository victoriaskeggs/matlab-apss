function maxLength = findMaxLength(yieldStrength, diameter, density, massOfSat, massOfWeight)

currentMaxStress = 0;
safetyFactor = 4;
currentLength = 1;
maxAllowedMass = 0.3;
tetherMass = 0;
[maxLength, ~] = CalculateMaxLengthDueToVolume(diameter);

while currentMaxStress*safetyFactor < yieldStrength && tetherMass <= maxAllowedMass && currentLength < maxLength
    currentMaxStress = findMaxStress(diameter, density, currentLength, massOfSat, massOfWeight);    
    currentLength = currentLength + 1;
    tetherMass = pi/4 * diameter^2 * currentLength * density;
end

maxLength = currentLength;

end
