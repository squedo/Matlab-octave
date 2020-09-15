function [audio,whatEar,Fs,names,path,extensionOfAudio] = loadingAudio()
% loadingAudio: this file loads all the audios that are stored in a
% "path" that have the extension "extensionOfAudio"

%%% Inputs
% NOTE: string inputs must be entered using quotation marks as follows:
% 'C:\Users\Sergio\Desktop\TestIDNEO'
% 'wav'
path = input('What is the name of the path of the folder with the audios?  ');
extensionOfAudio = input('What is the extension of the audios? (i.e. wav)  ');

files = dir([path,'\*.',extensionOfAudio]);
audio = cell(1,length(files));

for i = 1:length(files)
    filename = strcat([path,'\'],files(i).name);
    names{i} = files(i).name;
    [audio{i},Fs(i)] = audioread(filename);
    
    if isempty(strfind(filename,'L'))
    whatEar(i) = 2;
    else whatEar(i) = 1;
    end
    
end

end