%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to specify parameters for synthesis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function variable_data_exp2(alpha_val)

T = 6;            % Time duration
duration = T;     % Time duration
fs = 48000;         % Sampling frequency

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formant frequency details from Rabiner and Juang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

form_freq = [
            270 2290 3010 3781 4200;    % 1  /i/
%             265 3020 4268 7905 9961;

%             1047.31 1753.43 4727.16 4727.16 4727.16;
            390 1990 2550 3781 4200 ;   % 2  /I/
            530 1840 2480 0 0;          % 3
            660 1720 2410 0 0 ;         % 4
            520 1190 2390 0 0 ;         % 5
%             730 1090 2440 3781 4200;    % 6  /a/
%             779  1109 3971 3971 3971;
            752 2076 3555 3555 3555;
            1268.32 3880.14 4844.36 4844.36 4844.36;
            570 840 2410 3406 4200;     % 7
            440 1020 2240 3406 4200;    % 8
%             300 870 2240 3406 4200;     % 9  /u/
               
            852.8274612 1782.1497240 2328.9026545 3486.9071314 4436.9236737;
            490 1350 1690 0 0];         % 10

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Band-width details from Rabiner and Juang and Cheveign 1999
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bw = [
%     38 66 171 309.34 368;% 1  /i/
%       159 307 1371 607 0;
%       37 148 77 310 217;
       55.705 66.2 441.78 441.78 441.78;
      42 71 142 309.34 368;             % 2  /I/ 
      0 0 0 0 0 ;                       % 3  
      0 0 0 0 0 ;                       % 4  
      0 0 0 0 0;                        % 5  
%       60 50 102 309.34 368;           % 6  /a/
%       91 190  910  1997 1747;
   977 2156 4103 5040 977;
%     45.1757537 79.2440441 144.9529131 34.6249840 20.6885957;
      47 50 98 256.84 368;              % 7  
      51 61 90 256.84 368 ;             % 8  
%       50 58 107 256.84 368;             % 9  /u/
%        25 1008 195.26 1561 681;
%       32 96 557 1949 0 ;
31.8408   18.6539  440.2337  188.1572   28.4734;


      0 0 0 0 0];                       % 10  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Pitch glide type
%   l - linear 
%   p - to generate V shaped and inv-V shaped pitch glides
%   p1, p2 specify starting and ending pitch for linear pitch glide
%   p1, p3 - specify starting and ending pitch for parabolic pitch glide and
%   p2 specifies intermediate pitch (depth or height) 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bw;
ptype = 'p'; % 'l' 'p'  

p1 = 140; %100 * 2.^([0:1:12]/12);
p2 = 140; %100 * 2.^([-3:1:12-3]/12);
p3 = p1; 

% fmax = maximum frequency range required for calculating distance measure
fmax = 10000; 

% alpha1 = corresponds to choosing the starting vowel 1- /i/, 6 - /a/, 9 -/u/
alpha1 = 6; 

% alpha2 = corresponds to choosing the ending vowel 1- /i/, 6 - /a/, 9 -/u/
alpha2 = 6;

% t_length_rise_fall = correspondings to number of samples for rise and fall time
t_length_rise_fall = (fs)/16; 

save 'var_data_exp2.mat'