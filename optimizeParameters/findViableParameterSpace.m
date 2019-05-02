function [parameterViabilityMatrix] = findViableParameterSpace(maxVolume, maxWeight, density, maxDiameter, maxLength, massOfSat, massOfWeight, yieldStrength, yieldSafetyFactor)

numLengthsToCheck = 2000;
numDiametersToCheck = 2000;

parameterViabilityMatrix = zeros(numLengthsToCheck, numDiametersToCheck);
[survivalL, survivalD] = ingestSurvivabilityData('probabilities.csv', 0.9);

for i = 1:numLengthsToCheck
    lengthToCheck = i*maxLength/numLengthsToCheck;
    
    if lengthToCheck < min(survivalL)
        minimumDiameter = survivalD(1);
    elseif lengthToCheck > max(survivalL)
        minimumDiameter = survivalD(end);
    else
        minimumDiameter = interp1(survivalL, survivalD, lengthToCheck);
    end
    
    for j = 1:numDiametersToCheck
        diameterToCheck = j*maxDiameter/numDiametersToCheck;
        
        volume = calculateVolume(lengthToCheck, diameterToCheck);
        weight = calculateWeight(lengthToCheck, diameterToCheck, density);
        maxStressInTether = calculateMaxStress(diameterToCheck, density, lengthToCheck, massOfSat, massOfWeight);
        
        underMaxVolume = volume < maxVolume;
        underMaxWeight = weight < maxWeight;
        underYieldStrength = maxStressInTether < (yieldStrength/yieldSafetyFactor);
        
        if underMaxVolume && underMaxWeight && underYieldStrength && (diameterToCheck >= minimumDiameter)
            parameterViabilityMatrix(i, j) = true;
        end
    end
end

imagesc(parameterViabilityMatrix);          
colormap(gray);                              
set(gca,'YDir','normal')

ax = gca;
ax.XTickLabel = ax.XTick*maxDiameter/numDiametersToCheck*1000;
ax.YTickLabel = ax.YTick*maxLength/numLengthsToCheck;

xlabel('Diameter (mm)')
ylabel('Length (m)')
title('Valid Parameter Space For Tether')