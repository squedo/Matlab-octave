%functionMainAudioAnalyzer: this SW executes the following files in order
%to know if a recorded monotone audio has the expected fq and power:
%           - loadingAudio.m
%           - audioAnalyzer.m
%           - comparisonAudio.m
%           - txtGeneration.m
%
%Results are displayed in a txt file called testResults.txt and stored in
%the origin folder of the audios.
%
%The name of the audios to be analyzed must be writen using the following
%format to allow the detection of the channel L/R to be analyzed in each
%case:
%'125_+70L.wav.'

tic;

clc; clear all; close all;

%%% Loading the audios
[audio,whatEar,Fs,names,path,extensionOfAudio] = loadingAudio();

%%% Analyze the audios
audioAnalysisResult = audioAnalyzer(audio,whatEar,Fs,names);

%%% Compare the result of the analysis of the audios with the expected
%%% results
audioTestResult = comparisonAudio(audioAnalysisResult);

%%% Generate a txt file with the results in the origin folder of the audios
txtFile = txtGeneration(audioTestResult,path);

toc;