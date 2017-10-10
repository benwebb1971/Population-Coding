function average = vectaver(s,r)
%
% Calculates the vector average 
h = 0;
v = 0;
for b = 1:length(s)
    h = h+(r(b)*cos(s(b)*pi/180));
    v = v+(r(b)*sin(s(b)*pi/180));
end

h = h/length(s);
v = v/length(s);

average = atan2(v,h)*180/pi;