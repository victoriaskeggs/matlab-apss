function [parameterViabilityMatrix] = findViableParameterSpace(maxVolume, maxWeight, density, maxDiameter, maxLength, massOfSat, massOfWeight, yieldStrength, yieldSafetyFactor)

numLengthsToCheck = 1000;
numDiametersToCheck = 1000;

parameterViabilityMatrix = zeros(numLengthsToCheck, numDiametersToCheck);

for i = 1:numLengthsToCheck
    lengthToCheck = i*maxLength/numLengthsToCheck;
    for j = 1:numDiametersToCheck
        diameterToCheck = j*maxDiameter/numDiametersToCheck;
        
        volume = calculateVolume(lengthToCheck, diameterToCheck);
        weight = calculateWeight(lengthToCheck, diameterToCheck, density);
        maxStressInTether = calculateMaxStress(diameterToCheck, density, lengthToCheck, massOfSat, massOfWeight);
        
        underMaxVolume = volume < maxVolume;
        underMaxWeight = weight < maxWeight;
        underYieldStrength = maxStressInTether < (yieldStrength/yieldSafetyFactor);
        
        if underMaxVolume && underMaxWeight && underYieldStrength
            parameterViabilityMatrix(i, j) = true;
        end
    end
end

imagesc(parameterViabilityMatrix);          
colormap(gray);                              
set(gca,'YDir','normal')
ax = gca;
ax.XTickLabel = ax.XTick*maxDiameter/numDiametersToCheck*1000;
xlabel('Diameter (mm)')
ylabel('Length (m)')
title('Valid Parameter Space For Tether')