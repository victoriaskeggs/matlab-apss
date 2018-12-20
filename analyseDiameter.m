N = 100;

diameter = linspace(10^-4, 10^-2, N);

blankStruct = struct('current', 0, 'force', 0, 'power', 0);

maximumValue = repmat(blankStruct, 1, N);
meanValue = repmat(blankStruct, 1, N);

for i = 1:N
    settings = getDefaultSimulatorValues();
    settings.diameter = diameter(i);
    
    [maximumValue(i), meanValue(i)] = stats(simulate(settings, 1000));
end

figure;
semilogx(diameter, [maximumValue.power; meanValue.power]);
title 'Power disapated by the tether, 200m, no bias applied.'
legend('max power', 'mean power')
xlabel('Diameter (m)')
ylabel('Power (W)')