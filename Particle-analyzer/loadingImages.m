function [All,pixelWidthPicture,pixelLengthPicture] = loadingImages(path,extensionOfImages)

srcFiles = dir([path,'\*.',extensionOfImages]);

imStack = [];
for i = 1 : length(srcFiles)
    filename = strcat([path,'\'],srcFiles(i).name);
    I = imread(filename);
    [pixelWidthPicture,pixelLengthPicture] = size(I);
    All(:,:,i) = I;
end

end
