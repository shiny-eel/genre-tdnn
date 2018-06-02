function [TDNN] = createTDNN(config)
%TRAINNN Summary of this function goes here
%   Detailed explanation goes here
% if (config.delay
delay = 30;
neurons = [30 10];
algo = 'traincgf';
TDNN = timedelaynet((0:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = true;
            TDNN.divideFcn = 'divideblock';
end

