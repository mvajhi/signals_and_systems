function p4_4(x, Fs, speed)
    if speed < 0.5 || speed > 2
        error('Speed must be between 0.5 and 2.');
    end

    n = length(x);
    newLength = round(n / speed);
    
    oldTime = linspace(0, 1, n);
    newTime = linspace(0, 1, newLength);
    
    audioDataNew = interp1(oldTime, x, newTime, 'linear');
    
    sound(audioDataNew, Fs);
end
