% 2018/12/05 Uwe Ehret

% Filters the data set and aggregates them
% - spatially knowing (USL and PIN are treated separately)
% - temporally knowing (relation between individual data pairs by unity in time is preserved)
% filters:
% - separately for USL and PIN: Only times where RR0_DIS >= 0.5 mm/h. This also filters RR0_DIS = NaN)
% Order of predictors in cols: dBZ1500_RAD, dBZ1500_MRR dBZ100_MRR dBZ0_DIS RR0_DIS

clear all
close all
clc

% load data
load data_qpe DateTime_UTC dBZ1500_RAD_USL dBZ1500_MRR_USL dBZ100_MRR_USL dBZ0_DIS_USL RR0_DIS_USL dBZ1500_RAD_PIN dBZ1500_MRR_PIN dBZ100_MRR_PIN dBZ0_DIS_PIN RR0_DIS_PIN

% create variables
num_ts = length(DateTime_UTC); % length of the complete time series

% 1: dBZ1500_RAD 2: dBZ1500_MRR 3: dBZ100_MRR 4: dBZ0_DIS 5: RR0_DIS
all_USL = cat(2,dBZ1500_RAD_USL, dBZ1500_MRR_USL, dBZ100_MRR_USL, dBZ0_DIS_USL, RR0_DIS_USL);
all_DateTime_UTC_USL = DateTime_UTC;
all_PIN = cat(2,dBZ1500_RAD_PIN, dBZ1500_MRR_PIN, dBZ100_MRR_PIN, dBZ0_DIS_PIN, RR0_DIS_PIN);
all_DateTime_UTC_PIN = DateTime_UTC;

% Filter 1: Only times where RR0_DIS >= 0.5 mm/h (this also filters RR0_DIS = NaN)

    % USL
        indx_del = [];
        % loop over all timesteps
        for t = 1 : num_ts
           dummy = find(all_USL(t,5)>= 0.5); % in a row, check if RR0_DIS >= 0.5 mm/h
           if isempty(dummy) % if RR0 is not >= 0.5 mm/h ...
               indx_del(length(indx_del)+1) = t; % ... mark this row for deletion
           end
        end
        % delete rows from arrays
        all_USL(indx_del,:) = [];   
        all_DateTime_UTC_USL(indx_del,:) = [];  

    % PIN
        indx_del = [];
        % loop over all timesteps
        for t = 1 : num_ts
           dummy = find(all_PIN(t,5)>= 0.5); % in a row, check if RR0_DIS >= 0.5 mm/h
           if isempty(dummy) % if RR0 is not >= 0.5 mm/h ...
               indx_del(length(indx_del)+1) = t; % ... mark this row for deletion
           end
        end
        % delete rows from arrays
        all_PIN(indx_del,:) = [];   
        all_DateTime_UTC_PIN(indx_del,:) = [];  


    
    
    
    
    
    
    