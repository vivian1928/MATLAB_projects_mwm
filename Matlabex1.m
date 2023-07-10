%% first episode
I1=rand(1000,1000)
I2=rand(1000,1000);
%% second episode
for i=1:1000
   for j=1:1000
     Isum(i,j)=I1(i,j)+I2(i,j);
   end
end
%% third episode
Isum=I1+I2;

%% fourth episode
x = fix(rand(2, 2) * 10)
y = fix(rand(2, 2) * 10)

%% fifth episode
result1 = x.*y;
result2 = x * y;
ImultA=I1*I2;
ImultB=I1.*I2;
%% sixth episode
Ia=imread('rooster.jpg');
Ib=imread('elephant.png');

%% Image Display
%imagesc(Ia);
%imshow(Ia);
%image(Ia);
% colormap('gray');
% figure(1), subplot(2,2,1), imagesc(Ia); title('RGB image');
% subplot(2,2,2), imagesc(Ia(:,:,1)); title('red channel');
% subplot(2,2,3), imagesc(Ia(:,:,2)); title('green channel');
% subplot(2,2,4), imagesc(Ia(:,:,3)); title('blue channel'); colorbar
figure(2), imagesc(Ib), axis('off'), axis('equal'); colorbar
colormap('gray');

%% Reading Values From An Image
% Ib
% Ib(3,:)
% Ib(:,3)
% Ib(1:6,1:4)
% imagesc(Ia(1:6,1:4,1));
% Ia(1:6,1:4,2);
% Ib(3,4)
disp('answer 1')
Ib(48, 144)
disp('answer 2')
Ib(414, 491)
disp('answer 3')
Ib(209, 309)
%% Image Conversion
% roosterintensity = rgb2gray(Ia);
% roosterdouble = im2double(roosterintensity);
disp('answer 1')
roosterdouble(317, 101)
disp('answer 2')
roosterdouble(194, 177)
disp('answer 3')
roosterdouble(149, 30)
%% Saving Images and Variables to Files
% imwrite(roosterintensity,'rooster_gray.jpg','jpg')
% figure(1), imagesc(Ia); title('RGB image');
% print -dpdf rooster_RGB.pdf
% help print
save('cv_cw1_variables.mat');

