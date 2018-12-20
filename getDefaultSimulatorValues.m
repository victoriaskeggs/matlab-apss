function values = getDefaultSimulatorValues
    values = struct( ...
        'mass', 1.3, ...            % kg, this is the maximum allowable mass of the system
        'massOfWeight', 0.05, ...   % kg
        'maxTetherMass', 0.3, ...   % kg
        'diameter', 0.5*10^-3, ...  % m
        'length', 200, ...          % m
        'cubesatLength', 0.01, ...  % m
        'density', 3000, ...        % kg/m^3
        'bias', 0, ...              % V
        'towardsEarth', false, ...  % boolean
        'conductivity', 3*10^7, ... % ohm-1 m-1
        'eccentricity', 0, ...      % 1
        'sma', 6.771*10^6, ...      % m
        'inclination', 0, ...       % radians from polar
        'argOfPeriapsis', 0, ...    % radians
        'trueAnomaly', 0, ...       % radians
        'longOfAscendingNode', 0);  % radians
end

