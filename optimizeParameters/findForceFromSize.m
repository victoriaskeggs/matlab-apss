% For a tether of given length and diameter, use an exponential search to
% find the maximum allowable bias and its associated Lorentz force.

function [maxForce, settings] = findForceFromSize(length, diameter, maxPower, maxCurrrent) 

% Number of iterations to run binary search
numIterations = 20;

% Override default length and diameter
settings = getDefaultSimulatorValues();
settings.diameter = diameter; % m
settings.length = length; % m

% Initial estimate for a bias that is too large.
maxBias = 10;
minBias = 0;

while true
    % Run the simulation given the new maximum bias
    settings.bias = maxBias;
    states = simulate(settings, 1000);
    
    % Extract the maximum Lorentz force calculated for this simulation
    extractedStates = stats(states);
    
    % If condition holds, upper threshold has been found
    if (extractedStates.current > maxCurrent || extractedStates.power > maxPower || maxBias > 1000)
        break;
    end
    
    % Grow the maximum bias exponentially to find an upper threshold for
    % the binary search
    maxBias = maxBias * 2;    
end

for i = 1 : numIterations
    
    % Find the bias between the max and minimum
    midBias = (maxBias + minBias) / 2;
    
    settings.bias = midBias;
    states = simulate(settings, 1000);
    
    % Extract the maximum Lorentz force calculated for this simulation
    extractedStates = stats(states);
    
    % If the middle bias is too big, reduce search space towards the minimum.
    if ((extractedStates.current > maxCurrent) || (extractedStates.power > maxPower))
        maxBias = midBias;
    else
        minBias = midBias;
    end    
end

states = simulate(settings, 1000);
extractedStates = stats(states);

maxForce = extractedStates.force;

end
