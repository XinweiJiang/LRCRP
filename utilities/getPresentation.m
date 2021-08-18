function [eigvector_new] = getPresentation(W,train_x)
%   train_x, each column is a data point;
%   lamda is a paramaters;
%   

[D,N] = size(train_x);
%---------------get SL-------------------------%
SL = train_x*(eye(N)-W-W'+W*W')*train_x';%SL=X(I-W-W^T+W*W^T)X^T=X*(I-W)'*(I-W)*X^T
%---------------get ST-------------------------%
meanx  = mean(train_x,2);%
ST  = zeros(D,D);
for i = 1:N
    ST = ST+ (train_x(:,i)-meanx)*(train_x(:,i)-meanx)';%ST=\sum（x-x~）（x-x~）^T
end
% SL=max(SL,SL');
% ST=max(ST,ST');
[eigvector, eigvalue] = eig(ST,SL);%Solve ST*P=lamuda*SL*P
eigvalue = diag(eigvalue);
[junk, index] = sort(-eigvalue);
eigvalue = eigvalue(index);%Sort eig value
eigvector_new = eigvector(:,index);%
for tmp = 1:size(eigvector_new,2) 
     eigvector_new(:,tmp) = eigvector_new(:,tmp)./norm(eigvector_new(:,tmp));%
end
%     %%======call 1NN classifier: knnclassify======%%
%     maxDim=length(eigvalue);
end

