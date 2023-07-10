%% 6.Complex Cells (at multiple orientations)
% import resource
Ielephant=imread('elephant.png');
Idelephant=im2double(Ielephant);
%% 6.gabor complex cells different orientations
orientation = [0,15,30,45,60,75,90,105,120,135,150,165];
Isum = 0;
for i=1:length(orientation)
    gA=gabor2(3,0.1,orientation(i),0.75,90); %quardrant gabor A, for phase = 90
    IdelephantgA=conv2(Idelephant,gA,'valid');
    Isum = Isum + IdelephantgA.^2; 
end
Isum1=Isum.^(1/12);
figure(5),clf,colormap('gray');
imagesc(Isum1); axis('off','equal','tight'); colorbar, title('Combine of complex cells in different orientations');
%% 6.answer1
disp('answer1')
disp(Isum1(406,218))
disp('answer2')
disp(Isum1(314,142))
%% 4.Equivalent LoG and DoG Masks
s1=3;
s2=6;
size=ceil(6*max(s1,s2));
logtry=conv2(fspecial('gaussian',(size-2),5),laplacian,'full');
dogtry2=fspecial('gaussian',size,s1)-fspecial('gaussian',size,s2);
logtry=logtry./max(max(logtry));
dogtry2=dogtry2./max(max(dogtry2));
Euclideantry1 = sqrt(sum(sum((dogtry2-logtry).^2)));

while true
    s1=s1+0.1;
    s2=s2-0.1;
    if s1>s2
        break
    end
    size=ceil(6*max(s1,s2));
    disp([num2str(s1), '  ', num2str(s2)]);
    logtry=conv2(fspecial('gaussian',(size-2),5),laplacian,'full');
    dogtry2=fspecial('gaussian',size,s1)-fspecial('gaussian',size,s2);
    logtry=logtry./max(max(logtry));
    dogtry2=dogtry2./max(max(dogtry2));
    newEuclideantry1 = sqrt(sum(sum((dogtry2-logtry).^2)));
    if newEuclideantry1 <= Euclideantry1
        Euclideantry1=newEuclideantry1;
        news1=s1;
        news2=s2;
    else
        break
    end
end
disp(news1);
disp(news2);
disp(Euclideantry1)
