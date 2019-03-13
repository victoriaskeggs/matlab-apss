% For a tether of given length and diameter, use an exponential search to
% find the maximum allowable bias and its associated Lorentz force.

function [maxForce, settings] = findForceFromSize(inputSettings, maxPower, maxCurrent) 

% Number of iterations to run binary search
numIterations = 10;

settings = inputSettings;
settings.mass = 1e6; % Stop the satelite from moving under the action of the tether

% Initial estimate for a bias that is too large.
maxBias = 10;
minBias = -10;

while true
    % Run the simulation given the new maximum bias
    settings.bias = maxBias;
    states = simulate(settings, 10000);
    
    % Extract the maximum Lorentz force calculated for this simulation
    extractedStates = stats(states);
    
    usedPower = extractedStates.current * settings.bias;
    
    % If condition holds, upper threshold has been found
    if (extractedStates.current > maxCurrent || usedPower > maxPower || maxBias > 1000)
        break;
    end
    
    % Grow the maximum bias exponentially to find an upper threshold for
    % the binary search
    maxBias = maxBias * 2;
end

while true
    % Run the simulation given the new maximum bias
    settings.bias = minBias;
    states = simulate(settings, 1000);
    
    % Extract the maximum Lorentz force calculated for this simulation
    extractedStates = stats(states);
    
    usedPower = extractedStates.current * settings.bias;
    
    % If condition holds, upper threshold has been found
    if (extractedStates.current < maxCurrent && usedPower < maxPower || maxBias < -1000)
        break;
    end
    
    % Grow the maximum bias exponentially to find an upper threshold for
    % the binary search
    minBias = minBias * 2;    
end

for i = 1 : numIterations
    
    % Find the bias between the max and minimum
    midBias = (maxBias + minBias) / 2;
    
    settings.bias = midBias;
    states = simulate(settings, 1000);
    
    % Extract the maximum Lorentz force calculated for this simulation
    extractedStates = stats(states);
    
    usedPower = extractedStates.current * settings.bias;
    
    % If the middle bias is too big, reduce search space towards the minimum.
    if ((extractedStates.current > maxCurrent) || (usedPower > maxPower))
        maxBias = midBias;
    else
        minBias = midBias;
    end
    
    fprintf('Max: %.3fV Min: %.3fV\n', maxBias, minBias)
end

states = simulate(settings, 1000);
extractedStates = stats(states);

maxForce = extractedStates.force;

end
