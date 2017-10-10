function [resp, resp_n] = PopResponse(params, tuning)
% POPULATION RESPONSE   response of neurons across all stimuli and trials
%
% Generates noiseless response and response corrupted by Poisson noise 

% Predefine vector for population responses to test stimuli  
index = zeros(length(params.test), 1);

% Determine noiseless response of each neuron based on tuning curves
for j = 1:length(params.test)
    [~, index(j)] = FindNearest(params.test(j), params.Tile); 
end



% Replicate for each trial repetition
resp = repmat(tuning(:,index),1, params.nReps);

% Generate poisson distributed responses
resp_n = random('poiss', resp, size(resp)); 

