function [ MangAnh, xe, nen] = HeapMap(MangAnh, MangAnhHeapMat, ChiSoHeapMap, xe, nen)
if length(ChiSoHeapMap) > 1 %So anh phai lon hon hoc bang 2 moi di xet diem dau va diem cuoi
 	if ChiSoHeapMap(1) < ChiSoHeapMap(2)%So sanh xac xuat phan tu dau va phan tu thu 2
        ChiSoHeapMap(1) = 0;
    end
             
 	if ChiSoHeapMap(length(ChiSoHeapMap)) < ChiSoHeapMap(length(ChiSoHeapMap) - 1)%So sanh xac xuat phan tu cuoi va phan tu ke cuoi
    	ChiSoHeapMap(length(ChiSoHeapMap)) = 0;
  	end
end

for ChiSo = 2 : length(ChiSoHeapMap) - 1    %So sanh phan tu thu 2 cho den phan tu ke cuoi
     if (ChiSoHeapMap(ChiSo) < ChiSoHeapMap(ChiSo - 1)) || (ChiSoHeapMap(ChiSo) < ChiSoHeapMap(ChiSo + 1))
        ChiSoHeapMap(ChiSo) = 0;
     end
end
             
for ChiSo = 1 : length(ChiSoHeapMap)%Chi lay nhung anh co ChiSoHeapMap khac 0
    if ChiSoHeapMap(ChiSo) ~= 0
        xe = xe + 1;
        MangAnh = cat(4, MangAnh, MangAnhHeapMat(:,:,:,ChiSo));
    else 
        nen = nen +1;
    end
end
end