function Results = OriModelFit()
% ORIENTATION DISCRIMINATION MODEL    Simulate performance on orientation
%                                     discrimination task


% Set parameters of model and neurometric function
params = SetParameters('nReps',20, 'nNeurons', 64, 'sigma', 11, 'stepsize', 1, 'rangeshift', 90, 'decoder', 'WTA');

% Generate orientation tuning 
tuning = GenTuning(params);

% Generate population response on every trial
[resp, resp_n] = PopResponse(params, tuning);


% Decode stimulus
decoded = Decode(params, resp, resp_n, tuning);


% Construct neurometric function
cwMean = Recode(decoded, params);

% Fit neurometric function and derive threshold and PSE
FineX = params.Tile; % Smooth X
LogistFit = logisticfit(params.test,cwMean); % Call minimization function
FineY = logistic(FineX',LogistFit.params); % Smoooth Y 

% Save parameters and results of simulations in structured array  
Results.params = params;
Results.tuning = tuning;
Results.decoded = decoded;
Results.resp = resp_n;
Results.ModelFits = LogistFit;

% Min and max range for constant stimuli (xlim and ylim)  
MinStim = params.rangeshift-(params.stepsize*params.nSteps/2); 
MaxStim = params.rangeshift+(params.stepsize*params.nSteps/2);

%----------------------plot results of simulation--------------------------
% Set up figure window
figure('units','normalized','outerposition',[0 0 1 1])

% Plot tuning functions
subplot(231)
plot(params.Tile, tuning, 'k');
xlabel('Stimulus (units)', 'FontSize', 24)
ylabel('Response (spikes/sec)', 'FontSize', 24)
title('Tuning Functions', 'FontSize', 28, 'Color', 'r') 
xlim([min(params.Tile) max(params.Tile)])
box off
a = gca;
set(a, 'FontSize', 20)

% Plot decoded orientations
subplot(232)
plot(params.test,decoded,'ko', 'MarkerFaceColor', 'w','MarkerEdgeColor', 'k', 'MarkerSize',12, 'LineWidth', 1.2); hold on
xlabel('Physical Orientation (deg)', 'FontSize', 24)
ylabel('Decoded Orientation (deg)', 'FontSize', 24)
title('Estimated Orientations', 'FontSize', 28, 'Color', 'r')
box off
b = gca;


% Plot population response from first trial for 90 deg orientation
subplot(233)
plot(params.pref, resp_n(:,6),'ko' ,'MarkerFaceColor', 'w', 'MarkerSize', 12); hold on 
plot(params.pref, resp(:,6),'k-'); hold off
xlabel('Orientation (deg)', 'FontSize', 24)
ylabel('Response (spikes/sec)', 'FontSize', 24)
title('Population Response', 'FontSize', 28, 'Color', 'r') 
box off
c = gca;

% Plot neurometric function
subplot(234)
plot(params.test,cwMean,'ko', 'MarkerFaceColor', 'k', 'MarkerSize',12); hold on
plot(FineX,FineY,'k-')
xlabel('Orientation (deg)', 'FontSize', 24)
ylabel('Proportion of clockwise judgements', 'FontSize', 24)
title('Neurometric Function', 'FontSize', 28, 'Color', 'r')
text(max(params.test)-5,0.5, strcat('PSE: ', num2str(LogistFit.params(1))),'FontSize', 28, 'Color', 'r'); hold on
text(max(params.test)-5,0.4, strcat('JND: ', num2str(LogistFit.params(2))),'FontSize', 28, 'Color', 'r')
hold off
xlim([MinStim MaxStim])
ylim([0 1])
box off
d = gca;
figs = [a, b, c, d];
set(figs, 'FontSize', 20)



% Wait for user to press any key and then plot results from psychophysics
pause


% Select data files 
[FileName,PathName,FilterIndex] = uigetfile('/Volumes/practicals/C84EPS/PopCodModel2/.mat','MultiSelect','on');

% Check whether user cancelled or which files they opened 
if isequal(FileName,0) || isequal(PathName,0)
       disp('User pressed cancel')
else
       disp(FileName)
end

% Load data 
data = load(fullfile(PathName,FileName));


    
% Sort data 
[~,I] = sort(data.oris); 
resp=reshape(data.resp(I),data.nReps,numel(data.Levels));

% Mean and standard error of the mean 
respmean=double(mean(resp));
respsem=std(resp)/sqrt(double(data.nReps)); 

levels = double(data.Levels);


% Fit psychometric function and derive threshold and PSE
FineX = levels(1):0.01:levels(end); % Smooth X
LogistFit = logisticfit(levels,respmean); % Call minimization function
FineY = logistic(FineX',LogistFit.params); % Smoooth Y


% Fit psychometric function and derive threshold and PSE
subplot(235)
plot(data.Levels, respmean,'ko', 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k','MarkerSize',12); hold on
plot(FineX,FineY,'k-', 'LineWidth', 1.2); hold on
xlabel('Orientation (deg)', 'FontSize', 24)
ylabel('Proportion of clockwise judgements', 'FontSize', 24)
title('Psychometric Function', 'FontSize', 28, 'Color', 'r')
text(levels(end)-4,0.3, strcat('PSE: ', num2str(LogistFit.params(1))),'FontSize', 28, 'Color', 'r'); hold on
text(levels(end)-4,0.2, strcat('JND: ', num2str(LogistFit.params(2))),'FontSize', 28, 'Color', 'r')
xlim([levels(1) levels(end)])
ylim([0 1])

hold off

set(gca, 'FontSize', 24,...
    'box', 'off')


Results.data = data;
Results.PsychoFits = LogistFit;



