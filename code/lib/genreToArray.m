function [genreArray] = genreToArray(genreChars)
%GENRETOARRAY Summary of this function goes here
load('DecadePrediction/decades.mat', 'GenreSets', 'GenreArrays');

keys = GenreSets.five;
values = GenreArrays.five;
genreMap = containers.Map(keys,values);

genreArray = genreMap(genreChars);
end