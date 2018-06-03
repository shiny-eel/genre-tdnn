clear; clc; close all;
% Declare genres
addpath('code/lib');
load('lib/genres.mat', 'GenreSets');
gs = GenreSets.five;
% Load some data that follows Joe's data format
% i.e. (Table w id, Genre, features)
sample = load('samples/raw-all.mat', 'data');
data = sample.data;
shuffledData = data(randperm(size(orderedArray,1)),:);
data = shuffledData;

% Split by specified genres
Songs.Rap = data(ismember(data.Genre, gs(1)),:);
Songs.PopRock = data(ismember(data.Genre, gs(2)),:);
Songs.RnB = data(ismember(data.Genre, gs(3)),:);
Songs.Jazz = data(ismember(data.Genre, gs(4)),:);
Songs.Blues = data(ismember(data.Genre, gs(5)),:);

trainSongs=cell2table({});
validSongs=cell2table({});

fields = fieldnames(Songs);
songsPerGenre = 120;

% Split 7:3 with equal weightings between genres
% Iterate through genres
for randRows = 1:length(fields)
    genreName = fields{randRows};
    singleGenre = Songs.(genreName);
    if isstruct(singleGenre)
        disp("OOPS: Shouldn't be a struct");
    elseif istable(singleGenre)
%         Divide songs into test and validate
        boundary = round(0.7*songsPerGenre);
        trainInds = 1 : boundary;
        validateInds = boundary+1 : songsPerGenre;
        if (songsPerGenre > height(singleGenre))
            error("UH OH: Data doesn't have enough songs in that genre.");
        end
        
%       Add to test/validation collections with all genres
        genreSongs = singleGenre(trainInds,:);
        trainSongs = [trainSongs; genreSongs];
        
        genreSongsV = singleGenre(validateInds,:);
        validSongs = [validSongs; genreSongsV]; 


    end
end

[trainIn, trainTarget, trainTable] = tableToNNFormat(trainSongs);
[validIn, validTarget, validTable] = tableToNNFormat(validSongs);
% train In = makeMatrix(trainSongs, numSegments);
% validIn = makeMatrix(validSongs, numSegments);

fprintf("\nNUM SONGS IN TRAINING SPLIT: %d\n", height(trainTable));
fprintf("NUM SONGS IN VALID SPLIT: %d\n", height(validTable));
% 
% Save to file.
outputFile = "samples/sample-CHANGEME.mat";
% save(outputFile, 'validIn', 'validTarget', 'trainIn', 'trainTarget', 'validTable', 'trainTable');
 

