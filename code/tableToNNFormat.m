function [input, target] = tableToNNFormat(myTable)
%TABLETONNFORMAT take a matlab table of songs  (of joes format)
% i.e. having 'Genre' and 'featureData' as columns
% and convert into arrays to plug into NN.
% format INPUTS (features) and TARGETS (genres) for trainNN
% i.e. t X n array of doubles
%       where t is the length of the signal
%       and n is the number of input signals (features)

numSegments = 100;
input = [];
target = [];
index = 1;
numSongs = height(myTable);
indices = 1:numSongs;
% Shuffle song order
shuffledIndices = indices(:,randperm(numSongs));

for rowInd = shuffledIndices
     featuresCell = (transpose(table2array(myTable(rowInd, 'featureData'))));
     featuresMatrix = cell2mat(featuresCell);
     genreCell = myTable.Genre(rowInd);
     genreName = genreCell{1};
    if (length(featuresMatrix) < numSegments)
        disp("Song sampling too short. Skipping."+ ...
        " This affects num of songs in splits.");
        continue;
    end
    %     TODO: edit to take something other than beginning of song
    songSample = transpose(featuresMatrix(:,1:numSegments));
    indexEnd = index+numSegments;
    input(index:indexEnd-1,:) = songSample(:,:);
    target(index:indexEnd-1,:) = genreInput(genreName, numSegments);

    index = indexEnd;
    

     
%     disp("hello");
end

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

