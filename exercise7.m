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
%% 6.Sume the outputs from simulated complex cells at multiple orientations
csize = size(Ic,3);
sum = 0;
for i=1:csize
    sum = sum + Ic(:,:,i);
end
figure,clf,colormap('gray');
imagesc(sum); axis('off','equal','tight'); colorbar, title('Combine of complex cells in different orientations');
%% 6.answer1
disp('answer1')
disp(Icombine(406,218))
disp('answer2')
disp(Icombine(314,142))