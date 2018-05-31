function [genreArray] = genreToArray(genreChars)
%GENRETOARRAY Summary of this function goes here
load('genres.mat', 'GenreSets', 'GenreArrays');

keys = GenreSets.ten;
values = GenreArrays.ten;
genreMap = containers.Map(keys,values);

genreArray = genreMap(genreChars);
end