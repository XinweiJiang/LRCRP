function [eigvector_new] = getPresentation(W,train_x)
%   train_x, each column is a data point;
%   lamda is a paramaters;
%   
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[D,N] = size(train_x);
%---------------get SL-------------------------%
SL = train_x*(eye(N)-W-W'+W*W')*train_x';%局部紧密性SL=X(I-W-W^T+W*W^T)X^T=X*(I-W)'*(I-W)*X^T
%---------------get ST-------------------------%
meanx  = mean(train_x,2);%返回每一维度的平均值
ST  = zeros(D,D);
for i = 1:N
    ST = ST+ (train_x(:,i)-meanx)*(train_x(:,i)-meanx)';%计算全局可分性ST=求和（x-x~）（x-x~）^T
end
% SL=max(SL,SL');
% ST=max(ST,ST');
[eigvector, eigvalue] = eig(ST,SL);%求解ST*P=lamuda*SL*P求解最大特征值特征向量
eigvalue = diag(eigvalue);
[junk, index] = sort(-eigvalue);
eigvalue = eigvalue(index);%将特征值从大到小排好序
eigvector_new = eigvector(:,index);%将特征值对应特征向量也排好来
for tmp = 1:size(eigvector_new,2) 
     eigvector_new(:,tmp) = eigvector_new(:,tmp)./norm(eigvector_new(:,tmp));%点除奇异值?
end
%     %%======call 1NN classifier: knnclassify======%%
%     maxDim=length(eigvalue);
end

