
x= data{1,40};%just get the roi timeseries from preprocessing folder of the conn output
Fs=.5;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)).*abs(xdft).^2; 
psdx(2:end-1) = 2*psdx(2:end-1); %power spectrum
freq = 0:Fs/length(x):Fs/2;
figure; plot(freq(2:37),psdx(2:37)); grid on; %only keep .001-.1hz
title('Periodogram Using FFT');
xlabel('Frequency (Hz)'); ylabel('Power')

totalPower = sum(abs(x).^2)/length(x);%this total power is similar to standard deviation


