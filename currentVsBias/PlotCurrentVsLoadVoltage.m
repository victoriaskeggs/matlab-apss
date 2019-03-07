% This script runs the Java orbital simulation and retrieves the maximum
% currents through the tether at different load voltages and tether
% lengths. The currents are plotted on a surface plot.

% Combinations to test
LENGTHS = [200, 400, 600, 800, 1000];
LOAD_VOLTAGES = linspace(0, 200, 50);
MILLIAMPS_IN_AMPS = 1000;

% Retrieve maximum currents from every length and load voltage combination
maxCurrents = retrieveMaxCurrentsFor(LENGTHS, LOAD_VOLTAGES);

% Produce a surface plot
figure(1)
clear figure
[loadVoltages, lengths] = meshgrid(LOAD_VOLTAGES, LENGTHS);
surf(lengths, loadVoltages, maxCurrents.*MILLIAMPS_IN_AMPS)
xlabel('Tether length (m)')
ylabel('Load voltage (V)')
zlabel('Max current along tether (mA)')
title('Max current along tether vs tether lengths and load voltage')

% Produce a 2D plot
figure(2)
clear figure
for i = 1:length(LENGTHS)
    plot(LOAD_VOLTAGES, maxCurrents(i, :).*MILLIAMPS_IN_AMPS)
    hold on
end

% Add labels and title to 2D plot
xlabel('Load voltage (V)')
ylabel('Max current along tether (mA)')
title('Max current along tether vs load voltage')
legend('200m tether', '400m tether', '600m tether', '800m tether', '1000m tether')

% Make a series of 2D plots
for i = 1:length(LENGTHS)
    figure(i+2)
    clear figure
    plot(LOAD_VOLTAGES, maxCurrents(i, :).*MILLIAMPS_IN_AMPS)
    
    % Add labels and title to 2D plot
    xlabel('Load voltage (V)')
    ylabel('Max current along tether (mA)')
    theLength = num2str(LENGTHS(i));
    title(strcat('Max current along tether vs load voltage for tether with length ', theLength))
end