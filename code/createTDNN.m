function [TDNN] = createTDNN(config)
%TRAINNN Summary of this function goes here
%   Detailed explanation goes here
% if (config.delay
delay = 30;
neurons = [50 25];
algo = 'traincgf';
TDNN = timedelaynet((0:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = true;
% TDNN.divideFcn = 'divideblock';
% TDNN.divideParam.trainRatio = 0.7;
%  TDNN.divideParam.valRatio = 0.0;
% TDNN.divideParam.testRatio = 0.3;

% set trainRatio = 1, valRatio=0 and testRatio=0 (this stops the validation checks).


end

