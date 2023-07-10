%% import resouces
I=imread('elephant.png');
Id=im2double(I);
%% gabor test
help gabor2
gb1 = gabor2(3,0.1,90,0.75,90);
%% simple cells
Idgb1 = conv2(Id, gb1, 'valid');
figure(1), clf, colormap('gray')
subplot(2,2,1); imagesc(Id); axis('off','equal','tight'); colorbar, title('elephant');
subplot(2,2,2); imagesc(Idgb1); axis('off','equal','tight'); colorbar, title('elephant gabor');
%% answer1
disp('answer 1')
disp(Idgb1(360, 414))
disp('answer 2')
disp(Idgb1(276, 208))
%% complex cells
gb2 = gabor2(3,0.1,90,0.75,0);
Idgb2 = conv2(Id, gb2, 'valid');
Idgb3 = sqrt(Idgb1.^2 + Idgb2.^2);
figure(2), clf, colormap('gray')
subplot(2,2,1); imagesc(Id); axis('off','equal','tight'); colorbar, title('elephant');
subplot(2,2,2); imagesc(Idgb1); axis('off','equal','tight'); colorbar, title('elephant gabor');
subplot(2,2,3); imagesc(Idgb2); axis('off','equal','tight'); colorbar, title('elephant gabor');
subplot(2,2,4); imagesc(Idgb3); axis('off','equal','tight'); colorbar, title('elephant gabor');
%% answer1
disp('answer 1')
disp(Idgb3(223, 192))
disp('answer 2')
disp(Idgb3(395, 240))



