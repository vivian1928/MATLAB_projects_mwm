%% Introduction
% Ia=imread('rooster.jpg');
% Ib=imread('elephant.png');
% Ic=imread('boxes.pgm');

Iad=im2double(rgb2gray(Ia));
Ibd=im2double(Ib);
Icd=im2double(Ic);

figure(1), clf, colormap('gray')
subplot(2,2,1); imagesc(Iad); axis('off','equal','tight'); colorbar, title('rooster');
subplot(2,2,2); imagesc(Ibd); axis('off','equal','tight'); colorbar, title('elephant');
subplot(2,2,3); imagesc(Icd); axis('off','equal','tight'); colorbar, title('boxes');
%% Box Masks
boxmask1 = ones(5,5)/25;
boxmask2 = fspecial('average',25);

conv21rooster = conv2(Iad, boxmask1, "same");
conv22rooster = conv2(Iad, boxmask2, "same");

figure(2), clf, colormap('gray')
subplot(2,2,1); imagesc(Iad); axis('off','equal','tight'); colorbar, title('rooster');
subplot(2,2,3); imagesc(conv21rooster); axis('off','equal','tight'); colorbar, title('5*5 avgconv');
subplot(2,2,4); imagesc(conv22rooster); axis('off','equal','tight'); colorbar, title('25*25 avgconv');
%% Boxes
conv21boxes = conv2(Icd, boxmask1, "same");
conv22boxes = conv2(Icd, boxmask2, "same");

figure(3), clf, colormap('gray')
subplot(2,2,1); imagesc(Icd); axis('off','equal','tight'); colorbar, title('boxes');
subplot(2,2,3); imagesc(conv21boxes); axis('off','equal','tight'); colorbar, title('5*5 avgconv');
subplot(2,2,4); imagesc(conv22boxes); axis('off','equal','tight'); colorbar, title('25*25 avgconv');
%% answer
disp('answer1: ')
conv21rooster(297, 220)
disp('answer2: ')
conv22rooster(297, 220)
disp('answer3: ')
conv21boxes(10, 78)
disp('answer4: ')
conv22boxes(10, 78)
%% Gaussian Masks
Gaussianmask1 = fspecial('gaussian',9,1.5);
Gaussianmask2 = fspecial('gaussian',60,10);
%% Gaussian
gaussian1rooster = conv2(Iad, Gaussianmask1, "same");
gaussian2rooster = conv2(Iad, Gaussianmask2, "same");
gaussian1boxes = conv2(Icd, Gaussianmask1, "same");
gaussian2boxes = conv2(Icd, Gaussianmask2, "same");

