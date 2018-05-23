function [input, target, outTable] = tableToNNFormat(myTable)
%TABLETONNFORMAT take a matlab table of songs  (of joes format)
% i.e. having 'Genre' and 'featureData' as columns
% and convert into arrays to plug into NN.
% format INPUTS (features) and TARGETS (genres) for trainNN
% i.e. t X n array of doubles
%       where t is the length of the signal
%       and n is the number of input signals (features)
addpath('code/lib');
id = [];
genre = [];
genreArray = [];
featureData = [];
outTable = table(id,genre, genreArray,featureData);


numSegments = 300;
input = [];
target = [];
index = 1;
numSongs = height(myTable);
indices = 1:numSongs;
% Shuffle song order
shuffledIndices = indices(:,randperm(numSongs));

% Iterate through songs in a random order
for rowInd = shuffledIndices
%      featuresCell = (transpose(table2array(myTable(rowInd, 'featureData'))));
%      featuresMatrix = cell2mat(featuresCell);
     featuresMatrix = getFeaturesFromTable(myTable(rowInd, 'featureData'));
     genreCell = myTable.Genre(rowInd);
     genreName = genreCell{1};
    if (length(featuresMatrix) < numSegments)
        disp("Song sampling too short. Skipping."+ ...
        " This affects num of songs in splits.");
        continue;
    end
    %     TODO: edit to take something other than beginning of song
    songSample = normalise(transpose(featuresMatrix(:,1:numSegments)));
    indexEnd = index+numSegments;
    input(index:indexEnd-1,:) = songSample(:,:);
    target(index:indexEnd-1,:) = genreInput(genreName, numSegments);
    
    index = indexEnd;
    outId = myTable(rowInd, 'id');
    outRow = {outId{1,1}, genreName, genreToArray(genreName), songSample};
    outTable = [outTable; outRow];
     
%     disp("hello");
end

% timbre = (smooth(all_timbre(timbreInd,1:500)));
%  V = V/norm(V);
%  timbre = timbre/norm(timbre,3);
% a = -1 + 2.*(a - min(a))./(max(a) - min(a));
% Normalise data between -1 and 1
% timbre = -1 + 2.*(timbre - min(timbre))./(max(timbre) - min(timbre));
% input = -1 + 2.*(input - min(input))./(max(input) - min(input));

%         genreSongsV = (transpose(table2array(singleGenre(validateInds, 'featureData'))));
%         features = makeMatrix(songs, numSegments);
%         realLen = length(features);
%         genres = genreInput(genreName, realLen);
%         trainSongs{
%         trainSongs(1:realLen,:) = [features, genres];
%         trainSongs = [trainSongs, songs];
%         outmatrix = makeMatrix(songs, numSegments);
%         size(outmatrix);
%         trainIn = [trainIn; outmatrix];
%         trainTarget = [trainTarget ; genreInput(genreName, length(outmatrix))];
        
%         songsV = (transpose(table2array(singleGenre(validateInds, 'featureData'))));
%         featuresV = makeMatrix(songs, numSegments);
%         realLenV = length(features);
%         genresV = genreInput(genreName, realLen);
%         validSongs(1:realLenV, :) = [featuresV, genresV];

%         
%         outmatrixV = makeMatrix(songsV, numSegments);
%         validIn = [validIn; outmatrixV];
%         validTarget = [validTarget; genreInput(genreName, length(outmatrixV))];
end

