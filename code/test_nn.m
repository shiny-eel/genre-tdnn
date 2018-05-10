clear; clc();

% load hogg.mat;
% load simpleseries_dataset;
Config.delays = [1,2];
Config.neurons = [5, 10, 15];
Config.algos = ["traincgf", "traincgp", "trainscg"];

   [ bestParams, avgCorr, bestNN] = ...
      tdnn_learn(trainIn, trainOut, trainIn, trainOut, Config, visuals);