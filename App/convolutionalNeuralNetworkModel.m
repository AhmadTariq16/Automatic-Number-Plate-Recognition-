clc;
close all;
clear all;

%load("data_final.mat");

filename = fullfile(pwd,'cnn');

imds = imageDatastore(filename,'IncludeSubfolders',true,'LabelSource','foldernames');
labelCount = countEachLabel(imds);

numClasses = numel(categories(imds.Labels));

[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7);

% Defining Layers of Convolutional Neural Network
layers = [
    imageInputLayer([140 90 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];


% Setting the training options for the CNN

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',10, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the CNN

net = trainNetwork(imdsTrain,layers,options);

% Accuracy
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)

