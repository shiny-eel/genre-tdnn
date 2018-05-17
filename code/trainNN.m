function TDNN = trainNN(TDNN,input, target)
%TRAINNN Hides away complexity of formatting NN data
% INPUTS:
% TDNN - the TDNN network
% input - t X n array of doubles
%       where t is the length of the signal
%       and n is the number of input signals (features)
% target - t x g array of BINARIES (1 or 0)
%       where g is the number of genres

trainIn = tonndata(input, false, false);
trainTarget = tonndata(target, false, false);

% Format and use data to train
% Don't get affected by different delay size.
[Xs,Xi,Ai,Ts] = preparets(TDNN,trainIn, trainTarget); 
TDNN = train(TDNN,Xs, Ts, Xi, Ai);


end

