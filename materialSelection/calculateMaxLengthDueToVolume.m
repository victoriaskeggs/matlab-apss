function [ minLength, maxLength ] = calculateMaxLengthDueToVolume( diameter )
% Calculates the length of tether wound in a cylindrical spool
% Assumes the wire is wrapped in perfect circles in the spool
% dimensions in mm

radius = 20; %of Spool
width = 60; %of Spool
innerRad = 5; %inner radius of spool
flange = 1; %thickness of each flange
 
%Version 1: Estimates length based on assumption of perfect circular
%wrapping about reel
 
%length = 0;
 
%for r = innerRad:diameter:radius
 
%    length = length + 2*pi*r;
 
%end
 
%length = length * width / (1000 * diameter);
 
%display(length); %length in metres

%Version 2:
%Version 2: Calculates theoretical upper and lower limits of length based
%on variation due to packing
 
volumeAvailable = pi*((radius*10^-3)^2 - (innerRad*10^-3)^2)*(width - 2*flange)*10^-3;
AreaSquare = (diameter*10^-3)^2; %To find min L, assume wire has a square cross section (Does not rest lower between strands)
AreaCircle = pi/4*(diameter*10^-3)^2; %To find max L, assume there are no air gaps between wires.
 
minLength = volumeAvailable/AreaSquare; %Assume least efficient reasonabe packing
maxLength = volumeAvailable/AreaCircle; %Assume perfect packing, no gaps
%Results in metres
 
end