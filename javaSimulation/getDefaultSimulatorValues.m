function values = getDefaultSimulatorValues
% This function returns a struct containing the default values of the
% satellite system.

    values = struct( ...
        'mass', 1.3, ...            % kg, this is the maximum allowable mass of the system
        'massOfWeight', 0.05, ...   % kg
        'maxTetherMass', 0.3, ...   % kg
        'diameter', 0.43e-3, ...  % m
        'length', 364, ...          % m
        'cubesatLength', 0.01, ...  % m
        'density', 3000, ...        % kg/m^3
        'bias', 25, ...              % V
        'towardsEarth', true, ...  % boolean
        'conductivity', 19.7e6, ... % ohm-1 m-1
        'eccentricity', 0, ...      % 1
        'sma', 6.771*10^6, ...      % m
        'inclination', 81 / 360 * 2 * pi, ...       % radians
        'argOfPeriapsis', 0, ...    % radians
        'trueAnomaly', 0, ...       % radians
        'longOfAscendingNode', 0);  % radians
end

