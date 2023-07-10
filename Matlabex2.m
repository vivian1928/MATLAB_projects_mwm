%% Introduction
Ia=imread('rooster.jpg');
Ib=imread('elephant.png');
Ic=imread('woods.png');

%% Image Modification
Ib(403,404)=1;
Ib(401:end, 401:end)=255;
figure(1), clf, imagesc(Ib); colormap('gray')
Isyn=zeros(201,201);
Isyn(51:150,51:150)=1;
Isyn(81:120,:)=0.5;
Isyn(:,81:120)=0.75;
figure(2), clf, imagesc(Isyn); colormap('gray')

%% Resizing and Reshaping Images
Ibsmall1=imresize(Ib,0.5);
Iblarge1=imresize(Ib,2);
figure(3), clf
subplot(2,2,1), imagesc(Ibsmall1); title('Half size')
subplot(2,2,2), imagesc(Iblarge1); title('Double size')

Iblarge2=imresize(Ib,2,'bilinear');
Ibsmall2=imresize(Ib,0.5,'nearest');
Ibpad=padarray(Ib,[10,50]);
Ibcrop=imcrop(Ib,[250,50,120,300]);

figure(4), clf
subplot(2,2,1), imagesc(Ibsmall2); title('Nearest half')
subplot(2,2,2), imagesc(Iblarge2); title('Bilinear double')
subplot(2,2,3), imagesc(Ibpad); title('Padded')
subplot(2,2,4), imagesc(Ibcrop); title('Cropped')

Isynv=Isyn(:);
Isynv(1:202:end)=1; %Take out a point every 202 interval.
Isynre=reshape(Isynv,201,201);
figure(5), clf, imagesc(Isynre); colormap('gray')

%% answer 1
disp('answer1'), Ibsmall2(250, 235)
disp('answer2'), Ib(250, 235)
disp('answer3'), Iblarge2(250, 235)
disp('answer4'), Ib(500, 470)
disp('answer5'), Iblarge2(1000, 940)

%% Translating Images for Intensity Change Detection
Ibd=im2double(Ib);
Ibdiffv=Ibd(1:end-1,:)-Ibd(2:end,:);
figure(6), clf, imagesc(Ibdiffv); colormap('gray'); colorbar
Ibdiffh=Ibd(:,1:end-1)-Ibd(:,2:end);
figure(7), clf, imagesc(Ibdiffh);colormap('gray');colorbar

Ibdiff=sqrt(Ibdiffh(1:end-1,:).^2+Ibdiffv(:,1:end-1).^2);
figure(8), clf, imagesc(Ibdiff); colormap('gray'); colorbar
bw=imbinarize(Ibdiff,0.075);
figure(9), clf, imagesc(bw); colormap('gray'); colorbar
%% answer 2
disp('answer1'), Ibdiffv(498, 400)
disp('answer2'), Ibdiffh(498, 400)
disp('answer3'), Ibdiff(498, 400)
disp('answer4'), bw(498, 400)
%% Redundancy in Natural Images
[Icshift3, corr1] = shiftcorrelation(Ic, 3);
figure(10), clf, imagesc(Icshift3); colormap('gray'); colorbar
disp(corr1)
%% correct answer 1
offsets=[0:30];
for offset=offsets
   simb(offset+1)=corr2(Ib(1:end-offset,:),Ib(1+offset:end,:));
   simc(offset+1)=corr2(Ic(1:end-offset,:),Ic(1+offset:end,:));
end
figure(8), clf,
plot(offsets,simb);
hold on;
plot(offsets,simc);
legend({'elephant','woods'});
xlabel('shift'); ylabel('correlation coefficient')
%% correct answer 2
simb(3)
%% Retinal Ganglion Cells (simulated with Difference of Gaussians)
dog=fspecial('gaussian',11,1.25)-fspecial('gaussian',11,1.75);
Ibdog=conv2(Ibd,dog,'same');
figure, clf, imagesc(Ibdog); colormap('gray'); colorbar
%% answer 3
Ibdog(170, 493)
%% Colour Opponent Cells
Iad=im2double(Ia);
gc=fspecial('gaussian',9,1); %center
gs=fspecial('gaussian',9,1.5); %surround
IaRG=conv2(Iad(:,:,1),gc,'same')-conv2(Iad(:,:,2),gs,'same'); %Note colour channels are the third-dimension of Iad and channel 1 is the red channel, and channel 2 is the green channel.
IaGR=conv2(Iad(:,:,2),gc,'same')-conv2(Iad(:,:,1),gs,'same');
Y=mean(Iad(:,:,1:2),3);
IaBY=conv2(Iad(:,:,3),gc,'same')-conv2(Y,gs,'same'); %RG第三维求平均
IaYB=conv2(Y,gc,'same')-conv2(Iad(:,:,1),gs,'same');

IaRG(340, 2)
IaGR(340, 2)
IaBY(340, 2)
IaYB(340, 2)
%% correct answer
Iad=im2double(Ia);
gc=fspecial('gaussian',9,1);
gs=fspecial('gaussian',9,1.5);

figure(9), clf, colormap('gray')
IaRG=conv2(Iad(:,:,1),gc,'same')-conv2(Iad(:,:,2),gs,'same');
subplot(2,2,1); imagesc(IaRG); axis('off','equal','tight'); colorbar, title('red-on, green-off');
IaGR=conv2(Iad(:,:,2),gc,'same')-conv2(Iad(:,:,1),gs,'same');
subplot(2,2,2); imagesc(IaGR); axis('off','equal','tight'); colorbar, title('green-on, red-off');
Y=mean(Iad(:,:,1:2),3);
IaBY=conv2(Iad(:,:,3),gc,'same')-conv2(Y,gs,'same');
subplot(2,2,3); imagesc(IaBY); axis('off','equal','tight'); colorbar, title('blue-on, yellow-off');
IaYB=conv2(Y,gc,'same')-conv2(Iad(:,:,3),gs,'same');
subplot(2,2,4); imagesc(IaYB); axis('off','equal','tight'); colorbar, title('yellow-on, blue-off');

IaYB(340, 2);

%% Lab Format for Colour Images

% figure(10), clf, colormap('gray')
Iagray=rgb2gray(Iad);
% subplot(2,3,1); imagesc(Iagray); axis('off','equal','tight'); colorbar, title('intensity')
% subplot(2,3,2); imagesc(IaRG); axis('off','equal','tight'); colorbar, title('red-on, green-off');
% subplot(2,3,3); imagesc(IaYB); axis('off','equal','tight'); colorbar, title('yellow-on, blue-off');
Ialab=rgb2lab(Iad);
% subplot(2,3,4); imagesc(Ialab(:,:,1)); axis('off','equal','tight'); colorbar, title('L-channel');
% subplot(2,3,5); imagesc(Ialab(:,:,2)); axis('off','equal','tight'); colorbar, title('a-channel');
% subplot(2,3,6); imagesc(Ialab(:,:,3)); axis('off','equal','tight'); colorbar, title('b-channel');

Ialab(100,100,1)
Ialab(100,100,2)
Ialab(100,100,3)

%%
A=[2,2,2;2,]
