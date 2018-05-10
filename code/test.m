clear; clc();


load wine_dataset;
wineTest = wineInputs(1,:);

%  TDNN input should be 1xN cell, each with Mx1 values 
%  M = num features
%  N = num timesteps

%  TDNN target should be 1xN cell, each with Kx1 values 
%  K = number of classes possible to classify
%  N = num timesteps

wineNNIn = tonndata(wineInputs(:,1:80), true, false);
% target = {1};
% 
% net = timedelaynet(1:2,10);
% [Xs,Xi,Ai,Ts] = preparets(net,wineNNIn,wineNNIn);


[X,T] = simpleseries_dataset;
Xnews = X(81:100);
Xnew = X(1:80);
Tnew = T(1:80);


% Xnew1 = tonndata(X(1:80), false, false);
% Tnew1 = tonndata(T(1:80), false, false);
% Train a time delay network, and simulate it on the first 80 observations.

net = timedelaynet(1:2,10);
[Xs,Xi,Ai,Ts] = preparets(net,wineNNIn,Tnew);
net = train(net,Xs,Ts,Xi,Ai);

% Ypred = classify(net, wineNNIn);
% view(net)