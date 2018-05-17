function [singleOutput, fullOutput] = getClassification(TDNN,input)
%GETCLASSIFICATION Is a utility function that plugs in data into a trained
% TDNN and gives the averaged output.
% % PARAMETERS:
% input: t X n array of doubles
%       where t is the length of the signal
%       and n is the number of input signals (features)
% TDNN: timedelaynet with g dimensional output
% % OUTPUTS:
% singleOutput: 1 x g array of doubles
%       averaged values for each of the output dimensions (g)
% fullOutput: t x g time-variant values for each output dimension
delay = TDNN.numInputDelays;
formattedInput = tonndata([input;input(1:delay)], false, false);
nnOutput = TDNN(formattedInput);
mat = transpose(cell2mat(nnOutput));
% A(1,:)=[];
% Account for initial NN inaccuracy by removing delay-window size of
% beginning
mat(1:delay,:)=[];
singleOutput = mean(mat);
fullOutput = mat;
end

