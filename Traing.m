function  Traing()
close all
clear all

warning off
tr1 = xlsread('D:\University\Hoc-phan\Do-An\endgame.xlsx');
tr = tr1(1:7176,:) ;                % read train.csv

n = size(tr, 1);                    % number of samples in the dataset
targets  = tr(:,1);                 % 1st column is |label|
targetsd = dummyvar(targets);       % convert label into a dummy variable
inputs = tr(:,2:end);               % the rest of columns are predictors

inputs = inputs';                   % transpose input
targets = targets';                 % transpose target
targetsd = targetsd';               % transpose dummy variable

rng(1);                             % for reproducibility
c = cvpartition(n,'Holdout',n/3);   % hold out 1/3 of the dataset obtain 

Xtrain = inputs(:, training(c));    % 2/3 of the input for training
Ytrain = targetsd(:, training(c));  % 2/3 of the target for training
Xtest = inputs(:, test(c));         % 1/3 of the input for testing
Ytest = targets(test(c));           % 1/3 of the target for testing
Ytestd = targetsd(:, test(c));      % 1/3 of the dummy variable for testing

net = patternnet(5);               % Create a neural network for pattern recognition problem (using softmax)
net.divideParam.trainRatio = 0.7;   % 70% of the training set for training
net.divideParam.valRatio = 0.15;       % disable the validation set
net.divideParam.testRatio = 0.15;    % 30% of the training set for testing (validation)
net.trainParam.epochs = 1000;         % change the number of epochs to achieve the best result
[net,tr] = train(net,Xtrain,Ytrain);

   save D:\University\Hoc-phan\Do-An\finalnet.mat net
disp('oke');