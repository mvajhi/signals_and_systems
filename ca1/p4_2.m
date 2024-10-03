[x,Fs] = audioread("voice.wav");

t = 0:length(x)-1; 
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Audio Signal');

audiowrite('x.wav', x, Fs);