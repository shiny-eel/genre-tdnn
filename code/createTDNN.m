function [TDNN] = createTDNN()
%TRAINNN Summary of this function goes here
%   Detailed explanation goes here
delay = 50;
neurons = [80,40];
algo = 'trainscg';
TDNN = timedelaynet((0:2:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = true;
end

