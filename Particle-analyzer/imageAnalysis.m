function [l,particleDiameterClean,particle_storage,control0] = ...
    imageAnalysis(All,path,strelRatio,limitParticleSize,pixelLength,shapeFactorMax,shapeFactorMin)

[n,~,l] = size(All);

for i = 1:l
    
    I = All((n*0.15):(n*0.85),:,i);
    I_storage(:,:,i) = I;
    
   [bw,particle_percentage,backgroundSituation,lvl] = segmentation(I,strelRatio);
    
    lvl_storage(i) = lvl;
    backgroundStorage(i) = backgroundSituation;
    particle_storage(i) = particle_percentage;
    bw_storage(:,:,i) = bw;
    
    cc = bwconncomp(bw, 4);
    particleData = regionprops(cc,'EquivDiameter','MajorAxisLength','MinorAxisLength');
    
    particleEqd = [particleData.EquivDiameter];
    particleMajorAxis = [particleData.MajorAxisLength];
    particleMinorAxis = [particleData.MinorAxisLength];
       
    for j = 1:length(particleEqd)
        particleEqdStorage(j,i) = particleEqd(j)/pixelLength;
        particleMajorAxisStorage(j,i) = particleMajorAxis(j)/pixelLength;
        particleMinorAxisStorage(j,i) = particleMinorAxis(j)/pixelLength;
    end
end

control0 = length(particleEqdStorage(particleEqdStorage > 0));

%%% Filtering data

ratio = particleMinorAxisStorage./particleMajorAxisStorage;

% Cleaning data based on shape and size (1st filtration)

[n,m] = size(particleEqdStorage);

for i = 1:m
  
  for j = 1:n
    
    if particleEqdStorage(j,i) < limitParticleSize || ratio(j,i) < shapeFactorMin
       particleDiameterClean(j,i) = 0;

    elseif ratio(j,i) > shapeFactorMax
       particleDiameterClean(j,i) = particleEqdStorage(j,i);
 
    elseif   shapeFactorMin < ratio(j,i) < shapeFactorMax
       particleDiameterClean(j,i) = particleMajorAxisStorage(j,i);
       
    end
  
  end
  
end

control1 = length(particleDiameterClean(particleDiameterClean > 0));

particleDiameterClean = particleDiameterClean(particleDiameterClean > 0);
Q = quantile(particleDiameterClean,[0.25 0.75]);
particleDiameterClean = particleDiameterClean(particleDiameterClean > Q(1)/(3/2));
particleDiameterClean = particleDiameterClean(particleDiameterClean < Q(2)*(3/2));

control2 = length(particleDiameterClean);

%%% Segmentation check

checkPlots = segmentationCheck(I_storage,bw_storage,path,l);

end