figure(4), clf, colormap('gray')
subplot(2,2,1); imagesc(gaussian1rooster); axis('off','equal','tight'); colorbar, title('rooster 1.5 gaussian');
subplot(2,2,2); imagesc(gaussian2rooster); axis('off','equal','tight'); colorbar, title('rooster 10 gaussian');
subplot(2,2,3); imagesc(gaussian1boxes); axis('off','equal','tight'); colorbar, title('boxes 1.5 gaussian');
subplot(2,2,4); imagesc(gaussian2boxes); axis('off','equal','tight'); colorbar, title('boxes 10 gaussian');
%% answer
disp('answer1: ')
gaussian1rooster(334, 213)
disp('answer2: ')
gaussian2rooster(334, 213)
disp('answer3: ')
gaussian1boxes(4, 47)
disp('answer4: ')
gaussian2boxes(4, 47)
%% First-Derivative Masks
yfirstderivative=[-1;1];
xfirstderivative=[-1,1];
yfdelephant=conv2(Ibd,yfirstderivative,'valid');
xfdelephant=conv2(Ibd,xfirstderivative,'valid');
figure(5), clf, colormap('gray')
subplot(2,2,1); imagesc(yfdelephant); axis('off','equal','tight'); colorbar, title('elephant y first-derivative');
subplot(2,2,2); imagesc(xfdelephant); axis('off','equal','tight'); colorbar, title('elephant x first-derivative');
%% answer
disp('answer1: ')
yfdelephant(143, 227)
disp('answer2: ')
xfdelephant(143, 227)
disp('answer3: ')
yfdelephant(278, 60)
disp('answer4: ')
xfdelephant(278, 60)
%% Laplacian Masks
laplacianmask=[-1/8, -1/8, -1/8; -1/8, 1, -1/8; -1/8, -1/8, -1/8];
laprooster=conv2(Iad,laplacianmask,'same');
lapboxes=conv2(Icd,laplacianmask,'same');
figure(6), clf, colormap('gray')
subplot(2,2,1); imagesc(Iad); axis('off','equal','tight'); colorbar, title('rooster');
subplot(2,2,2); imagesc(Icd); axis('off','equal','tight'); colorbar, title('boxes');
subplot(2,2,3); imagesc(laprooster); axis('off','equal','tight'); colorbar, title('rooster laplacian');
subplot(2,2,4); imagesc(lapboxes); axis('off','equal','tight'); colorbar, title('boxes laplacian');
%% answer
disp('answer1: ')
lapboxes(20, 39)
disp('answer2: ')
lapboxes(20, 40)
disp('answer3: ')
lapboxes(20, 41)
disp('answer4: ')
lapboxes(20, 42)
%% Gaussian Derivative Masks
Gaussianmask3 = fspecial('gaussian',21,2.5);
GaussianxDerivative = conv2(Gaussianmask3, xfirstderivative, 'valid');
GaussianyDerivative = conv2(Gaussianmask3, yfirstderivative, 'valid');

GxDboxes = conv2(Icd, GaussianxDerivative, "same");
GyDboxes = conv2(Icd, GaussianyDerivative, "same");
figure(7), clf, colormap('jet')
subplot(2,2,1); mesh(GaussianxDerivative); title('GaussianxDerivative');
subplot(2,2,2); mesh(GaussianyDerivative); title('GaussianyDerivative');
subplot(2,2,3); imagesc(GxDboxes); axis('off','equal','tight'); colorbar, title('GxDboxes');
subplot(2,2,4); imagesc(GyDboxes); axis('off','equal','tight'); colorbar, title('GyDboxes');
%% L2 combination
Icdg=sqrt(GxDboxes.^2+GyDboxes.^2);
figure(8), clf, colormap('gray')
imagesc(Icdg); axis('off','equal','tight'); colorbar, title('GxDboxes');
%% answer
disp('answer1: ')
GxDboxes(20, 39)
disp('answer2: ')
GxDboxes(20, 40)
disp('answer3: ')
GxDboxes(20, 41)
disp('answer4: ')
GxDboxes(20, 42)
%% Canny Edge Detection
figure(9), clf
IcCanny=edge(Icd,'Canny');
imagesc(IcCanny), title('Canny'); colormap('gray'); axis('equal', 'tight'); colorbar
%% Gaussian Image Pyramid
Gaudown2rooster = imresize(conv2(Iad, Gaussianmask1, 'same'), 0.5, 'nearest');
Gaudown4rooster = imresize(conv2(Gaudown2rooster, Gaussianmask1, 'same'), 0.5, 'nearest');
Gaudown8rooster = imresize(conv2(Gaudown4rooster, Gaussianmask1, 'same'), 0.5, 'nearest');

figure(10), clf, colormap('gray')
subplot(2,2,1); imagesc(Iad); axis('off','equal','tight'); colorbar, title('oringinal rooster');
subplot(2,2,2); imagesc(Gaudown2rooster); axis('off','equal','tight'); colorbar, title('down2 rooster');
subplot(2,2,3); imagesc(Gaudown4rooster); axis('off','equal','tight'); colorbar, title('down4 rooster');
subplot(2,2,4); imagesc(Gaudown8rooster); axis('off','equal','tight'); colorbar, title('down8 rooster');
%% answer
disp('answer1: ')
Gaudown8rooster(8, 23)
disp('answer2: ')
Gaudown8rooster(17, 17)
