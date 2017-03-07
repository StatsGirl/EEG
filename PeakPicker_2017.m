%This is a peak picker for Neuroscan avg files. The channels wanted to plot
%will be given, and the files will be circulated through so that each
%selected channel to plot will be added and then averaged with the total files 
%Created by Breya Walker May 21 2015 

clear all;close all;clc;

%chan2Plot=[2 7 10 13 25 28 31 48]; %Array that stores all of the desired channels to read in and average.
chan2Plot=[9 10 11 18 19 20]; %Array that stores all of the desired channels to read in and average.(Frontal channels by numbers 9, 10, 11, 18, 19, 20

[filenames, pathname] = uigetfile('*.avg','Pick the average file(s)', 'multiselect', 'on');
nfiles=length(filenames);
N1min = zeros(1,nfiles);%zeros(length(chan2Plot),1,nfiles)
N1max = zeros(1,nfiles);
P1min = zeros(1,nfiles);%will be used to store P1 min value in an array
P1max = zeros (1,nfiles);
k=1; %k is used to increment the number of .avg files in the CP data folder
i =1; % i is used to increment the number in chanLabels that will be in a legend
N =1; % N is used to increment the number of figures that will print
g=1; %g used to increment subject within ERP component array (i.e., N1min array)
temp=zeros(1,501);%create temp variable of 1x501 matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(chan2Plot)

while k < nfiles+1 %from selected files read in avg add together and plot grand avg for specified channels
disp (filenames{k})
%disp (pathname{k})
currentFileName=filenames{k};
[signal,variance, chan_names, pnts, rate, xmin, xmax,nsweeps]=loadavg_old(currentFileName); %loads in one file at a time
chanLabels=char(chan_names); %label channels (convert from # to label)
erp(i,:,k) = signal(chan2Plot(i),:); %save all ERPs for each subject in 3D matrix(channel x sample x subject)
k=k+1;        
end

ChannelGrandAvg= mean(mean(erp,1),3); %grand average of ERPs clustered for N channels all subjects
output_signal =0;
input_signal = ChannelGrandAvg;
%T = 1/500;
%frequency must be specified in the range between 0 and 1, where 1 corresponds to half the sampling frequency=500 (the Nyquist frequency =1000). The frequencies must be in increasing order.
freq2rad_Fc1=0.002; % 1/500
freq2rad_Fc2= 0.06; %30/500
%[output_signal,b]= BPfilter1(input_signal,0.06,0.002,10,1000);
%disp output_signal;
Y=fdesign.bandpass('N,Fc1,Fc2',4,freq2rad_Fc1,freq2rad_Fc2); %filter order, F cutoff 1, F cutoff 2, %Bandpass filter Channel GrandAvg
Hd=design(Y,'butter');
output=filter(Hd,ChannelGrandAvg);
N1win=[90 110]; %defines search window for N1 (ms)
t=linspace(xmin,xmax,pnts); %time vector
ind1 = findNearestInd(t,N1win(1)/1000); ind2 = findNearestInd(t,N1win(2)/1000); % t is the time vector in sec
%disp (ind1)
%disp (erp(,,:))
while g < nfiles+1
searchSegment=erp(i,ind1:ind2,g); %part of the ERP  to look for N1 (assumes erp here is a single row vector))
disp(length(searchSegment))
disp(ind1:ind2)
N1min(g)= min(searchSegment);%min value in search Segment
N1max(g)= max(searchSegment);% max value in search 
%disp (N1min(g))
g=g+1;
end


end
%plot(t,N1min(g))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
%%


figure('units','normalized','position',[0.2 0.1 0.4 0.6]); %sets figure size
subplot(211)
t=linspace(xmin,xmax,pnts); %time vector
hold all
plot(t*1000,ChannelGrandAvg);
plot(t*1000,output);
L= chanLabels(chan2Plot,:);%chanLabels(i,chan2Plot);
h=legend (L); set(h,'fontsize',8,'location','southeast');xlim(1000*[xmin xmax])
title('Grand average per channel')
xlabel('Time (ms)'); ylabel('Amplitude (\muV)')

subplot(212)
plot(t*1000,squeeze(erp(:,:,:)))%length(chan2Plot) 
xlabel('Time (ms)'); ylabel('Amplitude (\muV)')
title('Individual subjects @ Cz')
set(h,'fontsize',8);xlim(1000*[xmin xmax])




   