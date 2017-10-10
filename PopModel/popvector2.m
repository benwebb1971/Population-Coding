function estimate = popvector2(r, pref)
%popvector population vector
%  estimate = popvector(r,pref) returns population vector 
% r contains the responses of the population
% pref preferrred stimulus of neurons

estimate = pref.*r/r;


