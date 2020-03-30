 function [ MangAnhXeMay, xemay, nen] = TruotXeMay_HeapMap( anh, xemay, nen)
  global net;
anh=imresize(anh, [450 600],'bilinear');%resize ve anh 450x600

   a = [1 12 37 54 74 97 122 150 180 213 248 291];%To do y xuat hien cua cua so
   MangAnhXeMay = [];%Tat ca cac anh xe may tim duoc tu anh goc
for dem = 1: size(a,2)%Cho cua so di qua het hinh anh theo chieu doc
    ChiSoHeapMap = 0;%Lua lai xac xuat suat hien cua anh
    MangAnhHeapMat = [];%Luu lai cac anh da cat duoc theo chieu ngang
    
    CuaSo = 50 + (dem - 1) * 10;%Thay doi kich thuoc cua cua so

    x = floor(CuaSo*0.75);%Chieu x cua cua so
    y = CuaSo;
    Dichx = x * 0.25;%Cho cua so dich 25% theo chieu x
    ViTrix = a(dem);%Toa do theo truc y

	 SoCuaSo = floor((size(anh,2)-x+Dichx) / Dichx);
       ChiSoHeapMap(SoCuaSo) = 0;%Xem nhu chua có xe May nao
       
        for i = 1: SoCuaSo
            ketqua = anh(ViTrix:ViTrix + y - 1,(i - 1) * Dichx +1:(i - 1) * Dichx + x,:);%cat anh tu anh goc
            ketqua = imresize(ketqua,[64 64], 'bilinear' );%resize ve anh 64x64
            
            features = extractHOGFeatures(ketqua);%Tinh HOG
            XtestThuNghiem = features';
            Ypred = net(XtestThuNghiem);%Lay ra xac xuat
          
            if ((Ypred(1) > 0.75))%Neu thoa man xac xuat thi luu vao ChiSoHeapMap 

                ChiSoHeapMap(i) = Ypred(1);
            end
            
            MangAnhHeapMat = cat(4,MangAnhHeapMat, ketqua);%Them Anh vao MangAnhHeapMap
        end
        % Ham HeapMap giup loai cac anh trung nhau
         [ MangAnhXeMay, xemay, nen] = HeapMap(MangAnhXeMay, MangAnhHeapMat, ChiSoHeapMap, xemay, nen);
end