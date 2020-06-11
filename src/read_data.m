clc; clear; close all;
data = readmatrix('../data/mnist_test.csv');
h = figure;
imgs = data(:,2:end);
imgs = reshape(imgs, 10000, 784);

A = zeros(784, 784);

i = 1:784;
j = 1:784;
[I, J] = meshgrid(i, j);
A(mod(J-I, 784)==1) = 1;
A(mod(J-I, 784)==28) = 1;
A = A/2 ;
imshow(A)

[V, D] = eig(A);

figure;
img = squeeze(imgs(1,:));
subplot(2, 3, 1)
my_imshow(reshape(img, 28, 28).')
for i = 1:5
    p = (A^(i))*img.';
    subplot(2, 3, i+1)
    my_imshow(reshape(p, 28, 28).')
end 


function my_imshow(A)
    imshow(A/max(max(A)))
end 



[V, D] = eig(A);
spec = (V.')*img;

imshow()
%%%imshow(squeeze(imgs(1,:,:)))




