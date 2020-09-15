tic

clc; clear all; close all;

%%% Inputs

path = input('What is the path of the folder with the pictures to be analyzed?  ');
nominalSize = input('What is the nominal particle size of the samples in "um" units (i.e. 0.05)?  ');
pixelLength = input('What is the ratio pixel/um based on used magnification and scale on image (i.e. 200)?  ');
shapeFactorMax = input('What is the upper limit of shape factor you want to consider (i.e. 0.9)?  ');
shapeFactorMin = input('What is the lower limit of shape factor you want to consider (i.e. 0.715)?  ');
nameOfSample = input('What is the name of the sample? ');
extensionOfImages = input('What is the extension of the images? (i.e. tif)?  ');

%%% Constants

strelRatio = round(nominalSize*pixelLength*0.25); % pixel
limitParticleSize = strelRatio/pixelLength*0.75; % um

%%% Loading the images

[All,pixelWidthPicture,pixelLengthPicture] = feval('loadingImages',path,extensionOfImages);

%%% Image Processing and analysis

[l,particleDiameterClean,particle_storage,control0] = ...
    imageAnalysis(All,path,strelRatio,limitParticleSize,pixelLength,shapeFactorMax,shapeFactorMin);

%%% Plot results

plots = plotResults(pixelLength,particleDiameterClean,particle_storage,nameOfSample,l,...
    pixelWidthPicture,pixelLengthPicture,control0);

toc
