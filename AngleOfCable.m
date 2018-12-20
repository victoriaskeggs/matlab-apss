function [ theta ] = AngleOfCable( r )

theta = 0.1;

for i = 1 : 1000 
    theta = AngleOfCableEstimate(theta, r);
end

end