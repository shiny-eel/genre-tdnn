function [genreArray] = genreToArray(genreChars)
%GENRETOARRAY Summary of this function goes here

keys = {'Rap', 'Pop_Rock', 'RnB'};
values = { [1,0,0], [0,1,0], [0,0,1]};
genreMap = containers.Map(keys,values);

genreArray = genreMap(genreChars);
end