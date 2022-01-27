%%Importar ficheros
clc;
clear;

%Ficheros .dat

data_out_HP=load('sample_out_HP.dat')./127;
data_out_LP=load('sample_out_LP.dat')./127;

%Fichero original

[data,fs]=audioread('haha.wav');

filter_HP=filter([-0.0078 -0.2031 0.6015 -0.2031 -0.078],[1 0 0 0 0],data);
filter_LP=filter([0.039 0.2422 0.4553 0.2422 0.039],[1 0 0 0 0],data);

%%Plots

subplot(3,2,1);
plot(filter_HP);
title('señal filtrada HP matlab');

subplot(3,2,2);
plot(filter_LP);
title('señal filtrada LP matlab');

subplot(3,2,3);
plot(data_out_HP);
title('señal filtrada HP testbench');

subplot(3,2,4);
plot(data_out_LP);
title('señal filtrada LP tesbench');

subplot(3,2,5);
plot(abs(filter_LP-data_out_LP));
title('error LP');

subplot(3,2,6);
plot(abs(filter_HP-data_out_HP));
title('error HP');

%%Sonidos
%sound(data,fs);
%sound(filter_HP,fs);
%sound(data_out_HP,fs);
%sound(filter_LP,fs);
%sound(data_out_LP,fs);