% 2018/12/05 Uwe Ehret
% Code for experiment 2

% Investigates the effect of sample size when using the predictors
% - single: dBZ
% - double: dBZ & Decade            dBZ % MoY
% - triple: dBZ & Decade % GWLo     dBZ % MoY & GWLo

% Uses all available RR0 dBZ predictor groups --> data_filtered_A

clear all
close all
clc

% load data
load data_filtered_A all_RR0_dBZ_predictors
load edges edges_RR edges_dBZ edges_Decade edges_MoY edges_GWLo

% prepare variables
num_ts = length(all_RR0_dBZ_predictors);
RR = all_RR0_dBZ_predictors(:,1);
dBZ = all_RR0_dBZ_predictors(:,2);
Decade = all_RR0_dBZ_predictors(:,3);
MoY = all_RR0_dBZ_predictors(:,4);
GWLo = all_RR0_dBZ_predictors(:,5);

clear all_RR0_dBZ_predictors

%% A: Conditional Entropy of RR0 with dBZ as predictor
% num_rep = 500;  
% sample_sizes = [(1:100:1900) (2000:1000:10000) (11984)]';
% samplingstrategy = 'random';
% num_sasi = length(sample_sizes); 
% 
% data = [RR dBZ];
% edges = cell(1,2);
% edges{1} = edges_RR;
% edges{2} = edges_dBZ;
% [data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
% [H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% B: Conditional Entropy of RR0 with dBZ and Decade as predictor
% num_rep = 500;  
% sample_sizes = [(1:100:1900) (2000:1000:10000) (11984)]';
% samplingstrategy = 'random';
% num_sasi = length(sample_sizes); 
% 
% data = [RR dBZ Decade];
% edges = cell(1,3);
% edges{1} = edges_RR;
% edges{2} = edges_dBZ;
% edges{3} = edges_Decade;
% [data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
% [H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% C: Conditional Entropy of RR0 with dBZ and MoY as predictor
% num_rep = 500;  
% sample_sizes = [(1:100:1900) (2000:1000:10000) (11984)]';
% samplingstrategy = 'random';
% num_sasi = length(sample_sizes); 
% 
% data = [RR dBZ MoY];
% edges = cell(1,3);
% edges{1} = edges_RR;
% edges{2} = edges_dBZ;
% edges{3} = edges_MoY;
% [data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
% [H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% E: Conditional Entropy of RR0 with dBZ and MoY and GWLo as predictor
% num_rep = 500;  
% sample_sizes = [(1:100:1900)]';
% num_rep = 100;  
% sample_sizes = [(2000:1000:10000) (11984)]';

samplingstrategy = 'random';
num_sasi = length(sample_sizes); 

data = [RR dBZ MoY GWLo];
edges = cell(1,4);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_MoY;
edges{4} = edges_GWLo;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

