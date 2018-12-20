% This script calculates the power dissipated by the tether for a range
% of diameters and materials. The length used is the longest length the 
% tether can sustain without surpassing yield stress at the given diameter.

% Constants
minDiameter = 0.1e-3; % 0.2mm
maxDiameter = 1e-3; % 2mm
numDiameters = 20;
ridiculousMass = 1000000; % kg - keeps the satellite in the same trajectory

% Satellite parameters
settings = getDefaultSimulatorValues();
massOfSat = settings.cubesatMass; % kg
massOfWeight = 0.05; % kg

% Material properties
materials = {'Aluminium Alloys', 'Magnesium Alloys', 'Nickel Alloys', 'Titanium Alloys', 'Copper Alloys', 'Zinc ALloys'}; % TODO
conductivities = [1/40e-9, 1/43.9e-9, 1/59e-9, 1/420e-9, 1/17e-9, 1/59e-9]; % S/m TODO
yieldStrengths = [300e6, 250e6, 600e6, 700e6, 270e6, 300e6]; % Pa TODO
densities = [2700, 1800, 8900, 4600, 8935, 6000]; % kg/m^3 TODO
diameters = linspace(minDiameter, maxDiameter, numDiameters); % m

% Calculate best length for each material at each diameter
lengths = zeros(length(materials), numDiameters);

% Store the results
powers = zeros(length(materials), numDiameters);

for i = 1 : length(materials)
   for j = 1 : numDiameters 
       lengths(i, j) = findMaxLength(yieldStrengths(i), diameters(j), densities(i), massOfSat, massOfWeight);
   end
end

% Empty arrays for max and min current, force and power dissipated
% TODO: change the struct to store multiple materials' worth of info
blankStruct = struct('current', 0, 'force', 0, 'power', 0);
maximumValue = repmat(blankStruct, 1, length(diameters));
meanValue = repmat(blankStruct, 1, length(diameters));

% Calculate max and min current, force and power dissipated for each
% material at each diameter
for i = 1 : length(materials)
    for j = 1 : numDiameters
        
        % Override defaults where neccessary
        settings.diameter = diameters(j);
        settings.length = lengths(i, j);
        settings.conductivity = conductivities(i);
        settings.bias = 50;
        settings.mass = ridiculousMass;
        
        [maximumValue(j), meanValue(j)] = stats(simulate(settings, 1000));
    end
    
    % Plot power dissipated for the material
    hold on
    semilogx(diameters, [meanValue.power]);
    powers(i, :) = [meanValue.power];
    
end

% Plot labels and legend
title 'Power dissipated by the tether, no bias applied, over six hours'
legend('max power', 'mean power')
xlabel('Diameter (m)')
ylabel('Power (W)')
legend(materials)
