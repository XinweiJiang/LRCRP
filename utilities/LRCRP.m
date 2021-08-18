function [ d_train_x,d_test_x] = LRCRP(train_x,test_x,options,maxDim)
%   train_x, each column is a data point;
%   options.lamuda and options.beta is a paramators,
%   type is zhe demension reduction type,it is LRCRP1(use I) or LRCRP2(use noI)

%---------------calculate W-------------------------%
addpath('./utilities');
W=creatgraphW(train_x,options); 
eigvector= getPresentation(W,train_x);
P =  eigvector(:,1:maxDim)';
    if ~isreal(P)
        warning('there is complex data!');
    end
 d_train_x= P*train_x;
 d_test_x = P*test_x;
end

