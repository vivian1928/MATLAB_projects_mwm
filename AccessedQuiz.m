%% 1.Redundancy Reduction by Retinal Ganglion Cells (simulated with Difference of Gaussians)
% read resources
Iwoods=imread('woods.png');
Idwoods=im2double(Iwoods);
%% 1.DoG mask and on-centre, off-surround retinal ganglion cells
dog=fspecial('gaussian',21,2)-fspecial('gaussian',21,3.5); %on-centre, off-surround DoG mask
IdwoodsDog=conv2(Idwoods,dog,'same');
figure(1), clf, imagesc(IdwoodsDog); colormap('gray'); colorbar
%% 1.answer1
disp('answer1')
disp(IdwoodsDog(134,78))
%% 1.Redundancy Reduction
offsets=[0:30];
for offset=offsets
   sim(offset+1)=corr2(IdwoodsDog(1:end-offset,:),IdwoodsDog(1+offset:end,:));
end
figure(2), clf,
plot(offsets,sim);
legend({'DoG woods'});
xlabel('shift'); ylabel('correlation coefficient')
%% 1.answer2
disp('answer2')
disp(sim(6))
disp('answer3')
disp(sim(25))
%% 2.Colour Opponent Cells
% read resources
Irooster=imread('rooster.jpg');
Idrooster=im2double(Irooster);
%% 2.blue-off, yellow-on colour-opponent cells
gc=fspecial('gaussian',15,2.5); %center
gs=fspecial('gaussian',15,2.5); %surround
Y=mean(Idrooster(:,:,1:2),3);
IdroosterBonYoff=-conv2(Idrooster(:,:,3),gc,'same')+conv2(Y,gs,'same');
figure; imagesc(IdroosterBonYoff); axis('off','equal','tight'); colorbar, title('blue-off, yellow-on');
%% 2.answer 1
disp('answer1')
disp(IdroosterBonYoff(302,5))
disp('answer2')
disp(IdroosterBonYoff(171,256))
%% 3.Laplacian of Gaussian (LoG) Masks
g1=fspecial('gaussian',9,1.5);
g2=fspecial('gaussian',30,5);
laplacian=[-0.125,-0.125,-0.125;-0.125,1,-0.125;-0.125,-0.125,-0.125];
LoG1=conv2(g1,laplacian,'same');
LoG2=conv2(g2,laplacian,'same');
IwoodsLog1=conv2(Idwoods,LoG1,'same');
IwoodsLog2=conv2(Idwoods,LoG2,'same');
figure(3),clf
subplot(2,2,1), mesh(LoG1);colormap('jet');
subplot(2,2,2), mesh(LoG2);colormap('jet');
subplot(2,2,3), imagesc(IwoodsLog1); colormap('jet'), axis('equal','tight'); colorbar
subplot(2,2,4), imagesc(IwoodsLog2); colormap('jet'), axis('equal','tight'); colorbar
%% 3.answer1
disp('answer1')
disp(IwoodsLog1(76,22))
disp('answer2')
disp(IwoodsLog1(160,24))
disp('answer3')
disp(IwoodsLog2(76,22))
disp('answer4')
disp(IwoodsLog2(160,24))
%% 4.Equivalent LoG and DoG Masks
% array 
offsetslow=[0.5:0.1:10];
offsetshigh=[0.5:0.1:10];
Euclidean=[];
%% 4.different DoG
g3=fspecial('gaussian',60,5);
LoG3=conv2(g3,laplacian,'same');
for i=1:length(offsetslow)
   for j=1:length(offsetshigh)
   DoGtry=fspecial('gaussian',60,offsetslow(i))-fspecial('gaussian',60,offsetshigh(j)); %on-centre, off-surround DoG mask
   LoG3=LoG3./max(max(LoG3));  % measure distance
   DoGtry=DoGtry./max(max(DoGtry)); % measure distance
   Euclidean(i,j) = sqrt(sum(sum((DoGtry-LoG3).^2))); % measure distance
   end
