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
function synthesis_vowel2(filename,required_snr,vowel,BPnoisefilter,modsigma)
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
    formantbandwidths = [47.92 * modsigma
76.90111111* modsigma
500.6022222* modsigma
568.3688889* modsigma
251.0244444* modsigma
516.2144444* modsigma
645.5211111* modsigma
594.1455556* modsigma
375.0477778* modsigma
426.3288889* modsigma]
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
formantbandwidths = [826.616
123.92* modsigma
186.428
204.724
208.746
330.352
143.37
167.864
718.678
271.586]
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
    formantbandwidths = [23.71* modsigma
465.066* modsigma
175.5028571* modsigma
1188.714* modsigma
121.048* modsigma
63.454* modsigma
163.355* modsigma
194.991* modsigma
688.355* modsigma
2615.316* modsigma]
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

BPnoise  = filter(BPnoisefilter,noise1);
snrr = snr(e,BPnoise);
if(required_snr == 0)
   required_snr=required_snr+0.001; 
end
gamma = (snrr/required_snr);
alpha = ((rms(e)^2)/(rms(BPnoise)^2))^((gamma -1)/gamma);
scaling_factor = sqrt(alpha);
% pwelch(BPnoise * scaling_factor)
excitation = e + (BPnoise * scaling_factor);
check_snr = snr(e,BPnoise .* scaling_factor);


snrr = snr(e,noise1);
exc = e + noise1;


[a,x1,f1_freq,sigma_freq] = genH1_vowel(fs,formantss,bandw,excitation) ;
x1_rs = resample(x1,48000,fs); 
fs = 48000; 

x = x1_rs; 
reconst_new = ramp_fix(x,fs,t_length_rise_fall); %62.5 ms
[b_coeff,a_coeff] = butter(10,8000/(fs/2)); %butter(20,10000/(fs/2));
r_filt = filter(b_coeff,a_coeff,reconst_new);
reconst1 = r_filt/norm(r_filt) * 15;
audiowrite('single_channel_stimuli.wav',reconst1,fs,'Bitspersample',16);
%cnt1 = cnt1+1;
% %
player = audioplayer(4*reconst1,fs);
play(player);

generated_decorrelated_signals(filename);
% str = ['killall python3'];
% unix(str)
% str2 = ['python3 play_8chn.py ' filename ' &'];
% unix(str2)
% [final_stimuli,Fs] = audioread(filename);
% player = audioplayer(final_stimuli,Fs);
% play(player);
temporaryvar=5
end