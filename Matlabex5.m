%% import resouces
I=imread('boat.png');
Idb=im2double(I); 
%% split the image
Ird=im2double(I(:,:,1));
Igd=im2double(I(:,:,2));
Ibd=im2double(I(:,:,3));
Id=im2double(rgb2gray(I));

figure(1), clf, colormap('gray');
subplot(2,2,1); imagesc(Id); axis('off','equal','tight'); colorbar, title('boat');
subplot(2,2,2); imagesc(Ird); axis('off','equal','tight'); colorbar, title('boatr');
subplot(2,2,3); imagesc(Igd); axis('off','equal','tight'); colorbar, title('boatg');
subplot(2,2,4); imagesc(Ibd); axis('off','equal','tight'); colorbar, title('boatb');
%% Intensity Histograms
figure(2), clf;
subplot(2,2,1); histogram(Id,64); title('boat histogram');
subplot(2,2,2); histogram(Ird,64); title('boatr histogram');
subplot(2,2,3); histogram(Igd,64); title('boatg histogram');
subplot(2,2,4); histogram(Ibd,64); title('boatb histogram');
%% split intensity 1
label0=0.68;
label1=0.47;
label2=0.37;
Id1=Id;
Id2=Id;
Id3=Id;
Id4=Id;

Id1(Id1>=label0)=0;
Id2((Id2<label0)&(Id2>=label1))=1;
Id3((Id3<label1)&(Id3>=label2))=2;
Id4(Id4<label2)=3;

figure(3), clf;
subplot(2,2,1); histogram(Id1); colorbar, title('boat>=0.68');
subplot(2,2,2); histogram(Id2); colorbar, title('0.47<=boat<0.68');
subplot(2,2,3); histogram(Id3); colorbar, title('0.37<=boat<0.47');
subplot(2,2,4); histogram(Id3); colorbar, title('boat<0.37');

figure(4), clf;
subplot(2,2,1); imagesc(Id1); axis('off','equal','tight'); colorbar, title('boat>=0.68');
subplot(2,2,2); imagesc(Id2); axis('off','equal','tight'); colorbar, title('0.47<=boat<0.68');
subplot(2,2,3); imagesc(Id3); axis('off','equal','tight'); colorbar, title('0.37<=boat<0.47');
subplot(2,2,4); imagesc(Id3); axis('off','equal','tight'); colorbar, title('boat<0.37');
%% split intensity 2
label0=0.68;
label1=0.47;
label2=0.37;
Id5=Id;

Id5(Id>=label0)=0;
Id5(Id<0.68 & Id >=0.47)=1;
Id5(Id<0.47 & Id >=0.37)=2;
Id5(Id<0.37)=3;

figure(5), clf;
imagesc(Id5); axis('off','equal','tight'); colorbar, title('boat split');
%% answer 1
disp('answer 1')
disp(Id5(92, 91))
disp('answer 2')
disp(Id5(286, 279))
disp('answer 3')
disp(Id5(292, 299))
disp('answer 4')
disp(Id5(451, 352))
%% right answer
figure, colormap('default')
Iseg=zeros(size(Id));
Iseg(Id<0.68)=1;
Iseg(Id<0.47)=2;
Iseg(Id<0.37)=3;
imagesc(Iseg); colorbar;
Iseg(92,91)
Iseg(286,279)
Iseg(292,299)
Iseg(451,352)
%% Morphological Operations 1
structuring = ones(3,3);
dilationId5 = imdilate(Id5, structuring);
erodeId5 = imerode(Id5, structuring);
openId5 = imopen(Id5, structuring);
closeId5 = imclose(Id5, structuring);
figure(6), clf;
subplot(2,2,1); imagesc(dilationId5); axis('off','equal','tight'); colorbar, title('boat dilate');
subplot(2,2,2); imagesc(erodeId5); axis('off','equal','tight'); colorbar, title('boat erode');
subplot(2,2,3); imagesc(openId5); axis('off','equal','tight'); colorbar, title('boat open');
subplot(2,2,4); imagesc(closeId5); axis('off','equal','tight'); colorbar, title('boat close');
%% Morphological Operations 2
circular = strel('disk',3,0);
dilation1Id5 = imdilate(Id5, circular);
erode1Id5 = imerode(Id5, circular);
open1Id5 = imopen(Id5, circular);
close1Id5 = imclose(Id5, circular);
figure(6), clf;
subplot(2,2,1); imagesc(dilation1Id5); axis('off','equal','tight'); colorbar, title('boat dilate');
subplot(2,2,2); imagesc(erode1Id5); axis('off','equal','tight'); colorbar, title('boat erode');
subplot(2,2,3); imagesc(open1Id5); axis('off','equal','tight'); colorbar, title('boat open');
subplot(2,2,4); imagesc(close1Id5); axis('off','equal','tight'); colorbar, title('boat close');
%% answer 2
disp('answer 1')
disp(dilation1Id5(220, 1))
disp('answer 2')
disp(erode1Id5(220, 1))
disp('answer 3')
disp(open1Id5(220, 1))
disp('answer 4')
disp(close1Id5(220, 1))
%% k-means Clustering1
figure, colormap('default')
Iseg=imsegkmeans(im2single(I),5);
imagesc(Iseg); colorbar; title('k-means Clustering on RGB');
%% k-means Clustering2
[segX,segY]=meshgrid(Iseg);
figure, mesh(X,Y,Z);
%% answer 2
disp('answer 1')
disp(Iseg(58, 612))
disp('answer 2')
disp(Iseg(145, 174))
disp('answer 3')
disp(Iseg(168, 539))
disp('answer 4')
disp(Iseg(349, 549))
disp('answer 5')
disp(Iseg(374, 229))
%% right answer
figure, colormap('default')
[a,b,c]=size(Idb);
[X,Y] = meshgrid(1:b,1:a);
featureSet = cat(3,Idb,X,Y);
Iseg=imsegkmeans(im2single(featureSet),5);
imagesc(Iseg); colorbar; title('k-means Clustering on RGB+XY')
disp('answer 1')
disp(Iseg(58, 612))
disp('answer 2')
disp(Iseg(145, 174))
disp('answer 3')
disp(Iseg(168, 539))
disp('answer 4')
disp(Iseg(349, 549))
disp('answer 5')
disp(Iseg(374, 229))
%% Hierarchical Agglomerative Clustering
Ismall=imresize(Idb,0.25,'bilinear');
[a,b,c]=size(Ismall);
Msmall=reshape(Ismall,[a*b,c]);
Mseg=clusterdata(Msmall,'cutoff',0.3,'criterion','distance','linkage','average','distance','euclidean');
Iseg=reshape(Mseg,[a,b]);
figure, colormap('default')
imagesc(Iseg); colorbar; title('Hierarchical Agglomerative Clustering on RGB')
%% answer4
disp('answer 1')
disp(Iseg(2, 40))
disp('answer 2')
disp(Iseg(46, 16))
disp('answer 3')
disp(Iseg(80, 26))
disp('answer 4')
disp(Iseg(88, 3))
disp('answer 5')
disp(Iseg(88, 125))
%%
disp(min(Msmall))
%% right answer
figure; colormap('default')
Msmall=Msmall-min(Msmall);
Msmall=Msmall./max(Msmall);
Mseg=clusterdata(Msmall,'cutoff',0.3,'criterion','distance','linkage','average','distance','euclidean');
Iseg=reshape(Mseg,[a,b]);
imagesc(Iseg); colorbar; title('Hierarchical Agglomerative Clustering on scaled RGB')
