clear; clc; close all;
% Declare genres
Genre.RAP = 'Rap'; Genre.POPROCK = 'Pop_Rock'; Genre.RNB = 'RnB';

outputFile = 'samples/sample-splits.mat';

% Load some data that follows Joe's data format
% i.e. (Table w id, Genre, features)
sample = load('samples/sample-1846.mat', 'data');
data = sample.data;

% Split by genre
Songs.Rap = data(ismember(data.Genre, {Genre.RAP}),:);
Songs.PopRock = data(ismember(data.Genre, {Genre.POPROCK}),:);
Songs.RnB = data(ismember(data.Genre, {Genre.RNB}),:);

% Split 7:3 with equal weightings between genres
trainSongs=cell2table({});
validSongs=cell2table({});
% Iterate through genres
fields = fieldnames(Songs);
songsPerGenre = 60;
for idx = 1:length(fields)
    genreName = fields{idx};
    singleGenre = Songs.(genreName);
    if isstruct(singleGenre)
        disp("OOPS: Shouldn't be a struct");
    elseif istable(singleGenre)
%         len = height(singleGenre);
        boundary = round(0.7*songsPerGenre);
        trainInds = 1 : boundary;
        validateInds = boundary+1 : songsPerGenre;
        if (songsPerGenre > height(singleGenre))
            error("UH OH: Data doesn't have enough songs in that genre.");
        end
%         songs = (transpose(table2array(singleGenre(trainInds, 'featureData'))));
        genreSongs = singleGenre(trainInds,:);
        trainSongs = [trainSongs; genreSongs];
        
        genreSongsV = singleGenre(validateInds,:);
        validSongs = [validSongs; genreSongsV]; 


    end
end

[trainIn, trainTarget] = tableToNNFormat(trainSongs);
[validIn, validTarget] = tableToNNFormat(validSongs);
% train In = makeMatrix(trainSongs, numSegments);
% validIn = makeMatrix(validSongs, numSegments);

% fprintf("\nNUM SONGS IN TRAINING SPLIT: %d\n", length(trainIn));
% fprintf("NUM SONGS IN VALID SPLIT: %d\n", length(validIn));
% 
% Save to file.
% save(outputFile, 'validIn', 'validTarget', 'trainIn', 'trainTarget');
 
