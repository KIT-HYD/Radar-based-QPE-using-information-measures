% 2018/12/05 Uwe Ehret
% Code for experiment 5

% MRR data are only available at USL and PIN
% Order of predictors in cols: 
% 1: dBZ1500_RAD
% 2: dBZ1500_MRR
% 3: dBZ100_MRR
% 4: dBZ0_DIS
% 5: RR0_DIS

clear all
close all
clc

% load data
load data_filtered_C
load edges edges_RR edges_dBZ

% Entropy of RR0 with real distribution USL
    RR = all_USL(:,5);
    num_ts = length(RR);
    [pdf_RR,~] = histcounts(RR,edges_RR,'Normalization', 'probability');  
    H_RR_real = f_entropy(pdf_RR);

% Entropy of RR0 with real distribution PIN
    RR = all_PIN(:,5);
    num_ts = length(RR);
    [pdf_RR,~] = histcounts(RR,edges_RR,'Normalization', 'probability');  
    H_RR_real = f_entropy(pdf_RR);
    
% Conditional Entropies
% Adjust:
% - USL/PIN in lines 39, 40
% - dBZ source in line 40

    RR = all_USL(:,5);
    dBZ = all_USL(:,4);
    indx = find(isnan(dBZ));
    dBZ(indx) = [];
    RR(indx) = [];
    num_ts = length(RR);    
        
    num_rep = 1;  
    sample_sizes = [num_ts];
    samplingstrategy = 'continuous';
    num_sasi = length(sample_sizes); 

    data = [RR dBZ];
    edges = cell(1,2);
    edges{1} = edges_RR;
    edges{2} = edges_dBZ;  
    [data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
    [H_x, ~, ~, H_xgy, DKL_xgy, HPQ_xgy] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);
