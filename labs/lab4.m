% code for Lab 3
% author: Subharthi Banerjee


%% LAB 3 -- code example --- first example

clear
close all
clc
k = 4;
% snr collection
eps = 1e-6;
sigma = 0.1:.1:10-eps;

%  the generator matrix for Hamming code [8, 4, 4]
N = 1e6; % sampling rate
p = nextpow2(N);
N = 2^p;

H8 = hadamard(8); % walsh

%% outer loop should be in Monte Carlo simulation
% create random sized input
x = round(rand(1, k));
x = repmat(x, N, 1);
x = x';
x = x(:);
%% MONTE-CARLO SIMULATION
meanerr = zeros(1, length(sigma));
for si =  1 : length(sigma) 
    %% encode
    
    
    
    for i = 1 : 4 : N*k
        xc = x(i:i+3);
        m = 2.*xc - 1; % BPSK conversion

        c = fwht(m);
        % random channel generation
        %h = H8(randi(size(H8, 1)), :);
        %c = m' * h;

        % going through awgn channel
        snr(si) = 10 * log10(1/sigma(si));
        y = awgn(c, snr(si));  % channel --- y = x + noise
        %% ber now
        y = ifwht(y);
       % y = (y * h')';
        x_hat = y >0;
        err(i) = sum((x_hat ~= xc) == 1); 
        err(i) = err(i)./(k);
    end
    meanerr(si) = sum(err)/N;
end

figure
semilogy(sigma, meanerr, 'k*');
xlabel('Sigma')
ylabel('BER')
title('Fast Hadamard-Walsh Transform - with built in function')


