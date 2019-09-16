clc;
clear all;


%load('trainData_combined.mat');
load('trainData_frames.mat');
load('trainData_noframes.mat');
load('trainData_updated.mat');

% Cross varidation (train: 70%, test: 30%) - Frames
cv_frames = cvpartition(size(trainData_frames,1),'HoldOut',0.3);
idx_frames = cv_frames.test;

% Separate to training and test data
dataTrain_frames = trainData_frames(~idx_frames,:);
dataTest_frames  = trainData_frames(idx_frames,:);


% Cross varidation (train: 70%, test: 30%) - No Frames
cv_noframes = cvpartition(size(trainData_noframes,1),'HoldOut',0.3);
idx_noframes = cv_noframes.test;

% Separate to training and test data
dataTrain_noframes = trainData_noframes(~idx_noframes,:);
dataTest_noframes  = trainData_noframes(idx_noframes,:);

% Cross varidation (train: 70%, test: 30%) - Updated
cv_updated = cvpartition(size(trainData_updated,1),'HoldOut',0.3);
idx_updated = cv_updated.test;

% Separate to training and test data
dataTrain_updated = trainData_updated(~idx_updated,:);
dataTest_updated  = trainData_updated(idx_updated,:);