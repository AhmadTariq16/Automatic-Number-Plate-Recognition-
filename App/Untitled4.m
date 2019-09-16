load("cnndata.mat");

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