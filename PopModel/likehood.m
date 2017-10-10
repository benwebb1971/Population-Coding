function Likelihood =likehood(Response,tuning)
%LIKELIHOOD FUNCTION   Generate likelihood function from response and tuning

weights=log10(tuning);

Likelihood=Response'*weights;



