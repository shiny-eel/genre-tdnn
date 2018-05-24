function [plot] = plotResultsTable(resultsTable)
%PLOTRESULTSTABLE Summary of this function goes here
%   Detailed explanation goes here
load('code/lib/genres.mat', 'GenreSets');
genres = GenreSets.five;

    genreArrayActual = cell2mat(resultsTable.ActualArray(:,:));
    genreArrayPredicted = cell2mat(resultsTable.PredArray(:,:));

corrects = resultsTable.Correct;
numCorrect = sum(corrects, 1);
fprintf("\n RESULT: TDNN correctly predicted " ...
    +"%d out of %d songs in %d genres.\n", numCorrect, height(resultsTable), length(genres));

% Confusion Matrix Plot
plot = plotconfusion(genreArrayActual.', genreArrayPredicted.');
yticklabels(genres);
xticklabels(genres);
end

