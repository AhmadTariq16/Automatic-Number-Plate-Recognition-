clc;
clear all;
close all;

load ('data_noframes.mat');

trainData_noframes = {};

for k = 1:length(images_noframes)
    
    image = images_noframes{k};
    characterisolated = callMe(image,k);    
    
    characterisolated = transpose(characterisolated);
    
    trainData_noframes = vertcat(trainData_noframes,characterisolated);
    
    characterisolated = {};
end
