
%% author: Subharthi 
% for lab1 in Dr Harms's class
% instructions for submissions:
% 1. see and understand the code
% 2. clearly labeled plots (required)
% 3. image generated should be of 300dpi (check how I generated the image)
% 4. see how I used frequency, number of bits and N as 2^(power)
% 5. you can simply use periodogram over x and then y = interp(x, 2), but
% it will only give you flat response. So you can simulate BPSK signal with
% following.
% 6. see all the methods and understand
% use different f0 values which should be less than fs/2 (remember Nyquist)
% if you don't follow Nyquist and have some value f0 >= fs/2, try to plot
% sine wave with that. check if it is a sine wave or not.
% 7. use diffferent Nbits preferably 8, 16, 32, etc. Understand the concept
% of bandwidth from the PSD plot. 

%%  the code ===============================


clear
close all
clc
fs = 4096;
N= 8;
f0 = 128;
Nbits = 8;
t = 1/fs;
T = (0:t:N-t);
T = T';
%% ======== Method 1  for clear PSD ============
x = 2*round(rand(1, Nbits))-1;

x = x';
x_rep = repmat(x, 1, length(T)/Nbits)';
X_rep = x_rep(:);
%X_rep = interp(X_rep, 2);
%T = linspace(0, t, length(X_rep))';
X = X_rep.*sin(2*pi*f0*T);

%% if someone wants to use raised cosine
%h = rcosdesign(0.5,6,4, "sqrt");
%X = upfirdn(X, h, 4);
%X = conv(X, h, "full");

%% then FFT and PSD
xx_k = fft(X, fs);
k = (1:length(xx_k)/2+1)/length(xx_k)*fs;%Fs/2*linspace(0,1,Fs/2+1);
X_k = xx_k(1:length(xx_k)/2+1);
fig = figure
semilogy(k, abs(X_k))
xlim([0, max(k)]);
grid on
xlabel('Frequency (Hz)', 'Interpreter', 'Latex')
title(['FFT Peak at ', num2str(f0), ' Hz' ], 'Interpreter', 'Latex')
print -r300 -dpng 'fft.png'
figure
periodogram(X)

%% ======== Method 2  to generate random BPSK signal and processing ===========


x = 2*round(rand(1, length(T)))-1;
%X_rep = interp(X_rep, 2);
%T = linspace(0, t, length(X_rep))';
X = X_rep.*sin(2*pi*f0*T);

%% if someone wants to use raised cosine
%h = rcosdesign(0.5,6,4, "sqrt");
%X = upfirdn(X, h, 4);
%X = conv(X, h, "full");

%% then FFT and PSD
xx_k = fft(X, fs);
k = (1:length(xx_k)/2+1)/length(xx_k)*fs;%Fs/2*linspace(0,1,Fs/2+1);
X_k = xx_k(1:length(xx_k)/2+1);
fig = figure
semilogy(k, abs(X_k))
xlim([0, max(k)]);
grid on
xlabel('Frequency (Hz)', 'Interpreter', 'Latex')
title(['FFT Peak at ', num2str(f0), ' Hz' ], 'Interpreter', 'Latex')
print -r300 -dpng 'fft2.png'
figure
periodogram(X)
%% ======== Method 3  to for BPSK symbol sequence ===========


x = 2*round(rand(1, length(T)))-1;
X = x;
%X_rep = interp(X_rep, 2);
%T = linspace(0, t, length(X_rep))';


%% if someone wants to use raised cosine
%h = rcosdesign(0.5,6,4, "sqrt");
%X = upfirdn(X, h, 4);
%X = conv(X, h, "full");

%% then FFT and PSD
xx_k = fft(X, fs);
k = (1:length(xx_k)/2+1)/length(xx_k)*fs;%Fs/2*linspace(0,1,Fs/2+1);
X_k = xx_k(1:length(xx_k)/2+1);
fig = figure
semilogy(k, abs(X_k))
xlim([0, max(k)]);
grid on
xlabel('Frequency (Hz)', 'Interpreter', 'Latex')
title(['FFT Peak at ', num2str(f0), ' Hz??' ], 'Interpreter', 'Latex')
print -r300 -dpng 'fft3.png'
figure
periodogram(X)

