% This program will create grand averages of all CNV responses from
% individual excel spreadsheet.

% Author: Breya Walker
% Last update: October 31 2016 by Breya Walker

clear
clc

% Enter values to define the analysis.
% Note: Create GUI window to enter this info.

% DATA MUST BE READ FROM FILE INTO A MATLAB ARRAY
%filename = ('C:\JJSABLE\MATLAB\NF002.xlsx');
statfile = ('C:\Users\breya\Desktop\MP materials\MP_Data_2015\CNV_1.xlsx');
open_file_path = 'C:\Users\breya\Desktop\CNV\erpsforcnv\ERP Outputs\';
n_subjects = 12;  %Give the number of participants in the study.
open_files = {'S19' 'S18' 'S17' 'S15' 'S14' 'S12' 'S11' 'S10' 'S9' 'S8' 'S7' 'S6'};
i=1;
%openfiles= logical(open_files);
sheet = ('CNV1'); % Give name of output sheets
%xls_start = ('A11');
nchans = 1;

%filepath = sprintf('%s', '', filename, '.xlsx');

%data=xlsread(filename,'ERP_freq_up');
%data=data';

chans = 1;       % Enter the channels to be analyzed 
n_chans = 1;       % Enter the number of channels to be analyzed
sample_rate = 200 ; % Enter the sampling rate of the data (Hz). This is necessary to convert the latency values from time to points.
baseline = 500;    % Enter the prestimulus baseline in ms
n_conds = 1;
n_resp = 1;        % Enter the number of responses (1 unless stim are trains)
%soa = 400;        % enter the SOA in ms
latency=linspace(-500,7500,1601); %creates latency window during epoch (-500 to 7500ms);

%Create matrix for data
output = ones(n_chans,(n_resp*2));
vector = ones(1,(n_chans*(n_resp*2)*n_conds));
for x = 1:n_subjects
    filename = sprintf('%s%s.xlsx',open_file_path,open_files{i});
    data = xlsread(filename);
%     for m = 0:(n_conds-1)
% 
%         if m==0 a='ERP freq';
%         elseif m==1 a='ERP rare';
%         end
% 
        a='CNV1';
        data=xlsread(filename,a);
        data1(i,:)=data;
        i=i+1;
end;
%datasum= sum(data1)
datamean1=mean(data1);

i=1;
for x = 1:n_subjects
    filename = sprintf('%s%s.xlsx',open_file_path,open_files{i});
    data = xlsread(filename);
%     for m = 0:(n_conds-1)
% 
%         if m==0 a='ERP freq';
%         elseif m==1 a='ERP rare';
%         end
% 
         a='CNV2';
        data=xlsread(filename,a);
        data2(i,:)=data;
        i=i+1;
end;
datamean2=mean(data2);

i=1;
for x = 1:n_subjects
    filename = sprintf('%s%s.xlsx',open_file_path,open_files{i});
    data = xlsread(filename);
%     for m = 0:(n_conds-1)
% 
%         if m==0 a='ERP freq';
%         elseif m==1 a='ERP rare';
%         end
% 
        a='CNV3';
        data=xlsread(filename,a);
        data3(i,:)=data;
        i=i+1;
end;
datamean3=mean(data3);
 
hold all;
subplot(3,1,1);
fig1=plot(latency,datamean1);
xlabel('latency ms');
ylabel('CNV amplitude');
title('CNV tone 1')
subplot(3,1,2);
fig2=plot(latency,datamean2);
xlabel('latency ms');
ylabel('CNV amplitude');
title('CNV tone 2')
subplot(3,1,3);
fig3=plot(latency,datamean3);
xlabel('latency ms');
ylabel('CNV amplitude');
title('CNV tone 3')
%{
DataAvg=[i,j];
        j=j+1;
     for i = chans(1);   
    %for i = chans(1):chans(n_chans);
        chan = data(i,:);
        

    % Define response latency and polarity
    start_lat = 140;    % ENTER START POINT LATENCY IN MS (of measurement window)
    end_lat = 200;     % ENTER END POINT LATENCY IN MS (of measurement window)
    pol = 1;           % ENTER POLARITY OF PEAK TO BE FOUND (0 = neg, 1 = pos)

    % Convert times from ms to data points
    period = 1000/sample_rate;
    base_pts = (baseline/period);
    start_pt = start_lat/period;
    start_pt = base_pts + start_pt;
    end_pt = end_lat/period;
    end_pt = base_pts + end_pt;
 
    start_pt= round(start_pt);
    end_pt=round(end_pt);

    amplitude = chan(start_pt);
    lat_pt = (start_pt);

        for j = chan(start_pt:end_pt);
            if pol == 0
                if j <= amplitude
                    amplitude = j;
                    t=lat_pt;
                    latency= data(1,t);
                    
                end
            elseif pol == 1
                if j >= amplitude
                    amplitude = j;
                    t=lat_pt;
                    latency= data(1,t);
                end
            end

        lat_pt = (lat_pt + 1);    

        end

    output(i-1,1)=amplitude;
    output(i-1,2)=latency;

   

    end

    %s=1; %(m*30);

    vector(1,1:2)=output(7,:);
    %vector(1,3:4)=output(2,:);
    %vector(1,5:6)=output(3,:);
    %vector(1,7:8)=output(4,:);

%    end
    xls_start = sprintf('A%d',x);
    xlswrite(statfile,vector,sheet,xls_start);
%}
%}