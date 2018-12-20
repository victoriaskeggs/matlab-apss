Rs_central = 6771e3;
m_sat = 1.2;
w = 1.13e-3; %angular speed
mu = 3.986e14; % gravitational constant and mass of earth
L = 200; % length of the cable in m

% For the integration
dl_num = 10000;
dT_num = 10000;

num_candidates = 400;

Rs_candidates = linspace(Rs_central - 200, Rs_central + 200, num_candidates);
theta_values = zeros(num_candidates);
T_values = zeros(num_candidates);

for i = 1 : num_candidates
    r = Rs_candidates(i);
    
    theta_values(i) = AngleOfCable(r);
    T_s = (m_sat * w^2 * r - (mu * m_sat) / r^2 )/cos(theta_values(i));
    
    % Integrate down the cable and find the tensions
    l_values = zeros(dl_num);
    T_values = zeros(dT_num);
    R = r;
    
    for j = l_values : 1
        l_values(i) = 
        T_values(i) = 
    end
end