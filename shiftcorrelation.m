function [Iashift,correlationco] = shiftcorrelation(Ia, shift)
% SHIFT PIXELS AND CORRELATION COEFFIENT
% two parameters, the image, the shift number
[m,n] = size(Ia);
Iashift = zeros(m, n);
Iashift(1:end - shift,:) = Ia(1 + shift:end,:);    
correlationco = corr2(Iashift, Ia);
end

