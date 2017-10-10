function FI = fishinfo(x,y)
%fishinfo Fisher Information.
%  Finfo = fishinfo(x,y) returns Fisher information
%  x is response to stimulus one
%  y is response to stimulus two

% Fisher information
FI = abs(x-y).^2./abs(x-y);
