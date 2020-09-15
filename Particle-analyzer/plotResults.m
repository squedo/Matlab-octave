function plots = plotResults(pixelLength,particleDiameterClean,particle_storage,nameOfSample,l,...
    pixelWidthPicture,pixelLengthPicture,control0)

%%%% Ploting results and returning desired data

surfacePicture = (pixelWidthPicture/pixelLength)*(pixelLengthPicture/pixelLength)*10^-8; % cm2

% Mean particle size
meanParticleSize = mean(particleDiameterClean);
meanParticleSize = num2str(meanParticleSize);

% particle density
particleDensity = control0/(surfacePicture*l)*10^-8;
particleDensityString = num2str(particleDensity);

% particle

meanParticle = mean(particle_storage);
meanParticleString = num2str(meanParticle);

% Plotting

bins = 20;
plots = figure;

subplot(2,2,1:2:3);
hist(particleDiameterClean,bins); title([nameOfSample,' ->',' Mean particle size = ',meanParticleSize,' um. ',...
'particle density = ',particleDensityString,'*10^8 particles/cm^{2}. Mean particle surface = ',meanParticleString,' %']);
xlabel('particle size (um)'); ylabel('Number of particles'); axis('tight');


borders = linspace(min(particleDiameterClean),max(particleDiameterClean),bins);
bincounts = histc(particleDiameterClean,borders);

for i = 1:length(bincounts)
    particleBinsDensity(i) = bincounts(i)/(surfacePicture*l);
end

subplot(2,2,2);
ecdf(particleDiameterClean); ylabel('Cumulative');

subplot(2,2,4);
plot(borders,particleBinsDensity,'ob-');
xlabel('particle size (um)'); ylabel('particle density (cm^{-2})');

end