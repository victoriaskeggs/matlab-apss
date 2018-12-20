function plotStates(states)
    figure;
    plot([states.time] ./ 1e9, [states.current]);
    title 'Current in tether';
    xlabel 'Time (s)';
    ylabel 'Current towards the free end, at the satellite. (A)';
    
    velocity = arrayfun(@struct, [states.velocity])';
    
    figure;
    plot([states.time] ./ 1e9, [velocity.x; velocity.y; velocity.z]);
    title 'Velocity';
    xlabel 'Time (s)';
    legend('x','y','z');
    ylabel 'Velocity (ms^-1)';
end

