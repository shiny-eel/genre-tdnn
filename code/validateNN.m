function [resultsTable] = validateNN(tdnn,dataTable)
%VALIDATENN Summary of this function goes here

addpath('code/lib');
sz = [height(dataTable), 5];
varTypes = {'string', 'string', 'logical', 'cell','cell'};
varNames = {'Actual', 'Predicted', 'Correct', 'ActualArray', 'PredArray'};
resultsTable = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

numSongs = height(dataTable);
% LOOP THROUGH ALL VALIDATION SONGS
% genreArrayPredicted = zeros(numSongs, length(genres));
for i = 1:numSongs
    % Extract features
    featuresMatrix = getFeaturesFromTable(dataTable(i, 'featureData'));
    % Extract true genre
    genreCell = dataTable.genre(i);
    genreChars = genreCell{:};
    genreNameActual = string(genreChars);
    
    % Plug input into nn
    [singleOut, fullOut] = getClassification(tdnn, featuresMatrix);
    predictedGenre = arrayToGenre(singleOut);
%     genreArrayPredicted(i,:) = singleOut;
    % Compare
    isCorrect = strcmpi(genreNameActual,predictedGenre);    
    actualGenreArray = dataTable.genreArray(i,:);
    newRow = {genreNameActual, predictedGenre, isCorrect, ...
         {actualGenreArray}, {singleOut}};
%    newRow = {genreCell, {predictedGenre}, {isCorrect}};
    resultsTable(i,:) = newRow;
end

end

