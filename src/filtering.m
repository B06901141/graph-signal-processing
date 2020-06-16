clc; clear; close all;
set(0,'defaultTextInterpreter','latex');

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

[V, D] = eig(A);
[freq,ind] = sort(diag(D));
D = D(ind, ind);
V = V(:,ind);
eigen_value = diag(D);

for label=0:9
    index = (data(:,1) == label);
    labeled_imgs = imgs(index,:);
    img = squeeze(labeled_imgs(1,:));
    h = figure;
    index = 1;
    for r = [sqrt(4/3),sqrt(8/3),sqrt(10/3)]
        subplot(3,3,index);
        index = index + 1;
        hold on;
        scatter(real(eigen_value),imag(eigen_value))
        viscircles([0,0],r);
        title(sprintf("$ |\\lambda | < %.2f $",r));
        xlim([-2,2]);
        ylim([-2,2]);

        subplot(3,3,index);
        index = index + 1;
        spec = V\img.';
        spec(abs(eigen_value) > r) = 0;
        recon = V*spec;
        recon = reshape(recon,28,28).';
        imshow(recon);
        title("Inside");

        subplot(3,3,index);
        index = index + 1;
        spec = V\img.';
        spec(abs(eigen_value) < r) = 0;
        recon = V*spec;
        recon = reshape(recon,28,28).';
        imshow(recon)
        title("Outside");
    end
    suptitle(sprintf("Image Filtering with label = %d",label));
    savefig(h,sprintf("filter(%d)",label));
end




