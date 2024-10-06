function p4_3(x, Fs, speed)
    if speed ~= 0.5 && speed ~= 2
        error('Speed must be 0.5 or 2.');
    end

    if speed == 2
        audioDataNew = x(1:2:end);
        FsNew = Fs * speed;
    elseif speed == 0.5
        n = length(audioData);
        audioDataNew = zeros(2 * n - 1, 1);

        audioDataNew(1:2:end) = audioData;

        for i = 1:n-1
            audioDataNew(2*i) = (audioData(i) + audioData(i+1)) / 2;
        end
        FsNew = Fs * speed; 
    end
    sound(audioDataNew, FsNew);
end
