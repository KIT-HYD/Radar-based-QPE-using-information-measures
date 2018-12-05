%% 2018/12/05 Uwe Ehret
% Code for experiment 4

% Investigates the effect of using deterministic Z-R relations
% instead of the data-derived relation
% - Marshall-Palmer 1=200, b=1.6
% - same functional form as M-P, but a, b derived from data
% Uses all available RR0 and dBZ pairs --> data_filtered_A columns 1 and 2

clear all
close all
clc

% load data
load data_filtered_A all_RR0_dBZ_predictors
load edges edges_RR edges_dBZ

% prepare variables
num_ts = length(all_RR0_dBZ_predictors);
RR = all_RR0_dBZ_predictors(:,1);
dBZ = all_RR0_dBZ_predictors(:,2);
clear all_RR0_dBZ_predictors

%% Benchmarks
% Note:
% - From analysis A we know H(RR) = 1.90
% - From analysis A we know H(RR|dBZ) = 1.61

% calculate the 2-d histogram of (RR|dBZ)
% - data_histcounts_obs contains the 'true' (observed) relation of dBZ-->RR
data = [RR dBZ];
edges = cell(1,2);
edges{1} = edges_RR;
edges{2} = edges_dBZ;  
[data_binned_obs, data_histcounts_obs] = f_histcounts_anyd(data, edges);

%% Marshall-Palmer

% calculate RR if dBZ is known and we assume a deterministic Marshall-Palmer relation between dBZ and RR
% - this means for a particular value of dBZ, there will be only one particular value of RRrad
RR_mp = f_dBZ2R_easy_a_b(dBZ);

% calculate the 2-d histogram of (RRrad|dBZ)
% - data_histcounts_mp contains the 'model' (deterministic) relation of dBZ-->RR
data = [RR_mp dBZ];
edges = cell(1,2);
edges{1} = edges_RR;
edges{2} = edges_dBZ;  
[data_binned_mp, data_histcounts_mp] = f_histcounts_anyd(data, edges);

% Calculate the information loss by assuming the model relation to hold,
% instead of the observed one. This can be seen as the 'ill-informed
% bookmaker' problem, and we can quantify the additional uncertainty due to
% having the wrong relation in mind by Dkl between the true and the model
% pdf. We do so for each case (bin) of the predictor (dBZ), and compute an
% average DKL over all columns by weighting each column-DKL with its
% empirical occurrence probabiliy p(dBZ=dBZ(i))
% Note: suppose the two conditional pdf's
%   obs: 0.3 0.6 0.1 0.0
%   mod: 0.0 1.0 0.0 0.0   (deterministic)
% then Dkl is infinite for case 0.1 obs - 0.0 mod)
% in this case we replace the model by a nonzero estimate, which can yield
% large Dkl

% flip histograms to have correct format for use in f_conditionalkld_anyd
data_histcounts_obs = data_histcounts_obs';
data_histcounts_mp = data_histcounts_mp';
        
% compute expected DKL (probability-weighted mean of DKL of all conditional histogram pairs
DKL_mean_mp = f_conditionalkld_anyd_OLD(data_histcounts_obs, data_histcounts_mp);

%% optimized Z-R relation

% calculate RR if dBZ is known and we assume an optimized dBZ-R relation
% see 'analysis_E_optimize_a_b'
% - this means for a particular value of dBZ, there will be only one particular value of RRrad
RR_opt = f_dBZ2R_easy_a_b(dBZ,235,1.6);

% calculate the 2-d histogram of (RRrad|dBZ)
% - data_histcounts_opt contains the 'model' (deterministic) relation of dBZ-->RR
data = [RR_opt dBZ];
edges = cell(1,2);
edges{1} = edges_RR;
edges{2} = edges_dBZ;  
[data_binned_opt, data_histcounts_opt] = f_histcounts_anyd(data, edges);

% flip histograms to have correct format for use in f_conditionalkld_anyd
% data_histcounts_obs = data_histcounts_obs'; --> already done for M-P
data_histcounts_opt = data_histcounts_opt';
        
% compute expected DKL (probability-weighted mean of DKL of all conditional histogram pairs
DKL_mean_opt = f_conditionalkld_anyd_OLD(data_histcounts_obs, data_histcounts_opt);




