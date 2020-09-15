function [bw,particle_percentage,backgroundSituation,lvl] = segmentation(I,strelRatio)

    Idouble = im2double(I);
    [~,m] = size(Idouble);

    for j = 1:m
        col = Idouble(:,j);
        col = col(col > 0);
        meanCol = mean(col);
        meanColStorage(j) = meanCol;
    end

    mx = max(meanColStorage); mn = min(meanColStorage);
    a = (mx - mn)/mx;

    if  a < 0.1
        backgroundSituation = 1;
    else backgroundSituation = 0;
    end

    se1 = strel('disk',strelRatio,0);
    se2 = strel('square',strelRatio*4);

    % Segmentation background homogeneous
    if backgroundSituation == 1

        lvl = graythresh(I);
        bw = im2bw(I,lvl);
        bw = imcomplement(bw);
        bw = imopen(bw,se1);
        bw = imfill(bw,26,'holes');
        
        b = find(bw == 0); black = length(b);
        w = find(bw == 1); white = length(w);
        particle_percentage = (white / (black + white)) * 100;
   
        bw = imclearborder(bw);
    
    % Segmentation background heterogeneous
    elseif backgroundSituation == 0
     
        background = imcomplement(imclose(I,se2));
        Im = I + background;
        lvl = graythresh(Im);
        bw = im2bw(Im,lvl);
        bw = imcomplement(bw);
        bw = imopen(bw,se1);
        bw = imfill(bw,26,'holes');

        b = find(bw == 0); black = length(b);
        w = find(bw == 1); white = length(w);
        particle_percentage = (white / (black + white)) * 100;

        bw = imclearborder(bw);

    end

end


