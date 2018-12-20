N = 25;

%The length of the tether
lengths = linspace(1, 100, N);

%The bias on the emitter
bias = linspace(0, 200, N);

maximum = repmat(struct('current', 0, 'force', 0, 'power', 0), length(lengths), length(bias));

mean = repmat(struct('current', 0, 'force', 0, 'power', 0), length(lengths), length(bias));

parfor l = 2:N
    for b = 1:N
        settings = getDefaultSimulatorValues();
        settings.bias = bias(b);
        settings.length = lengths(l);
        
        [maximum(b, l), mean(b, l)] = stats( ...
            simulate(settings, 1000));
    end
end

[X, Y] = meshgrid(lengths, bias);

figure;
surf(X, reshape([maximum.current], N, N) .* Y, reshape([maximum.power], N, N), ...
    'FaceAlpha', 0.5, 'EdgeColor', 'none', 'FaceColor', 'interp');
title 'Maximum (transparent) / Average (solid) power disapated by the tether in a polar orbit.'
xlabel('Tether length (m)')
ylabel('Power supplied (W)')
zlabel('Power disapated (W)')

hold on;
surf(X, reshape([mean.current], N, N) .* Y, reshape([mean.power], N, N), ...
    'EdgeColor', 'none', 'FaceColor', 'interp');