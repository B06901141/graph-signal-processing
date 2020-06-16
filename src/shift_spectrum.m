clc; clear; close all;
data = readmatrix('../data/mnist_test.csv');

imgs = data(:,2:end);
imgs = reshape(imgs, 10000, 784);

A = zeros(784, 784);
i = 1:784;
j = 1:784;
[I, J] = meshgrid(i, j);
A(J == I + 1 & mod(I,28) ~= 0) = 1;
A(J == I - 27 & mod(I,28) == 0) = 1;
A(J==I+28 & I <= 756) = 1;
A(J==I-756 & I > 756) = 1;
%A(I==J) = 2 - A(I==J);

h = figure;
imshow(A)
savefig(h,"adj");

[V, D] = eig(A);
%[freq,ind] = sort(angle(diag(D)));
%D = D(ind, ind);
%V = V(:,ind);
V_ = inv(V);
eigen_value = diag(D);

h = figure;
scatter(real(eigen_value),imag(eigen_value))
title("Eigen Value");
xlabel("Real");
ylabel("Imag");
xlim([-2,2]);
ylim([-2,2]);
savefig(h,"eigen");

for label=0:9
    index = (data(:,1) == label);
    labeled_imgs = imgs(index,:);
    img = squeeze(labeled_imgs(1,:));
    
    h = figure;
    subplot(2, 3, 1)
    my_imshow(reshape(img, 28, 28).')
    title("Original")
    tmp = A;
    for i = 1:5
        p = tmp*img.';
        subplot(2, 3, i+1)
        my_imshow(reshape(p, 28, 28).')
        title(sprintf("Shift by %d",i));
        tmp = tmp*A;
    end 
    suptitle("Shift Operation");
    savefig(h,sprintf("adjacen_shift(%d)",label));
end

for label=0:9
    index = (data(:,1) == label);
    labeled_imgs = imgs(index,:);
    
    h = figure;
    for j=1:100
        img = squeeze(labeled_imgs(j,:));
        spectrum = (V_)*img.';
        spectrum(abs(eigen_value) < 0.1) = 0;
        stem3(real(eigen_value),imag(eigen_value),abs(spectrum));
        xlabel("Real");
        ylabel("Imag");
        title(sprintf("Spectrum of the Images Labeled %d.",label));
        hold on;
    end
    savefig(h,sprintf("adjacen_spec(%d)",label));
end


function my_imshow(A)
    imshow((A-min(min(A)))/max(max(A)))
end 

