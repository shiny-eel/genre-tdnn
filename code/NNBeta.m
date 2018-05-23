% NNBeta.m is an example script of how to run the TDNN with the actual data
clear;clc;close all;
addpath('samples');
dataset = load('samples/sample-with-table.mat');
% load('tdnn-beta.mat', 'myTDNN');
% 
 myTDNN = createTDNN();
% 
 myTDNN = trainNN(myTDNN, dataset.trainIn, dataset.trainTarget);
myTable = dataset.validTable;
numSongs = height(myTable);
Actual="";
Predicted="";
Correct=0;
resultsTable = table(Actual,Predicted, Correct);
% result = repmat(" ",[numSongs 2]);

for i = 1:numSongs
    featuresMatrix = getFeaturesFromTable(myTable(i, 'featureData'));
    genreCell = myTable.genre(i);
    genreChars = genreCell{:};
    genreNameActual = string(genreChars);
    
    [singleOut, fullOut] = getClassification(myTDNN, featuresMatrix);
    predictedGenre = arrayToGenre(singleOut);
    
%     result(i,:) = [genreNameActual, predictedGenre];
    isCorrect = strcmpi(genreNameActual,predictedGenre);
    resultsTable(i,:) = {genreNameActual, predictedGenre, isCorrect};
%     resultsTable(i,'Predicted') = predictedGenre;
end

corrects = resultsTable.Correct;
sumthat = sum(corrects, 1);
fprintf("\n RESULT: TDNN correctly predicted " ...
    +"%d out of %d song genres.\n", sumthat, numSongs);
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
