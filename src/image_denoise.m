clc; clear; close all; 
rng(0);
img = imread('test4.jpeg');
img = rgb2gray(img);

imga = img(65:128, 65:128);
noise = 10*randn(64);
I2 = im2double(imga);
I = im2double(img);

y = I2;
A = pos_filter(64, 10);
B = pixel_filter(y, 10);
K = A.*B;



figure;
imshow(K)
title('Adjacency matrix')

degree = diag(sum(K, 2));

L = degree - K;

[V, D]= eig(K);


[freq,ind] = sort(diag(D));
D = D(ind, ind);
V = V(:,ind);

y_ = reshape(y.', numel(y), 1);
spec = V\y_;

figure;
tiledlayout(3, 3)
hold on 
for i = 1:9
    nexttile;
    im = V(:, i).*spec(i,1);
    im = reshape(im.', 64, 64 );
    imshow(rescale(im))
end
hold off


figure;
tiledlayout(3, 3)
hold on 
for i = 1:9
    nexttile;
    im = V(:, end-i).*spec(end-i,1);
    im = reshape(im.', 64, 64 );
    imshow(rescale(im))
end
hold off


figure;
noise_spec = V\reshape(noise.',64*64, 1);
plot(noise_spec)
title('Noise spectrum')




alpha = 10^43;
filter = 1./(1+alpha*freq);

denoised = spec.* (filter);

y_c = V*denoised;

img_de = reshape(y_c, 64, 64);
figure;
subplot(1, 3, 1)
imshow(img_de)
title('reconstructed')
subplot(1, 3 ,2)
imshow(y)
title('noisy image')
subplot(1, 3, 3)
imshow(imga)
title('original image')







function A = pos_filter(size, sigma)
    i = 1:size;
    j = 1:size;
    n = size^2; 
    
    [i, j] = meshgrid(i , j);

    x = reshape(i, 1, n);
    y = reshape(j, 1, n);

    dist = zeros(n, n);

    for i = 1 : n
        dist(i, :) = (x - x(i)).^2 + (y - y(i)).^2;
    end
    
    A = exp(-1*dist./(sigma^2));
end
function B = pixel_filter(X, sigma)
    n = numel(X);
    X_flat = (reshape(X.', 1, n));
    X_new = zeros(n, n);
    for i = 1:n
        X_new(i, :) = X_flat;
    end
    d = (X_new - X_new.').^2;
    B = exp(-1*d/(sigma^2));
     
end



