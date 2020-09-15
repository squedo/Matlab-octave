function audioTestResult = comparisonAudio(audioAnalysisResult)
%comparisionAudio: compares the results of the analysis of each audio contained in "audioAnalysisResult" with
%the expected value of frequency and power.
%Expected values of frequency and power are previously provided to the
%software.
%
%NOTE: if any additional frequency that would be tested, must be previously reported on arrays
%fqExpected and dbExpected.

fqExpected = [125,250,500,750,1000,1500,2000,3000,4000,6000,8000]; 
dbExpected = [-23.4815125018695 ...
              -27.9815125018695 ...
              -26.9815125018695 ...
              -30.9815125018695 ...
              -31.4815125018695 ...
              -31.9815125018695 ...
              -29.4815125018695 ...
              -26.4815125018695 ...
              -26.9815125018695 ...
              -18.9815125018695 ...
              -24.4815125018695];
          
expectedResults = [fqExpected;dbExpected]';

[n1,~] = size(audioAnalysisResult);
[n2,~] = size(expectedResults);

for i = 1:n1
    for j = 1:n2
        a(i,j) = audioAnalysisResult{i,3} - expectedResults(j,1);
    end
end

for i = 1:n1
    [~,idx(i)] = min(abs(a(i,:)));
end

for i = 1:n1
    
        if abs(1-expectedResults(idx(i),1)/audioAnalysisResult{i,3}) <= 0.02 && ...
            abs(expectedResults(idx(i),2) - audioAnalysisResult{i,4}) <= 2
        conclusion{i} = 'POSITIVE';
        else conclusion{i} = 'NEGATIVE';
                    
    end
end

audioTestResult = [audioAnalysisResult conclusion'];

end