% 2018/12/05 Uwe Ehret
% Code for experiment 3

clear all
close all
clc

% load data
load data_filtered_A all_RR0_dBZ_predictors
load edges edges_RR edges_dBZ edges_stations

%% create variables

% separate the data
RR0 = all_RR0_dBZ_predictors(:,1);
dBZ = all_RR0_dBZ_predictors(:,2);
statnum = all_RR0_dBZ_predictors(:,11);

clear all_RR0_dBZ_predictors

% number of timesteps
num_ts = length(statnum);
    
%% Conditional Entropy of RR0 with dBZ and stationnum as predictor (spatially explicit)
% idea: what is the effect if we derive a relation dBZ-RR separately for each station?
% - if Z-R is spatially unique, it should lower the conditional Entropy
% - on the other hand the Curse of Dimensionality should hit harder
num_rep = 500;  
sample_sizes = [(1:100:1900) (2000:1000:10000) (11984)]';
samplingstrategy = 'random';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ statnum];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;  
edges{3} = edges_stations; 
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);
