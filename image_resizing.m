clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image resizing

for i=1:length(images_frames)
    
    images_frames{i} = imresize(images_frames{i},0.1);

end

for i=1:length(images_noframes)
    images_noframes{i} = imresize(images_noframes{i},0.1);
end

for i=1:length(images_updated)
    images_updated{i} = imresize(images_updated{i},0.1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%