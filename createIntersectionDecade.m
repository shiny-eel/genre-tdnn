function [intersection] = CreateIntersectionDecade(all_files)

ids = strings(4681,1);
decades = strings(4681,1);
decadesDouble = zeros(4681,1);
index = 1;
for i=1:10000
    h5 = HDF5_Song_File_Reader(all_files{i});
    year = h5.get_year();
    if (year > 0)
        ids(index) = h5.get_track_id();
        decadesDouble(index) = year;
        roundYear = roundn(decadesDouble(index),1);
        decades(index) = num2str(roundYear);
        index = index + 1;
    end
end

intersection = table(cellfun(@(x) char(x),ids,'UniformOutput',false), decades,'VariableNames',{'id', 'decade'});
end

