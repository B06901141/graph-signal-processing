clc; clear; close all;
data = readmatrix('../data/mnist_train.csv');

h = figure;
imgs = data(:,2:end);
imgs = reshape(imgs, 60000, 28, 28);

imshow(squeeze(imgs(1,:,:)))

