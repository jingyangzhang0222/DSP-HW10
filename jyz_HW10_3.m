close all
clear

load signal1.txt;
x = signal1;
subplot(2,2,1)
spectrogram(x)
title('Default Settings')
subplot(2,2,2)
spectrogram(x,kaiser(70))
title('Use Kaiser Window with N = 70')
subplot(2,2,3)
spectrogram(x,kaiser(70,3),69)
title('Use Kaiser Window with N = 70, \beta = 3, L = 69')
subplot(2,2,4)
spectrogram(x,kaiser(70,3),69)
title('3D View')
view(-13,47)
colormap jet