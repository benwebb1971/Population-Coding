function Results = LoadStructMat()

% Set up maximised figure window
figure('units','normalized','outerposition',[0 0 1 1])

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

disp(data)

    
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
subplot(221)
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
Results.fit = LogistFit;

