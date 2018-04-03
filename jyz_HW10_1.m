close all
clear

%Load signals and basic processing ¡ý
load NoisySpeech.txt
load mtlb
Noi = NoisySpeech;
Noif = fft(Noi, 4096);
mtlbf = fft(mtlb, 4096);
Ap = 0.05;                  % passband attenuation
As = 60;                    % stopband attenuation
delp = 1 - 10^(-Ap/20);     % passband deviation
dels = 10^(-As/20);         % stopband deviation
L = 4096;
k = 0 : L-1;
w = k*2*pi/L;
W = exp(1j*2*pi/L);
wp = (2500/(Fs/2))*pi; fp = wp/pi;%pass_band
ws = (2900/(Fs/2))*pi; fs = ws/pi;%stop_band
wc = (wp + ws) / 2; fc = wc/pi;   %cut-off frequency
%determine the length of the filter ¡ý
N = kaiserord([fp fs],[1 0],[delp dels]) + 1; 
M = (N - 1) / 2;
n = 0 : N -1;

dCausal = wc / pi * sinc(wc / pi * (n - M));
hHamming = dCausal .* hamming(N)'; 
hHann = dCausal .* hann(N)';
hBlackman = dCausal .* blackman(N)';
beta = 0.1102 * (As - 8.7);
hKaiser = dCausal .* kaiser(N, beta)';

HHamming = fft(hHamming, L);AHamming = HHamming .*W.^(M*k);
HHann = fft(hHann, L);AHann = HHann .*W.^(M*k);
HBlackman = fft(hBlackman, L);ABlackman = HBlackman .*W.^(M*k);
HKaiser = fft(hKaiser, L);AKaiser = HKaiser .*W.^(M*k);

%filtering¡ý
YHamming = abs(Noif' .* AHamming);
YHann = abs(Noif' .* AHann);
YBlackman = abs(Noif' .* ABlackman);
YKaiser = abs(Noif' .* AKaiser);

subplot(3,2,1)
plot(k(1:2048)/2048, abs(mtlbf(1:2048)))
xlabel('\omega/\pi');title('Spectrum of Clean Signal')
subplot(3,2,2)
plot(k(1:2048)/2048, abs(Noif(1:2048)))
xlabel('\omega/\pi');title('Spectrum of Noisy Signal')
subplot(3,2,3)
plot(k(1:2048)/2048, YHamming(1:2048))
xlabel('\omega/\pi');title('Filtered by Hamming Window Filter')
subplot(3,2,4)
plot(k(1:2048)/2048, YHann(1:2048))
xlabel('\omega/\pi');title('Filtered by Hann Window Filter')
subplot(3,2,5)
plot(k(1:2048)/2048, YBlackman(1:2048))
xlabel('\omega/\pi');title('Filtered by Blackman Window Filter')
subplot(3,2,6)
plot(k(1:2048)/2048, YKaiser(1:2048))
xlabel('\omega/\pi');title('Filtered by Kaiser Window Filter')

a = zeros(1,N);
a(1) = 1;

yHamming = filter(hHamming, a, Noi);
yHann = filter(hHann, a, Noi);
yBlackman = filter(hBlackman, a, Noi);
yKaiser = filter(hKaiser, a, Noi);

disp('Press Enter to Play Next Audio(Hamming)')
pause
soundsc(yHamming, Fs);
disp('Press Enter to Play Next Audio(Hann)')
pause
soundsc(yHann, Fs);
disp('Press Enter to Play Next Audio(Blackman)')
pause
soundsc(yBlackman, Fs);
disp('Press Enter to Play Next Audio(Kaiser)')
pause
soundsc(yKaiser, Fs);
disp('Program Finished!')