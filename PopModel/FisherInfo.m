function Finfo = FisherInfo(tuning)
% FISHER INFORMATION CARRIED BY POPAULTION OF NEURONS

% Fisher information
Finfo = diff(tuning).^2./difftuning;

