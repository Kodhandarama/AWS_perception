[noise,Fs] = audioread("/home/kodhandarama/Desktop/Desktop/Analog/Shreeram_Chandra/shreeram/python_work/python_sounddevice/vowels_in_channels/vowel_a.wav");

fs= 48000;

% noise =wgn(1000,1,10);

% noise =  zeros(10000,1);
% for i = 1:10000
%         noise(i) =noise(i) + 5;
% end
noise
filternoise = filter(Octavebandfilter8000,noise);
filterednoise = filter(lowpass20000,filternoise);

yn =fft(noise);
yfn = fft(filterednoise);

n = length(noise);          % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(yn).^2/n;    % power of the DFT

plot(f,power)
xlabel('Frequency')
ylabel('Power')

% plot(n,filterednoise)

% n = length(filterednoise);          % number of samples
% f = (0:n-1)*(fs/n);     % frequency range
% power = abs(yfn).^2/n;    % power of the DFT
% 
% plot(f,power)
% xlabel('Frequency')
% ylabel('Power')