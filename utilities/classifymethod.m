function [ correctRate,optC,optG, retYYSvm] = classifymethod(train_x,train_y,test_x,test_y )

%         addpath('./Tools');
%         addpath('./svm2');      
        [accSvm, retYYSvm, optC, optG] = svmc(train_x, train_y, test_x, test_y, 0, 0, 1, 1);
        correctRate = accSvm;


