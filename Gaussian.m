function [Gaussianop] = Gaussian(x, y, sigma)
%GAUSSIAN 此处显示有关此函数的摘要
%   此处显示详细说明
Gaussianop = (1/(2*pi*sigma^2)) * exp(-(x^2+y^2)/(2*(sigma^2)));
end

