function checkPlots = segmentationCheck(I_storage,bw_storage,path,l)

outputFileName1 = 'cropedImages.tif';
outputFileName2 = 'checkSegmentation.tif';

for i = 1:l
   imwrite(I_storage(:,:,i),fullfile(path,outputFileName1),'WriteMode','append');
   imwrite(bw_storage(:,:,i),fullfile(path,outputFileName2),'WriteMode','append');
end

a = 1; b = l;
r = (b-a)*rand(1,1) + a;
r = round(r);
rr = int2str(r);

checkPlots = figure;
imshowpair(I_storage(:,:,r),bw_storage(:,:,r)); title(['Checking segmentation picture nº ',rr]);

end