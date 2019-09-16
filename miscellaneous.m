close all;
clear all;
clc;

load("data_final.mat");

train_labels = data_train_combined(:,2);
[C,ia,ic] = unique(data_train_labels);
a_counts = accumarray(ic,1);
a_counts = num2cell(a_counts);
count_labels = [C, a_counts];