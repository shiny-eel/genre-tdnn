function [genreArray] = genreToArray(genreChars)
%GENRETOARRAY Summary of this function goes here
load('genres.mat', 'GenreSets');

keys = GenreSets.basic;
values = { [1,0,0], [0,1,0], [0,0,1]};
genreMap = containers.Map(keys,values);

genreArray = genreMap(genreChars);
end