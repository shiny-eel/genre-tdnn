function [normSignal] = normalise(signal)
%NORMALISE Summary of this function goes here

% a = -1 + 2.*(a - min(a))./(max(a) - min(a));
% Normalise data between -1 and 1
% timbre = -1 + 2.*(timbre - min(timbre))./(max(timbre) - min(timbre));
 normSignal = -1 + 2.*(signal - min(signal))./(max(signal) - min(signal));

end

