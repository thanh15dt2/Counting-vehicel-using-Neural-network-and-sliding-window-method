function [net,targets,targetsd] = task1();
close all, clear all

load D:\University\Hoc-phan\Do-An\finalnet.mat
global net;
oto = 0;
xemay = 0;
nen = 0;

anh = imread('D:\University\Hoc-phan\Do-An\AnhDaCat\AnhDaCat\h32.png');
anh=imresize(anh, [450 600],'bilinear');
figure, imshow (anh);
figure,
ToaDoSubplot = 1;

  %-------------------------------XeMay-------------------------------
   [ MangAnhXeMay, xemay, nen] = TruotXeMay_HeapMap( anh, xemay, nen);
 for i = 1 : size(MangAnhXeMay, 4)
        subplot(4,4,ToaDoSubplot);
        imshow(MangAnhXeMay(:,:,:,i));
        title('Xe May');
        ToaDoSubplot = ToaDoSubplot + 1;
 end
% ---------------------------------------------------------------------
% %-------------------------------OTo-------------------------------
    [ MangAnhOTo, oto, nen] = TruotOTo_HeapMap( anh, oto, nen)
for i = 1 : size(MangAnhOTo, 4)
        subplot(4,4,ToaDoSubplot);
        imshow(MangAnhOTo(:,:,:,i));
        title('O To');
        ToaDoSubplot = ToaDoSubplot + 1;
 end
% % ---------------------------------------------------------------------
disp('So luong xe oto: '); oto
disp('So luong xe may: '); xemay
disp('So luong nen: '); nen 