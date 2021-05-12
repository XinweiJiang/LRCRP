The code is for the work, if you find it is useful, please cite our work:

[1] L. Xiong, X. Jiang, Y. Yu, X. Jiang, and J. Ma, "Spatial-Aware Collaborative Representation for Hyperspectral Remote Sensing Image Classification," IEEE Geoscience and Remote Sensing Letters, vol. 14, no. 3, pp. 404-408, 2017.

If you need another two datasets (PaviaU and Salinas), please feel free to contact me. Or you can download them from http://www.ehu.eus/ccwintco/index.php/Hyperspectral_Remote_Sensing_Scenes

PaviaU: http://www.ehu.eus/ccwintco/uploads/e/ee/PaviaU.mat, http://www.ehu.eus/ccwintco/uploads/5/50/PaviaU_gt.mat

Salinas: http://www.ehu.eus/ccwintco/uploads/a/a3/Salinas_corrected.mat, http://www.ehu.eus/ccwintco/uploads/f/fa/Salinas_gt.mat



clc;clear all; 
close all;

addpath(genpath('utilities\.'));
addpath('.\data');

dataSetName='Indianpines';%PaviaU
switch dataSetName
case 'Indianpines'
    load Indian_pines_corrected;load Indian_pines_gt;
    data = indian_pines_corrected;
    gth  = indian_pines_gt;
case 'PaviaU'
    load PaviaU;load PaviaU_gt;
    data = paviaU;
    gth  = paviaU_gt;
end


%%==========parameter setting==========%%
demen_options=[];
demen_options.lamuda = 0.001;       % optimal parameters for lamuda =0.001 on Indianpines and lamuda =0.001 on paviaU
demen_options.beta =0.0001;         % optimal parameters for beta =0.0001 on Indianpines and beta =0.0001 on paviaU
demen_options.k = 7;    
demen_options.norm1_1 = 40;         %indian:40 paviau:35
nTrEachClass = 30 ;                 %number of training data from each class
maxDim =30;                         %dimension of the feature-reduced space

for nSeed = 1:1%10%                 %randomly choose the training data
    [ train_x,train_y,test_x,test_y]= ChooseRSdata_zxx(data,gth,nTrEachClass,nSeed);
    train_x = train_x';
    test_x = test_x';
    train_y = train_y';
    test_y = test_y';
    [d_train_x,d_test_x] = LRCRP(train_x,test_x,demen_options,maxDim); 
    [correctRate,optC,optG, predictY] = classifymethod(d_train_x',train_y',d_test_x',test_y');
    fprintf('DS:%s train:%d test:%d DR:LRCRP lamuda :%f beta:%f   to %d accuracy is %f\n',dataSetName,size(train_x,2),size(test_x,2),demen_options.lamuda,demen_options.beta,maxDim,correctRate,optC,optG); 
end