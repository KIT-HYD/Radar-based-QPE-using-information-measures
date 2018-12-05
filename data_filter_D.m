% 2018/12/05 Uwe Ehret

% This is the same as data_filter_A, filter 1 (no filter 2)
% Filters the data set and aggregates them
% - temporally knowing (relation between individual data pairs by unity in time is preserved)
% - spatially knowing (for each station, keeps its number as a potential predictor)
% Order of stations in cols: ELL HOF OPA PIN POS USL RCL ROD
% Order of predictors in cols: Decade, Month, GWLo, logCAPE, RH2, TA2, u10, v10, stationnumber);

clear all
close all
clc

% load data 
load data_qpe DateTime* dBZ1500_RAD* RR0* GWLo_DWD_ME logCAPE_DWD_IDA RH2_MET_USL TA2_MET_USL u10_MET_USL v10_MET_USL

clear RR0_DIS_USL  % for USL, we have RR0_RGA_USL with more data

% create variables
num_ts = length(DateTime_UTC); % length of the complete time series

all_RR0 = cat(2,RR0_DIS_ELL, RR0_DIS_HOF, RR0_DIS_OPA, RR0_DIS_PIN, RR0_DIS_POS, RR0_RGA_USL, RR0_RGA_RCL, RR0_RGA_ROD);
all_dBZ = cat(2,dBZ1500_RAD_ELL, dBZ1500_RAD_HOF, dBZ1500_RAD_OPA, dBZ1500_RAD_PIN, dBZ1500_RAD_POS, dBZ1500_RAD_USL, dBZ1500_RAD_RCL, dBZ1500_RAD_ROD);
all_predictors = cat(2, DateTime_UTC_Decade, DateTime_UTC_Month, GWLo_DWD_ME, logCAPE_DWD_IDA, RH2_MET_USL, TA2_MET_USL, u10_MET_USL, v10_MET_USL);
all_DateTime_UTC = DateTime_UTC;

% Filter 1: only times pass where at least two RR0 are >= 0.5 mm/h

    indx_del = [];
    
    % loop over all timesteps
    for t = 1 : num_ts
       dummy = find(all_RR0(t,:)>= 0.5); % in a row, find all stations with >= 0.5 mm/h
       if length(dummy) < 2 % if there are not at least two stations with RR0 >= 0.5 mm/h ...
           indx_del(length(indx_del)+1) = t; % ... mark this row for deletion
       end
    end

    % delete rows from all arrays
    all_RR0(indx_del,:) = [];
    all_dBZ(indx_del,:) = [];
    all_predictors(indx_del,:) = [];
    all_DateTime_UTC(indx_del) = [];

    % so far, each station had a separate col. Now, put them all into one pot = col
    % also, add a new column to the predictors: the station number (1-8)
    all_RR0 = all_RR0(:);
    all_dBZ = all_dBZ(:);
    
    len = length(all_predictors);
    sn = zeros(len,1);
    all_predictors = cat(1,cat(2,all_predictors,sn+1), cat(2,all_predictors,sn+2),cat(2,all_predictors,sn+3),cat(2,all_predictors,sn+4),cat(2,all_predictors,sn+5),cat(2,all_predictors,sn+6),cat(2,all_predictors,sn+7),cat(2,all_predictors,sn+8));
    all_DateTime_UTC = cat(1, all_DateTime_UTC, all_DateTime_UTC,all_DateTime_UTC,all_DateTime_UTC,all_DateTime_UTC,all_DateTime_UTC,all_DateTime_UTC,all_DateTime_UTC);

    % combine RR0 (col 1), dBZ(col 2) and predictors (cols 3-11)
    all_RR0_dBZ_predictors = cat(2,all_RR0, all_dBZ, all_predictors);


