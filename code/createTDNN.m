function [TDNN] = createTDNN()
%TRAINNN Summary of this function goes here
%   Detailed explanation goes here
delay = 40;
neurons = [40,20];
algo = 'trainscg';
TDNN = timedelaynet((0:2:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = true;
end

