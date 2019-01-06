% This script analyses how tether inclination affects power dissipated. It
% finds the maximum and average power dissipated by a 200m long tether 
% over a 6 hour period given various inclinations. This script tests the
% case where the tether is pointing towards earth and spinning across
% gravity.

N = 100;

inclinations = linspace(0, pi, N);

blankStruct = struct('current', 0, 'force', 0, 'power', 0);

velocityMax = repmat(blankStruct, 1, N);
velocityMean = repmat(blankStruct, 1, N);
gravityMax = repmat(blankStruct, 1, N);
gravityMean = repmat(blankStruct, 1, N);

% Run Java simulation program over a 6 hour period
% Retrieve average and maximum power dissipated in case where tether is
% pointing towards earth and case where tether is spinning across gravity
for i = 1:N
    settings = getDefaultSimulatorValues();
    
    settings.inclination = inclinations(i);
    settings.towardsEarth = false;
    
    [velocityMax(i), velocityMean(i)] = stats(simulate(settings, 1000));
    
    settings.towardsEarth = true;
    
    [gravityMax(i), gravityMean(i)] = stats(simulate(settings, 1000));
end

% Plot average and maximum power dissipated
figure;
plot(inclinations, [velocityMax.power; velocityMean.power; gravityMax.power; gravityMean.power]);
title 'Power disapated by the tether, 200m, no bias applied.'
legend('max power (spin)', 'mean power (spin)', 'max power (gravity)', 'mean power (gravity)')
xlabel('Deviation from polar (rad)')
ylabel('Power (W)')