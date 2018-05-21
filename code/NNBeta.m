% NNBeta.m is an example script of how to run the TDNN with the actual data
clear;clc;close all;
addpath('samples');
load('samples/sample-with-genres.mat')
numSongs = 24;
numFeatures = 5;
lenSample = 200;
 songs = transpose(table2array(train(1:numSongs, 'featureData')));
 
input = zeros(numSongs*lenSample,numFeatures);
% Grab 400 timeslices from each song
% input = [];
index = 1;
for song = songs
    
    disp("SS");
    songData = cell2mat(song);
    songSample = transpose(songData(1:5:25,1:lenSample));
    indexEnd = index+lenSample;
    input(index:indexEnd-1,:) = songSample;
    index = indexEnd;
end

genres = (transpose(table2array(train(1:numSongs, 'Genre'))));
for genre = genres
    
end


myTDNN = createTDNN();
myTDNN = trainNN(myTDNN, input, target);
[singleOut, fullOut] = getClassification(myTDNN, input(1:600,:));
plot(fullOut);
legend('1','2','3','4');
title("Output wave for training data");