clc;
clear all;
close all;

load ('data_updated.mat');

trainData_updated = {};

for k = 1:length(images_updated)
    
    image = images_updated{k};
    characterisolated = callMe(image,k);    
    
    characterisolated = transpose(characterisolated);
    
    trainData_updated = vertcat(trainData_updated,characterisolated);
    
    characterisolated = {};
end
