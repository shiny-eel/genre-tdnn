function [genreString] = arrayToGenre(genreArray)
%GENRETOARRAY Summary of this function goes here
load('genres.mat', 'GenreSets');

values = GenreSets.basic;
% keys = { [1,0,0], [0,1,0], [0,0,1]};
% genreMap = containers.Map(keys,values);
[M, I] = max(genreArray);
if (length(I) > 1)
    disp("Multiple genres possible.");
end
genreString = values{I};
end