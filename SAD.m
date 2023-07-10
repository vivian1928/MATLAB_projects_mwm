function [sad] = SAD(left,right)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
sad=0;
    for i=1:size(left,1)
        for j=1:size(left,2)
            sad = sad+abs(left(i,j)-right(i,j));
        end
    end
end

