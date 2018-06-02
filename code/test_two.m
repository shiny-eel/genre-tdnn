% Grab single f(t) feature for each song
% Train NN using feature
% Target is f(g) - straight line (in one of 4 dims) where g is the genre.
clear; clc; close all;
% delay = 30;
% neurons = [20, 20];
delay = 30;
neurons = [30,30];
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
f1(1,:) = test_get_feature(20, 1);
f1(2,:) = test_get_feature(10, 1);
f1(3,:) = test_get_feature(12, 1);
f1(4,:) = test_get_feature(8, 1);

f2(1,:) = test_get_feature(20, 12);
f2(2,:) = test_get_feature(10, 12);
f2(3,:) = test_get_feature(12, 12);
f2(4,:) = test_get_feature(8, 12);


%  Create training set and targets
len=150;
len2 = len*2;
% Snippets of each song going 1,2,3,4,1,2,3,4
smallInput1 = [f1(1,1:len), f1(2,1:len), f1(3,1:len), f1(4,1:len)];
doubleSmall1 = [smallInput1, f1(1, len+1:len2), ...
    f1(2, len+1:len2), f1(3,len+1:len2), f1(4,len+1:len2)];

smallInput2 = [f2(1,1:len), f2(2,1:len), f2(3,1:len), f2(4,1:len)];
doubleSmall2 = [smallInput2, f2(1, len+1:len2), ...
    f2(2, len+1:len2), f2(3,len+1:len2), f2(4,len+1:len2)];

trainIn = tonndata([doubleSmall1;doubleSmall2], true, false);

target = [repmat( g1,1,len ),repmat( g2,1,len ),repmat( g3,1,len ), repmat(g4,1,len)];
doubleTarget = [target, target];


trainTarget = tonndata( doubleTarget, true, false); 
% Format and use data to train
[Xs,Xi,Ai,Ts] = preparets(TDNN,trainIn, trainTarget); % Don't get affected by different delay size.
TDNN = train(TDNN,Xs, Ts, Xi, Ai);



% Plotting input data
figure();
subplot(2,1,1);
plot(transpose(smallInput1), 'DisplayName','Feature 1');
 hold on;
plot(transpose(smallInput2), 'DisplayName','Feature 2');
title("Training Input Data (2 features)");
xlabel("time (by segment)");
legend;

inpTest = transpose([smallInput1;smallInput2]);
[singleOut, fullOut] = getClassification(TDNN, inpTest);

subplot(2,1,2);
plot(fullOut);
legend('Genre 1','Genre 2','Genre 3','Genre 4');
title("Output waves for training data (150 segments per genre)");
xlabel("time (by segment)");
ylabel("'Confidence' in genre");

% Feed the NN never-seen-before data
% NB This is non-deterministic - different results each run.
in = transpose([f1(2,1:len2+len);f2(2,1:len2+len)]);
[singleOut, fullOut] = getClassification(TDNN, in);

% Plot results
figure();
subplot(2,1,1);
plot(fullOut);
legend('Genre 1','Genre 2','Genre 3','Genre 4');
title("Output wave for unseen data (Genre 2)");
xlabel("time (by segment)");
ylabel("'Confidence' in genre");

subplot(2,1,2);
bar(singleOut);
ylim([0 1]);
title("Predicted genre of unseen song (Genre 2)");
xlabel("time (by segment)");
ylabel("'Confidence' in genre");

