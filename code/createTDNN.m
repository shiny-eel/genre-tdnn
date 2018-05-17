function [TDNN] = createTDNN()
%TRAINNN Summary of this function goes here
%   Detailed explanation goes here
delay = 30;
neurons = [30,30];
algo = 'trainlm';
TDNN = timedelaynet((0:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = true;
end

