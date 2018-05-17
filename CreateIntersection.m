function [intersection] = CreateIntersection(all_files)
data = readtable('MillionSongSubset/genreAssignment.txt');
data.Properties.VariableNames = {'id' 'Genre'};
x = data(:,1); % column 1 of the data text file is assigned the variable x
y = data(:,2); % column 2 is assigned the variable y
ids = strings(10000,1);
for i=1:10000
    h5 = HDF5_Song_File_Reader(all_files{i});
    ids(i) = h5.get_track_id();
end
idTable = table(cellfun(@(x) char(x),ids,'UniformOutput',false),'VariableNames',{'id'});
genreSongsTable = unique(data);
intersection = innerjoin(idTable,genreSongsTable);
end

