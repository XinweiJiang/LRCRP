function [ xx ] = sgpNormalize( x)
[n, d] = size(x);
xx = zeros(n, d);
Normalize = max(x);
xx = x./repmat(Normalize, size(x,1),1);





