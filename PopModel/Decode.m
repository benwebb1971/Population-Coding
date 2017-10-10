function decoded = Decode(params, resp, resp_n, tuning)
% DECODE STIMULUS from population response
%
% Winner takes-all (WTA) -  stumulus eliciting largest response
% Vector Average (VA) - stimulus eleciting average response weighted by 
%                       magnitude of response 
% Maximum Likelihood  - peak of the likelihood function
%

if strcmp(params.decoder,''),
    error('Input must be WTA, PV or ML')
    
elseif strcmp(params.decoder,'WTA') % Winner takes-all
    [~,index]=max(resp_n); 
    decoded = params.pref(index);
    decoded = reshape(decoded,[length(params.test), params.nReps]);
    
elseif strcmp(params.decoder,'PV') % Population Vector   
      pref = repmat(params.pref, 1,  length(resp_n));
      decoded = popvector(pref, resp_n);
      decoded = reshape(decoded, length(params.test), params.nReps);
      
elseif strcmp(params.decoder,'ML') % Maximum likelihood
      Likelihood = likehood(resp_n, tuning); % Likelihood for each test on each trial
      [~,index]=max(Likelihood');
      decoded = params.Tile(index);
      decoded = reshape(decoded,[length(params.test), params.nReps]); 
end
