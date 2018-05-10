function [trainResults, testResults, bestParams, avgCorr, bestNN] = ...
    tdnn_learn(trainIn, trainOut, testIn, testOut, config, visuals)
% A base for a TDNN training function
% Inputs:
%   trainIn, trainOut: n X 1 array of doubles
%   testIn, testOut: m X 1 array of doubles
%   config: structure containing delays, neurons, algos.
%       delays: integer array denoting the maximum delay to try train NN with
%       neurons: integer array giving sizes of neuron layers to try
%       algos: string array of algorithms to use
%   visuals: boolean on whether to graph.

%  Outputs:
%  trainResults, testResults: n or m X 1 array of doubles denoting TDNN out
%  bestParams: struct containing:
    %  bestDelay: delay used for best result
    %  neurons: num neurons used for best result
%      algo: algo used

if visuals
    plotCorrelation(trainIn(:), trainOut(:), 2, ...
        'Original training ECG and EGM', 'Training ECG', 'Training EGM');
    plotCorrelation(testIn(:), testOut(:), 4, ...
        'Original test ECG and EGM', 'Test ECG', 'Test EGM');
end
delays = config.delays;
algos = config.algos;
neurons = config.neurons;
% train_input = trainIn;
% train_output = outputTrain;
% MAX = 20;
% MAX = maxDelay;
% algos = ["trainlm", "trainscg"];
numAlgos = length(algos);
% neurons = [5:5:20, 40, 80, 100];
delayCombos = length(delays);
neuronCombos = length(neurons);
bestResult = cell(1,1); % net, corr, neurons, delay
results_vft = cell(delayCombos*numAlgos*neuronCombos,1);
train_vft = cell(delayCombos*numAlgos*neuronCombos,1);
test_vft = cell(delayCombos*numAlgos*neuronCombos,1);
max_avg = 0.0;
count = 1;
for neuron = neurons
    for delay = delays
        fprintf("Trying: "+neuron+" neurons | "+delay+" delay window\n");
        timeStart = tic;
        for algo = algos
            [X, nX] = tonndata(trainIn, false, false);
            [T, nT] = tonndata(trainOut, false, false);
            TDNN = timedelaynet((0:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = false;

            % preparets+train trains the TDNN
            [Xs,Xi,Ai,Ts] = preparets(TDNN,X,T);
            TDNN = train(TDNN,Xs,Ts, Xi, Ai);
            % compute correlation coefficients.
            nnTrainOutput = cell2mat(transpose(TDNN(tonndata(trainIn, false, false), tonndata((trainIn(1:(delay))), false, false))));
            nnTrainCorr = corr(nnTrainOutput, trainOut(:));
            nnOutputNet = TDNN(  tonndata(testIn(:), false, false), tonndata(testIn(1:(delay)), false, false)  );
            nnTestOutput = cell2mat(transpose(nnOutputNet));
            nnTestCorr = corr(nnTestOutput, testOut(:));
            avg = (nnTrainCorr+nnTestCorr)/2.0;

            results_vft(count) = {[avg; nnTrainCorr; nnTestCorr; neuron; delay; algo]};
            train_vft(count) = {transpose(nnTrainOutput)};
            test_vft(count) = {transpose(nnTestOutput)};
            if avg > max_avg
                max_avg = avg;
                bestResult(1) = {[max_avg; neuron;delay; count; algo]};
                bestNN = TDNN;
                if visuals
                    quickPlotter(trainOut(:),transpose(train_vft{count,1}), 1, 'Training Set');
                    quickPlotter(testOut(:), transpose( test_vft{count,1}), 3, 'Test Set');
                end
            end

            count = count + 1;

        end
        tElapsed = toc(timeStart);  % TOC, pair 2  
        fprintf("Took %s seconds.\n", string(tElapsed));

    end
end
bestParams.delay = bestResult{1}(3);
bestParams.neurons = bestResult{1}(2);
bestParams.algo = bestResult{1}(5);

best = str2double(bestResult{1}(4));
trainResults = transpose(train_vft{best,1});
testResults = transpose(test_vft{best,1});
avgCorr = bestResult{1}(1);

% plotCorrelation(trainOut(:),trainResults, 1, ...
%     'Training Set', 'Training EGM', 'NN Output');
% plotCorrelation(testIn(1:testSetLength), testOut(1:testSetLength), 2, ...
%     'Original test ECG and EGM', 'Test ECG', 'Test EGM');
%
% plotCorrelation(testOut(1:testSetLength), testResults, 3,...
%     'Test Set EGM', 'Test EGM', 'NN Output');
%

end
