function predict= callMe(data)

load("cnndata.mat");

myFolder = pwd;
myFolder = strcat(pwd, '\New Folder');

% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now deleting %s\n', fullFileName);
  delete(fullFileName);
end


for i = 1:length(data)   
         imwrite(cell2mat(data(i,1)),strcat(myFolder,'\',sprintf('%d.jpg',i)));
end

filename = fullfile(pwd, 'New Folder');
testdata = imageDatastore(filename);

predict = classify(net, testdata)

predict = transpose(cellstr(predict));
predict = cell2mat(predict)

for i = 1:length(predict)
    
    if predict(i) == '0' 
        if i == 1 || i == 5 || i== 6 || i==7
            predict(i) = '0';
        elseif i == 2 || i == 3 || i == 4
            predict(i) = 'O';
        end
    end
end

predict


