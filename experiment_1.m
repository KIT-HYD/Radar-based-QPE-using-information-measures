% 2018/12/05 Uwe Ehret
% Code for experiment 1

clear all
close all
clc

% load data
load data_filtered_A
load edges

%% create variables

    % separate the data
    RR0 = all_RR0_dBZ_predictors(:,1);
    dBZ = all_RR0_dBZ_predictors(:,2);
    Decade = all_RR0_dBZ_predictors(:,3);
    MoY = all_RR0_dBZ_predictors(:,4);
    GWLo = all_RR0_dBZ_predictors(:,5);
    logCAPE = all_RR0_dBZ_predictors(:,6);
    RH2 = all_RR0_dBZ_predictors(:,7);
    TA2 = all_RR0_dBZ_predictors(:,8);
    u10 = all_RR0_dBZ_predictors(:,9);
    v10 = all_RR0_dBZ_predictors(:,10);
    statnum = all_RR0_dBZ_predictors(:,11);

    % number of timesteps
    num_ts = length(all_DateTime_UTC);


%% Entropy of RR0 with uniform distribution
H_RR0_uniform = log2(length(edges_RR)-1);

%% Entropy of RR0 with real distribution
[pdf_RR0,~] = histcounts(RR0,edges_RR,'Normalization', 'probability');  
H_RR0_real = f_entropy(pdf_RR0);

figure;
bar(edges_RR(1:end-1),pdf_RR0,0.9,'histc'); 

%% Conditional Entropy of RR0 with dBZ as predictor
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ];
edges = cell(1,2);
edges{1} = edges_RR;
edges{2} = edges_dBZ;  
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

% compute the 2-d histogram of YX
% NOTE the following conventions:
% - X is always the target and will be displayed along the vertical axis
% - Y is always the predictor and will be displayed along the horizontal axis
% - the origin of the YX graph is in the lower left corner
figure;
histogram2(dBZ,RR0,edges_dBZ,edges_RR,'FaceColor','flat','Normalization','probability');
xlabel('Y');
ylabel('X');
colorbar;

%% Conditional Entropy of RR0 with RRrad from dBZ-->Marshall-Palmer-->RRrad

% convert the Radar-dBZ to RR
RR0rad = f_dBZ2R_easy_a_b(dBZ,200,1.6);

num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 RR0rad];
edges = cell(1,2);
edges{1} = edges_RR;
edges{2} = edges_RR;  
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and Decade as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ Decade];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_Decade;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and MoY as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ MoY];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_MoY;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and GWL0 as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ GWLo];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_GWLo;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and logCAPE as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ logCAPE];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_logCAPE;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and RH2 as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ RH2];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_RH2;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and TA2 as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ TA2];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_TA2;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and u10 as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ u10];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_u10;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ and v10 as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ v10];
edges = cell(1,3);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_v10;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ, Decade and GWL0 as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ Decade GWLo];
edges = cell(1,4);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_Decade;
edges{4} = edges_GWLo;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

%% Conditional Entropy of RR0 with dBZ, MoY and GWL0 as predictors
num_rep = 1;  
sample_sizes = [num_ts];
samplingstrategy = 'continuous';
num_sasi = length(sample_sizes); 

data = [RR0 dBZ MoY GWLo];
edges = cell(1,4);
edges{1} = edges_RR;
edges{2} = edges_dBZ;
edges{3} = edges_MoY;
edges{4} = edges_GWLo;
[data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
[H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);

