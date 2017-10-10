function [value, index] = FindNearest(Target, Vector)
% 
% finds minimum difference between Target value 
% vector element and returns index of target

value = zeros(1, length(Target));
index = zeros(1, length(Target));
for i = 1:length(Target)
    [value(i), index(i)]=min(abs((Target(i)-Vector))); 
end

if length(index)>1
    value=value(1);
    index=index(1);
end