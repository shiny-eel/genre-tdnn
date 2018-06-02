% NNGamma.m is an CLONE of NNBeta
clear;clc;close all;

% GET DATA
addpath('samples');
dataset = load('sample-allsongs-400s-5g.mat');
load('code/lib/genres.mat', 'GenreSets');
genres = GenreSets.five;
% EITHER LOAD OR CREATE+TRAIN A TDNN
MAKE_NEW = 1;
if (MAKE_NEW)
    myTDNN = createTDNN();
    myTDNN.trainParam.showWindow = true;
    
    myTDNN = trainNN(myTDNN, dataset.trainIn, dataset.trainTarget);
else
    load('cgbNN.mat', 'myTDNN');
    %     myTDNN = trainNN(myTDNN, dataset.trainIn, dataset.trainTarget);
end

myTable = dataset.validTable;

resultsTable = validateNN(myTDNN, myTable);
% subplot(2,1,1);
p = plotResultsTable(resultsTable);
title("Unseen validation set");
% hold on;

load('samples/traintable-allsongs-400s-5g.mat', 'trainTable');
otherresultsTable = validateNN(myTDNN, trainTable);
% subplot(2,1,2);;;
figure();

p2 = plotResultsTable(otherresultsTable);
title("'Validating' on the training set");
% SAVE the tdnn if it is good
dir = 'tdnns/';
INSERT="CHANGEME";
filename = dir+"tdnn-"+INSERT+"-correct.mat";
% save(filename, 'myTDNN');

