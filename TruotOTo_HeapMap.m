  %-------------------------------------------XeMay------------------------------------------
  function [ MangAnhOTo, oto, nen] = TruotOTo_HeapMap( anh, oto, nen)
  global net;
anh=imresize(anh, [450 600],'bilinear');%resize ve anh 450x600

a = [1 22 57 104 161];%To do y xuat hien cua cua so
MangAnhOTo = [];%Tat ca cac anh xe may tim duoc tu anh goc
for dem = 1: size(a,2)%Cho cua so di qua het hinh anh theo chieu doc
    ChiSoHeapMap = 0;%Lua lai xac xuat suat hien cua anh
    MangAnhHeapMap = [];%Luu lai cac anh da cat duoc theo chieu ngang
    CuaSo = 90 + (dem - 1) * 50;%Thay doi kich thuoc cua cua so
 
    x = floor(CuaSo*1.25);%Chieu x cua cua so
    y = CuaSo;
    Dichx = x * 0.215;%Cho cua so dich 25% theo chieu x
    ViTrix = a(dem);%Toa do theo truc y
	SoCuaSo = floor((size(anh,2)-x+Dichx) / Dichx);
    ChiSoHeapMap(SoCuaSo) = 0;%Xem nhu chua có xe OTo nao
  
        for i = 1: SoCuaSo
            ketqua = anh(ViTrix:ViTrix + y - 1,(i - 1) * Dichx +1:(i - 1) * Dichx + x,:);%cat anh tu anh goc
            ketqua = imresize(ketqua,[64 64], 'bilinear' );%resize ve anh 64x64

            features = extractHOGFeatures(ketqua);%Tinh HOG
            XtestThuNghiem = features';
            Ypred = net(XtestThuNghiem);  %Lay ra xac xuat         
            if Ypred(2) > Ypred(3)%Neu thoa man xac xuat thi luu vao ChiSoHeapMap 
                ChiSoHeapMap(i) = Ypred(2);
            
            end
            MangAnhHeapMap = cat(4,MangAnhHeapMap, ketqua);%Them Anh vao MangAnhHeapMap
        end
          % Ham HeapMap giup loai cac anh trung nhau
        [ MangAnhOTo, oto, nen] = HeapMap(MangAnhOTo, MangAnhHeapMap, ChiSoHeapMap, oto, nen);
end