end
%% 4.min DoG
disp(min(min(Euclidean)))
%% 4.test DoG
g3=fspecial('gaussian',36,5);
LoG3=conv2(g3,laplacian,'same');
DoGtry=fspecial('gaussian',36,4.7)-fspecial('gaussian',36,5.4); %on-centre, off-surround DoG mask
LoG3=LoG3./max(max(LoG3));
DoGtry=DoGtry./max(max(DoGtry));
Euclideantry = sqrt(sum(sum((DoGtry-LoG3).^2)))
%% 5.Laplacian Image Pyramid
% Gaussian Masks
g4 = fspecial('gaussian',9,1.5);
%% 5.Pyramid 3
figure(4),clf,colormap('gray');

Gauwoods1 = conv2(Idwoods, g4, 'same'); % Gauss first for oringinal image Idwoods(double of woods.png) I1
IdwoodsPy1 = Idwoods - Gauwoods1; % first L1=I1 - (I1*G)
subplot(2,2,1); imagesc(IdwoodsPy1); axis('off','equal','tight'); colorbar, title('Pyramid 1');

Image2 = imresize(Gauwoods1, 0.5, 'nearest'); % I1=down 2(I0*G)
Gauwoods2 = conv2(Image2, g4, 'same'); %I1*G
IdwoodsPy2 = Image2 - Gauwoods2; % L1=I1-(I1*G)
subplot(2,2,2); imagesc(IdwoodsPy2); axis('off','equal','tight'); colorbar, title('Pyramid 2');

Image3 = imresize(Gauwoods2, 0.5, 'nearest'); % I2=down 2(I1*G)
Gauwoods3 = conv2(Image3, g4, 'same'); %I2*G
IdwoodsPy3 = Image3 - Gauwoods3; %L2=I2-(I2*G)
subplot(2,2,3); imagesc(IdwoodsPy3); axis('off','equal','tight'); colorbar, title('Pyramid 3');
%% 5.answer1
disp('answer1')
disp(IdwoodsPy3(3,6))
disp('answer2')
disp(IdwoodsPy3(1,3))
%% 6.Complex Cells (at multiple orientations)
% import resource
Ielephant=imread('elephant.png');
Idelephant=im2double(Ielephant);
%% 6.gabor complex cells different orientations
orientation = [0,15,30,45,60,75,90,105,120,135,150,165];
for i=1:length(orientation)
    gA=gabor2(3,0.1,orientation(i),0.75,90);
    gB=gabor2(3,0.1,orientation(i),0.75,0);
    IdelephantgA=conv2(Idelephant,gA,'valid');
    IdelephantgB=conv2(Idelephant,gB,'valid');
    Ic(:,:,i)=sqrt((IdelephantgA.^2)+(IdelephantgB.^2));
end
%% 6.Combine the max of the pixels
Icombine=zeros(length(Ic),length(Ic));
for i=1:length(Ic)
    for j=1:length(Ic)
        Icombine(i,j)=max([Ic(i,j,1),Ic(i,j,2),Ic(i,j,3),Ic(i,j,4),Ic(i,j,5),...
            Ic(i,j,6),Ic(i,j,7),Ic(i,j,8),Ic(i,j,9),Ic(i,j,10),Ic(i,j,11),Ic(i,j,12)]);
    end
end
figure(5),clf,colormap('gray');
imagesc(Icombine); axis('off','equal','tight'); colorbar, title('Combine of complex cells in different orientations');
%% 6.answer1
disp('answer1')
disp(Icombine(406,218))
disp('answer2')
disp(Icombine(314,142))
%%
figure(11), clf
g=fspecial('gaussian',9,1.5);
Itrywoods=Idwoods;
subplot(2,2,1),imagesc(Itrywoods); axis('equal','tight'),colorbar
for i=2:3
   Itrywoods=imresize(conv2(Itrywoods,g,'same'), 0.5, 'nearest');
   subplot(2,2,i),imagesc(Itrywoods); axis('equal','tight'), colorbar
end
disp('answer1')
disp(Itrywoods(3,6))
disp('answer2')
disp(Itrywoods(1,3))
