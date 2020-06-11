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

[V, D] = eig(A);
[freq,ind] = sort(diag(D));
D = D(ind, ind);
V = V(:,ind);
disp(freq)
V_ = inv(V);

for label=0:9
    index = (data(:,1) == label);
    labeled_imgs = imgs(index,:);
    img = squeeze(labeled_imgs(1,:));
    
    h = figure;
    subplot(2, 3, 1)
    my_imshow(reshape(img, 28, 28).')
    for i = 1:5
        p = (A^(i))*img.';
        subplot(2, 3, i+1)
        my_imshow(reshape(p, 28, 28).')
    end 
    savefig(h,sprintf("adjacen_shift(%d)",label));
end

for label=0:9
    index = (data(:,1) == label);
    labeled_imgs = imgs(index,:);
    
    h = figure;
    hold on;
    for j=1:100
        img = squeeze(labeled_imgs(j,:));
        spectrum = (V_)*img.';
        plot(abs(spectrum));
    end
    title(label)
    savefig(h,sprintf("adjacen_spec(%d)",label));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A(I==J) = 2 - A(I==J);

[V, D] = eig(A);
[freq,ind] = sort(diag(D));
D = D(ind, ind);
V = V(:,ind);
disp(freq)
V_ = inv(V);

for label=0:9
    index = (data(:,1) == label);
    labeled_imgs = imgs(index,:);
    img = squeeze(labeled_imgs(1,:));
    
    h = figure;
    subplot(2, 3, 1)
    my_imshow(reshape(img, 28, 28).')
    for i = 1:5
        p = (A^(i))*img.';
        subplot(2, 3, i+1)
        my_imshow(reshape(p, 28, 28).')
    end 
    savefig(h,sprintf("laplacian_shift(%d)",label));
end

for label=0:9
    index = (data(:,1) == label);
    labeled_imgs = imgs(index,:);
    
    h = figure;
    hold on;
    for j=1:100
        img = squeeze(labeled_imgs(j,:));
        spectrum = (V_)*img.';
        plot(abs(spectrum));
    end
    title(label)
    savefig(h,sprintf("laplacian_spec(%d)",label));
end

function my_imshow(A)
    imshow((A-min(min(A)))/max(max(A)))
end 
