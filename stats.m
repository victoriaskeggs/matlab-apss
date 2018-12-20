function [maximumState, meanState] = stats(states)
    currents = [states.current];
    lorentzForces = arrayfun(@(state) state.lorentzForce.length(), states);
    power = arrayfun(@(state) -state.lorentzForce.dot(state.velocity), states);
    
    maximumState = struct('current', max(currents), 'force', max(lorentzForces), 'power', max(power));
    meanState = struct('current', mean(currents), 'force', mean(lorentzForces), 'power', mean(power));
end

