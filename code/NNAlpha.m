% NNAlpha.m is an example script of how to run the TDNN.
clear;clc;close all;

load('samples/sample-data.mat')
myTDNN = createTDNN();
myTDNN.trainParam.showCommandLine = true;
myTDNN = trainNN(myTDNN, input, target);
[singleOut, fullOut] = getClassification(myTDNN, input(1:600,:));
plot(fullOut);
legend('1','2','3','4');
title("Output wave for training data (one sect each genre)");

