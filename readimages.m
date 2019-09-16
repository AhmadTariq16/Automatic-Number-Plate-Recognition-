% Script to read all image files

% Change directory to Frames or No Frames directory to read all image files from that directory

% Also change variable name on Line 12 to images_frames or images_noframes accordingly

% Same for No frames Number Plates
imagefiles = dir('*.jpg')
nfiles = length(imagefiles);
for ii=1:nfiles
currentfilename = imagefiles(ii).name;
currentimage = imread(currentfilename);
images_noframes{ii} = currentimage;
end

