
clear
clc
close all

Fs = 4096;


baud = 2^3;
Nbits = 10; % number of bits

N = Nbits * Fs/baud;
filtorder = 20;
h = rcosdesign(0.25,6,4,'sqrt');
x = round(rand(1, Nbits));
X_rep = repmat(x, 1, Fs/baud);
f0 = 1800;
t = (0:N-1)/Fs; 
xc = X_rep.*cos(2 * pi * f0 * t); % generated the signal

%h = rcosdesign(rolloff, Fs/baud * 4, );

xx_k = fft(xc);
k = (1:N/2+1)/N*Fs;%Fs/2*linspace(0,1,Fs/2+1);
X_k = xx_k(1: length(xx_k)/2+1);
semilogy(k, abs(X_k))
figure
x_k = (abs(X_k));
x_psd1 = 2*abs(x_k(1:length(xx_k)/2+1)).^2; %factor of 2 for one sided spectrum>> 
semilogy(k,x_psd1)

