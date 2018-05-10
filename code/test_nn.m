clear; clc();

load hogg.mat;
load wine_dataset;
Config.delays = [1,2];
Config.neurons = [5, 10, 15];
Config.algos = ["traincgf", "traincgp", "trainscg"];

trainIn = transpose([x1; x2; x1; x2; x1; x2; x1; x2; x1; x2]);
trainOut = [0 1 0];
testIn = transpose([x3; x4; x3; x4; x3; x4; x3; x4; x3; x4;]);
testOut = [0 1 0];

visuals = 0;

  [trainResults, testResults, bestParams, avgCorr, bestNN] = ...
     tdnn_learn(trainIn, trainOut, testIn, testOut, Config, visuals);