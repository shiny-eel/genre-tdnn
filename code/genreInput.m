function target = genreInput(genreChars,lengthSample)
%GENREINPUT uses the genreToArray.m function to create
% a t x n matrix 
% where t is the number of timeslices specified by lengthSample
% and n is the length of the genre format. (number of genres).
target = repmat(genreToArray(genreChars), lengthSample, 1);
end

