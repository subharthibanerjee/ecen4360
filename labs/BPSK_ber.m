function [symErr,ber] = BPSK_ber(x, sigma, iter)
%% inputs: encoded signal, variance, iterations
%  outputs: Symbol error, and Symbor error rate
    N = length(x);
    SNR=zeros(1,length(sigma));
    symErr = zeros(1,length(sigma));
    ber = zeros(1,length(sigma));
    for I=1:length(sigma)
     % Source
     `meanBer = 0;
     meanSymErr = 0;
     for i = 1 : iter
        
         
         %% Channel
         SNR(I) = 10* log10(1/sigma(I)); % change into dB
         % there are multiple ways to introduce the variance
         % in the channel-noise. 
         % just to introduce the AWGN function in the program
         % we have used AWGN
         % the scope of $SNR =  \frac{1}{\sigma^2}$
         y = awgn(x,SNR(I));  % channel --- y = x + noise
         
         % x --> |encoder| ----> |AWGN C H A N N E L| ----> y
         %                  ^
         %                  +
         %                  |
         %                  |
         %                 noise
         %% Detector -- optimal?
         xhat = zeros(1,N);
         xhat(y>=0) = 1;
         xhat(y <0) = -1;
         
        
         %% Comparison
         err = sum((xhat ~= x) == 1); % number of  symbol errors
         meanSymErr = meanSymErr + err;
         meanBer = meanBer + err./N; % symbol error rate
         
         
     end
    ber(I) = (meanBer)/iter; 
    symErr(I) = meanSymErr/iter;
   end
end

