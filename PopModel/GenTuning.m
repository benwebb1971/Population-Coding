function tuning = GenTuning(params)
%GENERATE TUNING   Generate tuning functions from input parameters.


% Predefine vector for tuning 
tuning = zeros(length(params.pref), length(params.Tile));

% Generate tuning 
for i=1:length(params.pref)
    dif=min(abs(params.Tile-params.pref(i)),abs(params.Tile-(params.pref(i))));
    dif=min(dif,abs(params.Tile-(params.pref(i))));
    tuning(i,:)= params.rmax*exp(-(dif.^2)/(2*params.sigma^2))+params.spont; 
end

