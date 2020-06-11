clc; clear; close all;
data = readmatrix('../data/mnist_test.csv');

imgs = data(:,2:end);
imgs = reshape(imgs, 10000, 784);

A = zeros(784, 784);

i = 1:784;
j = 1:784;
[I, J] = meshgrid(i, j);
A(mod(J-I, 784)==1) = 1;
A(mod(J-I, 784)==28) = 1;
%A(I==J) = 2 - A(I==J);

[V, D] = eig(A);
[freq,ind] = sort(diag(D));
D = D(ind, ind);
V = V(:,ind);

img = squeeze(imgs(20,:));
img0 = reshape(img,28,28).';

spec = inv(V)*img.';

h = figure;
for i=1:15
    s = -27 + 56*(i-1);
    e = s + 55;
    if e > 784
        e = 784;
    end
    if s < 0
        s = 1;
    end
    sp = zeros(784,1);
    sp(s:e) = spec(s:e);
    img = real(V*sp);
    img = reshape(img,28,28).';
    subplot(3,5,i)
    imshow(img)
end
