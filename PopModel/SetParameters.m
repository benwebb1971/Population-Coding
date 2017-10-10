function params = SetParameters(varargin)
%SET PARAMETERS   Optional parameters are passed as string/value pairs.
%   If any of them are not specified, then default values are used. 
%
%   params = SetParameters([param1],[value1],[param2],[value2],...,[paramN],[valueN])
% 
%   Valid parameters are as follows:
%
%   'nReps' - number of repetitions for each test stimulus
%   'nNeurons' - number of orientation selective neurons in population
%   'MaxTile' - End point of feature space for all tuning functions
%   'mech_sep' - Spacing between preferences of neurons
%   'rmax' - Maximum response of neurons (spikes)
%   'spont' - Spontaneous response of neurons (spikes)
%   'sigma' - standard deviation of tuning functions
%   'pref' - Preferred orientation of neurons
%   'Tile' - Vector used to tile and generate tuning functions
%   'Decoder' - Algorithm used to decode value of stimulus 
%   'test' - the test orientation  
   
%------------   Specify default paramater set for model--------------------
params.nReps = 40; % Number of reptitions for each test stimulus
params.nNeurons = 30; % Number of neurons
params.MaxTile = 180; % Maximum Tiling of feature space (deg)
params.mech_sep = params.MaxTile/params.nNeurons; % Equal spacing between neurons across MaxTile (deg)
params.rmax = 100; % Maximum response (spikes)
params.spont = 5; % Spontaneous response (spikes)
params.sigma  = 10; % Standard deviation of tuning funnctions (deg)
params.pref =(0:params.nNeurons-1)'*params.mech_sep; % Preference of neurons (deg)
params.Tile = 0:0.001:params.MaxTile; % Vector for generating tuning fucntions
params.decoder = 'WTA';

%------------   Specify default paramater set for stimuli--------------------
params.nSteps = 21; % Number of steps in neurometric function (odd number)
params.rangeshift = 90; % Centre of neurometric function (deg) 
params.stepsize = 1; % stepsize in neurometric function 
params.maxstim = params.rangeshift+(params.stepsize*(params.nSteps-1)/2); % maximum stimulus in neurometric function
params.minstim= params.rangeshift-(params.stepsize*(params.nSteps-1)/2); % minimum stimulus in neurometric function
params.test = (params.minstim:params.stepsize:params.maxstim); % Test stimuli



%------------  Change specified input paramaters 
for index = 1:2:length(varargin)
  field = varargin{index};
  val = varargin{index+1};
 switch field
    case 'nReps'
      params.nReps = val;
    case 'nNeurons'
      params.nNeurons = val;
      params.mech_sep = params.MaxTile/params.nNeurons;
      params.pref =(0:params.nNeurons-1)'*params.mech_sep; 
    case 'MaxTile'
      params.MaxTile = val;
    case 'rmax'
      params.rmax = val;
    case 'spont'
      params.spont = val;  
    case 'sigma'
      params.sigma = val;  
    case 'decoder'
      params.decoder = val;          
    case 'rangeshift'
      params.rangeshift = val;
      params.maxstim = params.rangeshift+(params.stepsize*(params.nSteps-1)/2); 
      params.minstim= params.rangeshift-(params.stepsize*(params.nSteps-1)/2); 
      params.test = (params.minstim:params.stepsize:params.maxstim); 
    case 'stepsize'
      params.stepsize = val;
      params.maxstim = params.rangeshift+(params.stepsize*(params.nSteps-1)/2); 
      params.minstim= params.rangeshift-(params.stepsize*(params.nSteps-1)/2); 
      params.test = (params.minstim:params.stepsize:params.maxstim);   
    otherwise
      warning(['OriDiscrim: invalid parameter: ',field]);
  end
end      
      

