function audioAnalysisResult = audioAnalyzer(audio,whatEar,Fs,names)
% audioAnalyzer: gets all the files present in "audio" and according to the
% refered ear "whatEar" returns frequency "fdata" and power "dBdata" of the
% monotone audio.

for i = 1:length(audio)
    
    y = audio{i};
    n = length(y);
    x = fft(y(:,whatEar(i)));
    P2 = abs(x/n);
    P1 = P2(1:n/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs(i)*(0:(n/2))/n;

    d = db(P1);
    [dBdata,idx] = max(d);
    fdata = f(idx);

    audioAnalysisResult(i,:) = [names(i) whatEar(i) fdata dBdata];

end

audioAnalysisResult = sortrows(audioAnalysisResult,3);




    


















