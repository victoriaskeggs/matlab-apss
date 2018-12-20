%Aluminium alloy 1100 strain hardened, copper, nickel, titanium, steel, stainless steel
%aisi 304
% Plots max length of a tether of given materials against diameter as
% constrained by yield stress, volume and mass.
materials = {'Aluminium Alloys', 'Magnesium Alloys', 'Nickel Alloys', 'Titanium Alloys', 'Copper Alloys', 'Zinc ALloys'}; % TODO
conductivities = [1/40e-9, 1/43.9e-9, 1/59e-9, 1/420e-9, 1/17e-9, 1/59e-9]; % S/m TODO
yieldStrengths = [300e6, 250e6, 600e6, 700e6, 270e6, 300e6]; % Pa TODO
densities = [2700, 1800, 8900, 4600, 8935, 6000]; % kg/m^3 TODO

for i = 1:length(yieldStrengths)
    hold on 
    plotLengthVersusDiameter(yieldStrengths(i), densities(i), 1.4, 0.05)
end

title('Lengths vs Diameters')
xlabel('Diameters (m)')
ylabel('Lengths (m)')
legend(materials)