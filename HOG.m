close all;
clear all;

MyPath = 'D:\University\Hoc-phan\Do-An\total.unknow\fullnenoto\fullnenoto';%Duong dan thu muc
a=dir(fullfile(MyPath ,'*.png'));%Lay ra tat ca ten anh co duoi png trong folder duong dan MyPath

 DuLieu = [];%Luu cac gia tri cua HOG
for i = 1:length(a)
im = imread(strcat(MyPath,'\', a(i).name));
im = imresize(im, [64 64], 'bilinear');
features = extractHOGFeatures(im);

DuLieu = [DuLieu ; features];%Noi du lieu

i
end

 % xlswrite('D:\University\Hoc-phan\Do-An\total.unknow\fullnenoto\fullnenoto\test.xlsx',[DuLieu],1,'1'); 

