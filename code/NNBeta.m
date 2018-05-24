% NNBeta.m is an example script of how to run the TDNN with the actual data
clear;clc;close all;

% GET DATA
addpath('samples');
dataset = load('sample-400segs-5genres.mat');
load('code/lib/genres.mat', 'GenreSets');
genres = GenreSets.five;
% EITHER LOAD OR CREATE+TRAIN A TDNN
MAKE_NEW = 1;
if (MAKE_NEW)
    myTDNN = createTDNN();
    myTDNN = trainNN(myTDNN, dataset.trainIn, dataset.trainTarget);
else
    load('hello.mat', 'myTDNN');
end

% FORMAT A RESULTS TABLE
myTable = dataset.validTable;
Actual="";
Predicted="";
Correct=0;
resultsTable = table(Actual,Predicted, Correct);

numSongs = height(myTable);
% LOOP THROUGH ALL VALIDATION SONGS
genreArrayPredicted = zeros(numSongs, length(genres));
for i = 1:numSongs
    % Extract features
    featuresMatrix = getFeaturesFromTable(myTable(i, 'featureData'));
    % Extract true genre
    genreCell = myTable.genre(i);
    genreChars = genreCell{:};
    genreNameActual = string(genreChars);
    
    % Plug input into nn
    [singleOut, fullOut] = getClassification(myTDNN, featuresMatrix);
    predictedGenre = arrayToGenre(singleOut);
    genreArrayPredicted(i,:) = singleOut;
    % Compare
    isCorrect = strcmpi(genreNameActual,predictedGenre);    
    resultsTable(i,:) = {genreNameActual, predictedGenre, isCorrect};
    
end
    genreArrayActual = myTable.genreArray(:,:);

corrects = resultsTable.Correct;
numCorrect = sum(corrects, 1);
fprintf("\n RESULT: TDNN correctly predicted " ...
    +"%d out of %d songs in %d genres.\n", numCorrect, numSongs, length(genres));

% Confusion Matrix Plot
p = plotconfusion(genreArrayActual.', genreArrayPredicted.');
yticklabels(genres);
xticklabels(genres);

% SAVE the tdnn if it is good
dir = 'tdnns/';
filename = dir+"tdnn-"+numCorrect+"-correct.mat";
% save(filename, 'myTDNN');

% [singleOut, fullOut] = getClassification(myTDNN, dataset.validIn(901:1200,:));
% subplot(4,1,3);
% plot(fullOut);
% legend('1','2','3');
% title("Output wave for training data");
% xlabel("time");
% ylabel("'Confidence' in genre");
% 
% 
% subplot(4,1,4);
% bar(singleOut);
% ylim([0 1]);
% title("Predicted genre of unseen data (Genre 3)");
% xlabel("time");
% ylabel("'Confidence' in genre");
