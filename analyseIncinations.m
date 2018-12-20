N = 100;

inclinations = linspace(0, pi, N);

blankStruct = struct('current', 0, 'force', 0, 'power', 0);

velocityMax = repmat(blankStruct, 1, N);
velocityMean = repmat(blankStruct, 1, N);
gravityMax = repmat(blankStruct, 1, N);
gravityMean = repmat(blankStruct, 1, N);

for i = 1:N
    settings = getDefaultSimulatorValues();
    
    settings.inclination = inclinations(i);
    settings.towardsEarth = false;
    
    [velocityMax(i), velocityMean(i)] = stats(simulate(settings, 1000));
    
    settings.towardsEarth = true;
    
    [gravityMax(i), gravityMean(i)] = stats(simulate(settings, 1000));
end

figure;
plot(inclinations, [velocityMax.power; velocityMean.power; gravityMax.power; gravityMean.power]);
title 'Power disapated by the tether, 200m, no bias applied.'
legend('max power (spin)', 'mean power (spin)', 'max power (gravity)', 'mean power (gravity)')
xlabel('Deviation from polar (rad)')
ylabel('Power (W)')