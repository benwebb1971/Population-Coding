function estimate = popvector(s,r)
%popvector population vector
%  estimate = popvector(s,r) returns population vector in degrees
% 
%
% Calculates the population vector 
h = sum(r.*cos(s.*pi/180));
v = sum(r.*sin(s.*pi/180));
 
estimate = atan2(v,h)*180/pi;
