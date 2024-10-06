function p4_4(x, speed)
    if speed < 0.5 || speed > 2
        error('Speed must be between 0.5 and 2.');
    end

    [audioData, Fs] = audioread(x);
    n = length(audioData);
    newLength = round(n / speed);
    
    oldTime = linspace(0, 1, n);
    newTime = linspace(0, 1, newLength);
    
    audioDataNew = inteinterp1rp1(oldTime, audioData, newTime, 'linear');
    
    sound(audioDataNew, Fs);
    
    outputFilename = ['output_', x];
    audiowrite(outputFilename, audioDataNew, Fs);
    disp(['Modified audio saved as ', outputFilename]);
end
