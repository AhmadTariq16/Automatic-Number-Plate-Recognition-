clc;
clear all;
load('data_updated.mat');

temp2 = {};
for n = 1:length(trainData_updated)
    temp = zeros(length(trainData_updated{n}),20);
    temp2{n,1} = [temp trainData_updated{n} temp];
end

trainData_updated = temp2;


