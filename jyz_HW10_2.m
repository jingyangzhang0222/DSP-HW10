close all
clear

load signal2.txt;
x = signal2;
N = length(x);
X = fft(x, 128);

g1 = x .* kaiser(N,.001);
g4 = x .* kaiser(N,4);
g6 = x .* kaiser(N,6);
g10 = x .* kaiser(N,10);
G1 = fft(g1, 2048);
G4 = fft(g4, 2048);
G6 = fft(g6, 2048);
G10 = fft(g10, 2048);
subplot(4,1,1)
plot(0:1/2048:1/2,20*log10(abs(G1(1:2048/2+1))))
title('|G(f)| in dB (Kaiser Window, \beta = 0.001)')
xlabel('f')
subplot(4,1,2)
plot(0:1/2048:1/2,20*log10(abs(G4(1:2048/2+1))))
title('|G(f)| in dB (Kaiser Window, \beta = 4)')
xlabel('f')
subplot(4,1,3)
plot(0:1/2048:1/2,20*log10(abs(G6(1:2048/2+1))))
title('|G(f)| in dB (Kaiser Window, \beta = 6)')
xlabel('f')
subplot(4,1,4)
plot(0:1/2048:1/2,20*log10(abs(G10(1:2048/2+1))))
title('|G(f)| in dB (Kaiser Window, \beta = 10)')
xlabel('f')