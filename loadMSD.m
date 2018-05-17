% set up Million Song paths
global MillionSong MSDsubset
MillionSong ='MillionSongSubset';  % or 'MillionSong' for full set
msd_data_path=[MillionSong,'/data'];
msd_addf_path=[MillionSong,'/AdditionalFiles'];
MSDsubset='subset_'; % or '' for full set
msd_addf_prefix=[msd_addf_path,'/',MSDsubset];
% Check that we can actually read the dataset
assert(exist(msd_data_path,'dir')==7,['msd_data_path ',msd_data_path,' is not found.']);

% path to the Million Song Dataset code
msd_code_path='MSongsDB';
assert(exist(msd_code_path,'dir')==7,['msd_code_path ',msd_code_path,' is wrong.']);
% add to the path
addpath([msd_code_path,'/MatlabSrc']);

% Build a list of all the files in the dataset
all_files = findAllFiles(msd_data_path);
cnt = length(all_files);
disp(['Number of h5 files found: ',num2str(cnt)]);

% Get info from the first file using our wrapper
h5 = HDF5_Song_File_Reader(all_files{1});
disp(['artist name is: ',h5.get_artist_name()]);
disp([' song title is: ',h5.get_title()]);
fprintf('segment timbres len: %d\n', length(h5.get_segments_timbre()));

% Load songs and genre classifications
intersection = CreateIntersection(all_files);

% Load features
extractedSongs={};
for currentSong = 1:numel(all_files)
    current_h5=HDF5_Song_File_Reader(all_files{currentSong});
    currentSongCell={
        current_h5.get_track_id(),
        get_middle_elements(current_h5.get_segments_timbre()),
        get_middle_elements(current_h5.get_segments_pitches()),
        get_middle_elements(current_h5.get_segments_loudness_start()),
    };
    %disp(current_song_cell);
    extractedSongs{end+1} = currentSongCell;
end
extractedSongTable = table(x,y,'VariableNames',{'id' 'genre'});
disp(extractedSongTable);

