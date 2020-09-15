function txtFile = txtGeneration(audioTestResult,path)
% txtGeneration: generates a txt file with results contained in
% "audioTestResult"

txtFile = fopen([path,'\testResults.txt'],'w');

fprintf(txtFile,'%s %s %s %s %s\r\n','fileName','L/R','measuredFq(Hz)','measuredPower(dB)','conclusion');

formatSpec = '%s %1.0f %8.4f %8.4f %s\r\n';

[n,~] = size(audioTestResult);
for i = 1:n
    fprintf(txtFile,formatSpec,audioTestResult{i,:});
end

fclose(txtFile);

end