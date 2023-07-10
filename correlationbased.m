%% correlation-based methods
Ileft=[4,7,6,7;3,4,5,4;8,7,6,8];
Iright=[0,0,0,0,0,0;0,7,6,7,5,0;0,4,5,4,5,0;0,7,6,8,7,0;0,0,0,0,0,0];
Ileftcor=[3,2];
Irightcor=[2,2];
window=[3,3];
Ileftx0y0=[(Ileftcor(2)-floor(window(2)/2)),Ileftcor(1)-(floor(window(1)/2))];
Ileftx1y1=[(Ileftx0y0(1)+window(2)-1),(Ileftx0y0(2)+window(1)-1)];
sad=[];
for i=2:size(Iright,1)-1
    for j=2:size(Iright,2)-1
        Irightcor=[i,j];
        Irightx0y0=[(Irightcor(1)-floor(window(1)/2)),(Irightcor(2)-floor(window(2)/2))];
        Irightx1y1=[(Irightx0y0(1)+window(1)-1),(Irightx0y0(2)+window(2)-1)];
        sad(i,j)=SAD(Ileft(Ileftx0y0(1):Ileftx1y1(1),Ileftx0y0(2):Ileftx1y1(2)),Iright(Irightx0y0(1):Irightx1y1(1),Irightx0y0(2):Irightx1y1(2)));
    end
end
%% corrlation
L=[187,168;203,290;215,87;234,28;366,142];
R=[101,394;115,186;135,128;269,243;336,178];
for i=1:size(L,1)
    for j=1:size(R,1)
        disp(SAD(L(i,:),R(j,:)))
    end
end
%% RANSAC
% L=[10,4;3,8;0,2;6,9;9,1];
% R=[3,7;1,1;5,7;8,0;1,2];
L=[187,168;203,290;215,87;234,28;366,142];
R=[101,394;115,186;135,128;269,243;336,178];
deltax=R(4,1)-L(1,1);
deltay=R(4,2)-L(1,2);
corrx=L(5,1)+deltax
corry=L(5,2)+deltay
%% Harris Corner detector 1
I=[1,0,0,0,0;0,1,0,0,0;1,1,1,0,0;0,0,0,0,0];
Gx=[-1,1];
Gy=[-1;1];
Ix=conv2(I,Gx,'same');
Iy=conv2(I,Gy,'same');
%% Harris Corner detector 2
Ix2=Ix.*Ix;
Iy2=Iy.*Iy;
Ixy=Ix.*Iy;
w=[1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];
Sx2=conv2(Ix2,w,'same');
Sy2=conv2(Iy2,w,'same');
Sxy=conv2(Ixy,w,"same");
%% Harris Corner detector 3
w2=[1,1,1;1,1,1;1,1,1];
Sx22=conv2(Ix2,w2,'same');
Sy22=conv2(Iy2,w2,'same');
Sxy2=conv2(Ixy,w2,'same');
%%
for i=1:2
    for j=1:3
        sum(sum(Ix2(i:i+2,j:j+2)))
        sum(sum(Ixy(i:i+2,j:j+2)))
        sum(sum(Iy2(i:i+2,j:j+2)))
        disp('answer')
    end
end
%% 
H1=[4,3;3,7];
H2=[2,1;1,4];
H3=[1,1;1,2];
H4=[3,2;2,5];
H5=[2,1;1,3];
H6=[1,1;1,2];
[vec,val]=eig(H1)
%%
det1=val(1,1)*val(2,2);
trace1=val(1,1)+val(2,2);
det2=H1(1,1)*H1(2,2)-H1(1,2)^2;
trace2=H1(1,1)+H1(2,2);
%% 
det2=H6(1,1)*H6(2,2)-H6(1,2)^2;
trace2=H6(1,1)+H6(2,2);
k=0.05;
R6=det2-k*(trace2^2);