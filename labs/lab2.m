clear
clc
close all
%% Lab2 - Digital Communications
% author: Subharthi

% 1. plot BER with semilogy function
% 2. The plots can be based on different sigma values
% 3. sigma = 0.1:0.01:1
% 4. sigma = 1:10
N = 1e4; % Number of symbels
gap = 5; %for plotting
eps = 1e-6;
sigma = 0.1:0.1:10-eps;  % here sigma is sigma^2 or variance = stdev^2

iter = 100;  % change for Monte-Carlo simulation
%% we keep the same symbol sequene for all noise variance
% and iterations. If required keep it inside loop
x = round(rand(1,N)); % 0 or 1 

%% Encoder
y = x;
y(x == 0) = 1;
y(x == 1) = -1;
x = y;

[symErr,ber] = BPSK_ber(x, sigma, iter);
figure
plot(sigma(1:gap:end), symErr(1:gap:end), 'k-d')
grid on
xlabel('Noise variance $\sigma^2$', 'Interpreter', 'Latex')
ylabel('Symbol errors', 'Interpreter', 'Latex')
figure
semilogy(sigma(1:gap:end), ber(1:gap:end), 'k-*')
grid on
xlabel('Noise variance $\sigma^2$', 'Interpreter', 'Latex')
ylabel('BER', 'Interpreter', 'Latex')


