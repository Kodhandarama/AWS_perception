%%%%%%%%%%%%%%%%
% Experiment 2 
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%
%Functions used
%variable_data_exp2(), getpitch1, genH2_ImpResp, ramp_fix

% Problems: bw discontinuity

% clear variables;
% clc;

%addpath '/home/arthi/matlab/Functions/spectrogram/' '/home/arthi/matlab/Functions/Auditory toolbox/'; 
function synthesis_vowel_wgn(filename,required_snr,vowel,BPnoisefilter)
% load('A_filters.mat')
% load('U_filters.mat')
% load('I_filters.mat')
load('A_filters_v2.mat')
load('lowpass8000.mat')
if vowel =='u'
    formantfrequencies =[276.653
729.39
1874.153
2810.542
3852.895
4110.756
5354.253
6180.132
6897.899
8000]
    disp(formantfrequencies)
    formantbandwidths = [47.92/2
76.90111111/2
500.6022222/2
568.3688889/2
251.0244444/2
516.2144444/2
645.5211111/2
594.1455556/2
375.0477778/2
426.3288889/2]
    disp(formantbandwidths)
elseif vowel =='a'
formantfrequencies =[73.914
780.165
1196.058
2661.916
3323.918
3864.073
4630.714
5291.067
6505.292
6956.786]
disp(formantfrequencies)
formantbandwidths = [826.616/2
123.92/2
186.428/2
204.724/2
208.746/2
330.352/2
143.37/2
167.864/2
718.678/2
271.586/2]
disp(formantbandwidths)
elseif vowel =='i'
    formantfrequencies = [287.364
2281.456
2930.192
3170.431
3919.456
4470.975
5809.803
6688.874
7781.95
8000]
    disp(formantfrequencies)
    formantbandwidths = [23.71/2
465.066/2
175.5028571/2
1188.714/2
121.048/2
63.454/2
163.355/2
194.991/2
688.355/2
2615.316/2]
    disp(formantbandwidths)
else 
    disp("Invalid vowel")
end
variable_data_exp2();
load('var_data_exp2.mat'); 

t = [0:(T*fs)-1]/fs;

cnt1 = 1;

% %formant frequency and bandwidth
change1= 0; change2 = 0; 
% f_from = form_freq(alpha1,:)*(1+change1) ;
% f_to = form_freq(alpha2,:)*(1+change2);
% [bw_from,bw_to] = bw_adjust(alpha1,alpha2,change1,change2,form_freq);
bandw = formantbandwidths;
formantss = formantfrequencies;
alpha1 = 1; alpha2 = 1; 
i = 1; 
[e,pitch] = getpitch1(t,p1(i),p2(i),p3(i),fs,ptype);

noise1 = wgn(length(e),1,(10*log10((rms(e)^2)/(10^(required_snr/10)))))';

% BPnoise  = filter(BPnoisefilter,noise1);
% snrr = snr(e,BPnoise);
% 
% gamma = (snrr/required_snr);
% alpha = ((rms(e)^2)/(rms(BPnoise)^2))^((gamma -1)/gamma);
% scaling_factor = sqrt(alpha);
% % pwelch(BPnoise * scaling_factor)
excitation = e + noise1;
check_snr = snr(e,noise1);

% 
% snrr = snr(e,noise1);
% excitation = e + noise1;


[a,x1,f1_freq,sigma_freq] = genH1_vowel(fs,formantss,bandw,excitation) ;
x1_rs = resample(x1,48000,fs); 
fs = 48000; 
%env = sin(2*pi*2*t); 
%env = gampdf(t(1:fs+fs/2),3,1/10);
%delay = 20e-3*fs + (100e-3*fs)*rand(1,10);delay = round(delay);
%env_seq = [env zeros(1,delay(1)) env zeros(1,delay(2)) env zeros(1,delay(3)) env zeros(1,delay(4)) ...
%    env zeros(1,delay(5)) env zeros(1,delay(6)) env zeros(1,delay(7)) env zeros(1,delay(8)) env zeros(1,delay(9)) env zeros(1,delay(10))]; 
%env_seq = [env env env env env env env env env env]; 
x = x1_rs; %(1:length(env_seq)).*env_seq; 
% filename = 'test4.wav'
reconst_new = ramp_fix(x,fs,t_length_rise_fall); %62.5 ms
[b_coeff,a_coeff] = butter(10,8000/(fs/2)); %butter(20,10000/(fs/2));
r_filt = filter(b_coeff,a_coeff,reconst_new);
reconst1 = r_filt/norm(r_filt) * 15;
audiowrite('single_channel_stimuli.wav',reconst1,fs,'Bitspersample',16);
%cnt1 = cnt1+1;
% %
% player = audioplayer(4*reconst1,fs);
% play(player);

generated_decorrelated_signals(filename);
str = ['killall python3'];
unix(str)
str2 = ['python3 play_8chn.py ' filename ' &'];
unix(str2)
% [final_stimuli,Fs] = audioread(filename);
% player = audioplayer(final_stimuli,Fs);
% play(player);
temporaryvar=5
end