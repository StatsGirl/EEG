%FFT and spectrogram
[FileName,Pathname] = uigetfile('*.wav','Select the wav file wanted');
myWavfile=FileName;
[y, Fs] = wavread(FileName); %output is signal and sampling frequency, respectively

N = length(y); %number of samples in signal and N is equal to the number of values returned by the fft
ts = 1/Fs;
tmax= (N-1)*ts;
fnyquist =Fs/2% Nyquist frequency
t=0:ts:tmax; %time vector
tplot=0:ts;

%time domain and frequency domain
figure(1)
[Amplitude_Spectrum, Phase_Spectrum_deg, freq_vector_Hz] = FourierTransform(y, Fs);   
plot(t*1000,y,'r-');
xlabel('Time(ms)');
ylabel('Amplitude(uV)');
title('Original Waveform Ra')
axis tight
figure(2)
plot(freq_vector_Hz,Amplitude_Spectrum,'b','LineWidth',1)
ylabel('Amplitude (uV)')
xlabel('Frequency (Hz)')
title('Frequency Spectrum Ra')
xlim([100 200])

%spectrogram

y=[y]; %the signal is replicated given the fact that it is so short and it is steady-state stimuli. If signal is short and steady state then replicate *10
figure(3)
BW_Hz = 55; %narrow/wideband frequency
DynamicRange_dB = 70; 
[Sgram,f,t] = spectrogram_8017(y,BW_Hz,Fs,DynamicRange_dB)%y=signal, Bw_Hz= bandwidth, Fs= sampling rate, DynamicRange_dB = improves visualization of gram
% t_window_wideband = fix(0.05*Fs); %window > 20-30 ms
% t_overlap_wideband = fix(.001*Fs); %samples to overlap; should be smaller than the length of window(vector) or smaller than window (if scalar)
% %window_wideband = t_window_wideband*Fs; %widnow samples
% %noverlap_wideband = t_overlap_wideband*Fs;
% %window = window_wideband;
% %noverlap =noverlap_wideband;
% nfft = Fs/2;%nfft should be equal to the sample rate which is N
% fs=Fs;%fs is equal to the sampling frequency
% window = t_window_wideband; %window has to be greater than 20-30ms.
% noverlap = t_overlap_wideband;%overlap should be less than window above
% [S,F,T] = spectrogram(y,window,noverlap,nfft,Fs,'yaxis')
ylim([0 2000])
xlim([0 1])
colorbar
xlabel('Time(s)');
title('La')

%figure;
%imagesc(t,f,abs(Sgram))
%ylim([0 2000])

