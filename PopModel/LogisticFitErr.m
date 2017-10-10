function f = LogisticFitErr(fitparam,inputs,data)
% used by LogisticFit

model = logistic(inputs,fitparam);

% Compute sum of squares error function
f = sum((data-model).^2);


