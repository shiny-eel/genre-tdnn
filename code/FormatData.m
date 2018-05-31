clear; clc; close all;
% Declare genres
load('lib/genres.mat', 'GenreSets');
gs = GenreSets.five;
gs = GenreSets.ten;
% Load some data that follows Joe's data format
% i.e. (Table w id, Genre, features)
sample = load('samples/raw-all.mat', 'data');
data = sample.data;

% Split by specified genres
Songs.Rap = data(ismember(data.Genre, gs(1)),:);
Songs.PopRock = data(ismember(data.Genre, gs(2)),:);
Songs.RnB = data(ismember(data.Genre, gs(3)),:);
Songs.Jazz = data(ismember(data.Genre, gs(4)),:);
Songs.Blues = data(ismember(data.Genre, gs(5)),:);
Songs.Country = data(ismember(data.Genre, gs(6)),:);
Songs.Electronic = data(ismember(data.Genre, gs(7)),:);
Songs.Reggae = data(ismember(data.Genre, gs(8)),:);
Songs.Latin = data(ismember(data.Genre, gs(9)),:);
Songs.International = data(ismember(data.Genre, gs(10)),:);

trainSongs=cell2table({});
validSongs=cell2table({});

fields = fieldnames(Songs);
songsPerGenre = 120;
songsPerGenre = 120; % Max for 10 genres - Reggae only has 120 songs

% Split 7:3 with equal weightings between genres
% Iterate through genres
for idx = 1:length(fields)
    genreName = fields{idx};
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
% save(outputFile, 'validIn', 'validTarget', 'trainIn', 'trainTarget', 'validTable');
 

