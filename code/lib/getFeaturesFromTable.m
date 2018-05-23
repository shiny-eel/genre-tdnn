function [featureMatrix] = getFeaturesFromTable(dataTable)
%GETFEATURESFROMTABLE Summary of this function goes here
 featuresCell = (transpose(table2array(dataTable)));
     featureMatrix = cell2mat(featuresCell);
end

