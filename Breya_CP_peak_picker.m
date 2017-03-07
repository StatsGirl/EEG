%This is a peak picker for Neuroscan avg files. The channels wanted to plot
%will be given, and the files will be circulated through so that each
%selected channel to plot will be added and then averaged with the total files 
%Created by Breya Walker May 21 2015
clear all;close all;clc;

%chan2Plot=[2 7 10 13 25 28 31 48]; %Array that stores all of the desired channels to read in and average.
chan2Plot=[28]; %Array that stores all of the desired channels to read in and average. 2 10 28 48 

[filenames, pathname] = uigetfile('*.txt','Pick the average file(s)', 'multiselect', 'on');
nfiles=length(filenames);
k=1; %k is used to increment the number of .avg files in the CP data folder
i =1; % i is used to increment the number in chanLabels that will be in a legend
N =1; % N is used to increment the number of figures that will print
g=1; %g used to increment subject within ERP component array (i.e., N1min array)
temp=zeros(1,501);%create temp variable of 1x501 matrix
CPPeaks = zeros(g,4);
f=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(chan2Plot)

while k < nfiles+1 %from selected files read in avg add together and plot grand avg for specified channels
disp (filenames{k}) %displays current file
currentFileName=filenames{k};
delimiterIn = '\t'; %delimiter in ascii file are tabs
headerlinesIn = 1; %ignore headliners starting from row 1
[A,delimiterOut,headerlinesOut] = importdata(currentFileName); %outputs data from text file disregarding the delimiters and headliners
FileData = A.data; %FileData equals the data extracted from the current file
Peaks = FileData(chan2Plot,4:end);
disp (Peaks)
for g=1:length(nfiles+1)
    %CPPeaks(i,:,k)= Peaks;
    CPPeaks(f,:,:)=Peaks;
end
k=k+1;
g=g+1;
f=f+1
end

ChannelGrandAvg= mean(CPPeaks); %grand average of ERPs across subjects (channel x sample)
%N1win=[90 110]; %defines search window for N1 (ms)
%t=linspace(xmin,xmax,pnts); %time vector 
%ind1 = findNearestInd(t,N1win(1)/1000); ind2 = findNearestInd(t,N1win(2)/1000); % t is the time vector in sec
%disp (ind1)
%disp (erp(,,:))
%while g < nfiles+1
%searchSegment=erp(i,ind1:ind2,g); %part of the ERP  to look for N1 (assumes erp here is a single row vector))
%disp(length(searchSegment))
%disp(ind1:ind2)
%N1min(g)= min(searchSegment);%min value in search Segment
%N1max(g)= max(searchSegment);% max value in search 
%disp (N1min(g))
%g=g+1;

%end


end
%chanLabels=char(chan2Plot);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
%%

hold all
figure('units','normalized','position',[0.2 0.1 0.4 0.6]); %sets figure size
%subplot(211)
xmin= -0.2000
xmax = 0.8020
pnts= 501;
t =linspace(xmin,xmax,pnts)%t=CPPeaks(:,3:4,:); %time vector
plot(ChannelGrandAvg(1:2));
%L= chanLabels(chan2Plot);%chanLabels(i,chan2Plot);
%h=legend (L); set(h,'fontsize',8,'location','southeast');xlim(1000*[xmin xmax])
title('Grand average Cz channel')
xlabel('Time (ms)'); ylabel('Amplitude (\muV)')

%figure(2)
%plot(CPPeaks(
%subplot(212)
%plot(t*1000,squeeze(erp(:,:,:)))%length(chan2Plot) 
%xlabel('Time (ms)'); ylabel('Amplitude (\muV)')
%title('Individual subjects @ Cz')
%set(h,'fontsize',8);xlim(1000*[xmin xmax])




   