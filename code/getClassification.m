function [singleOutput, fullOutput] = getClassification(TDNN,input)
%GETCLASSIFICATION Is a utility function that plugs in data into a trained
% TDNN and gives the averaged output.
% input: t X n array of doubles
%       where t is the length of the signal
%       and n is the number of input signals (features)
% TDNN: timedelaynet

formattedInput = tonndata(input, false, false);
nnOutput = TDNN(formattedInput);
mat = transpose(cell2mat(nnOutput));
singleOutput = mean(mat);
fullOutput = mat;
end

