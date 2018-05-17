% Grab single f(t) feature for each song
% Train NN using feature
% Target is f(g) - straight line (in one of 4 dims) where g is the genre.
clear; clc; close all;
% delay = 30;
% neurons = [20, 20];
delay = 30;
neurons = [25,25];
algo = 'trainlm';
TDNN = timedelaynet((0:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = true;

% Genres:
g1 = [1;0;0;0];
g2 = [0;1;0;0];
g3 = [0;0;1;0];
g4 = [0;0;0;1];

% Getting a single feature for 4 different songs
song(1,:) = test_get_feature(20, 1);
song(2,:) = test_get_feature(10, 1);
song(3,:) = test_get_feature(12, 1);
song(4,:) = test_get_feature(8, 1);

%  Create training set and targets
len=150;
len2 = len*2;
smallInput = [song(1,1:len), song(2,1:len), song(3,1:len), song(4,1:len)];
doubleSmall = [smallInput, song(1, len+1:len2), song(2, len+1:len2), song(3,len+1:len2), song(4,len+1:len2)];
trainIn = tonndata(doubleSmall, true, false);

target = [repmat( g1,1,len ),repmat( g2,1,len ),repmat( g3,1,len ), repmat(g4,1,len)];
doubleTarget = [target, target];

% Plotting input data
figure();
subplot(4,1,1);
plot(transpose(doubleTarget)); hold on;
plot(transpose(doubleSmall));
title("Input Data");
trainTarget = tonndata( doubleTarget, true, false); 

% Format and use data to train
[Xs,Xi,Ai,Ts] = preparets(TDNN,trainIn, trainTarget); % Don't get affected by different delay size.
TDNN = train(TDNN,Xs, Ts, Xi, Ai);

[singleOut, fullOut] = getClassification(TDNN, transpose(smallInput));

subplot(4,1,2);
plot(fullOut);
legend('1','2','3','4');
title("Output wave for training data");


% Feed the NN never-seen-before data
% NB This is non-deterministic - different results each run.
in = transpose(song(3,len2:len2+len));
[singleOut, fullOut] = getClassification(TDNN, in);

% Plot results
subplot(4,1,3);
plot(fullOut);
legend('1','2','3','4');
title("Output wave for unseen data");
subplot(4,1,4);
bar(singleOut);
ylim([0 1]);
title("Predicted genre of unseen data");


% predicc{2} = mean(mat,2);

% testA = tonndata(song(1,1:len),true,false);
% nnOutput = TDNN(testA);
% 
% mat = cell2mat(nnOutput);
% predicc{1} = mean(mat,2);
% 
% testC = tonndata(song(3,1:len),true,false);
% nnOutput = TDNN(testC);
% 
% mat = cell2mat(nnOutput);
% predicc{3} = mean(mat,2);
% 
% testD = tonndata(song(4,1:len),true,false);
% nnOutput = TDNN(testD);
% 
% mat = cell2mat(nnOutput);
% predicc{4} = mean(mat,2);
