%Rs_central = 6783600; % radius from the earth in m
r_satellite = 6771000; % radius from the earth in m

m_satellite = 1.2;

mu = 3.986e14;
w = sqrt(mu/r_estimate^3); % angular speed
L = 200; % length of the cable in m

% For the integration
N = 2000;

% Pre-calculate all of the theta values for the given R
r_low = r_satellite - 1000;
r_high = r_satellite + 1000;

r = linspace(r_low, r_high, N);
theta = zeros(N);

for i = 1:N
    theta(i) = AngleOfCable(r(i));
end

tension_accumulation = zeros(num_candidates);

% Integrate tension from the satellite end
for i = 2:N
    dt = CalculateDeltaTension( theta(i), r(i), (r_high - r_low) / N );
    tension_accumulation(i) = tension_accumulation(i) + dt;
end

% Find the value for which the DELTA T is correct

for i = 1 : num_candidates
    r = Rs_candidates(i);
    
    theta_values(i) = AngleOfCable(r);
    
    satelliteTension = (m_sat * w^2 * r - (mu * m_sat) / r^2 )/cos(theta_values(i));

    % Integrate down the cable and find the tensions
    l_values = zeros(dl_num);
    % T_values = zeros(dT_num);
    r_values = zeros(dl_num);
    current_r = r;
    
    final_T_values = zeros(num_candidates);
    for j = 1 : dl_num
        r_values(j) = current_r;
        theta = AngleOfCable(current_r);
        current_r = r - L/dl_num * cos(theta);
    end
    
    theta = AngleOfCable(current_r);
    final_T = (m_sat * w^2 * current_r - (mu * m_sat) / current_r^2 )/cos(theta);
    final_T_values(i) = final_T;
    
    % Distance from earth
    disp(r)
    
    % Tension at the end of the cable, should be 0
    disp(final_T)
end

plot(Rs_candidates, final_T_values);