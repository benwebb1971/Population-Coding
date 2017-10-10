function cwMean = Recode(decoded, params)
% RECODE TO NEUROMETRIC FUNCTION  recode decoded orientation as proportion
% of clockwise judgements
%
%
cw = zeros(params.nSteps,params.nReps); % No. steps  & reps for neurometric funcntion;
cw(decoded>median(params.test))=1; % clockwise
cw(decoded<median(params.test))=0; % counter clockwise
cw(decoded==median(params.test))=randi(0:1, 1); % random cw or ccw
cwMean = mean(cw',1);
