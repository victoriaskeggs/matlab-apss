% This script analyses how tether conductivity affects power dissipated. It
% finds the maximum and average power dissipated by a 200m long tether 
% pointing towards earth over a 6 hour period given various conductivities.

% Number of conductivities to analyse
N = 100;

conductivity = logspace(5, 8, N);

blankStruct = struct('current', 0, 'force', 0, 'power', 0);

maximumValue = repmat(blankStruct, 1, N);
meanValue = repmat(blankStruct, 1, N);

% Run Java simulation program over a 6 hour period
% Retrieve average and maximum power dissipated
for i = 1:N
    settings = getDefaultSimulatorValues();
    settings.conductivity = conductivity(i);
    settings.bias = 50;
    
    [maximumValue(i), meanValue(i)] = stats(simulate(settings, 1000));
end

% Plot average and maximum power dissipated
figure;
semilogx(conductivity, [maximumValue.power; meanValue.power]);
title 'Power disapated by the tether, 200m, 0.5mm D, no bias applied.'
legend('max power', 'mean power')
xlabel('Conductivity (S / m)')
ylabel('Power (W)')