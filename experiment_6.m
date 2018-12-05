% 2018/12/05 Uwe Ehret
% Code for experiment 6

% Evaluates
% - information in spatial raingauge order (quasi Nearest Neighbor rainfall estimation)
% - information in spatial raingauge order & local radar data
% in order to choose one of them, set options in lines 87-98
%
%                             1   2   3   4   5   6   7   8
% Order of stations in cols: ELL HOF OPA PIN POS USL RCL ROD

clear all
close all
clc

% load data
load data_filtered_D all_RR0_dBZ_predictors
load edges edges_RR edges_dBZ edges_stations

%% create variables

% separate the data
RR0 = all_RR0_dBZ_predictors(:,1);
dBZ = all_RR0_dBZ_predictors(:,2);
statnum = all_RR0_dBZ_predictors(:,11);

clear all_RR0_dBZ_predictors

% create matrix with station xy coordinates
xy = NaN(8,2);
xy(:,1) = [56645 58557 56862 53864 50212 65543 62540 54951];
xy(:,2) = [92397 97616 88653 93950 91118 92542 93335 95604];

%% compute entropies from raingauge interpolation
% prepare a container to store, for each station combination:
% distance [m], number of non-NaN data point pairs [-]
% # of target station = point of interest = poi [-], # of predictor station = point with data = pwd [-]
% Entropy [bit] and Conditional Entropy [bit]
all_dists = [];
all_num_data = [];
all_pois = [];
all_pwds = [];
all_Hs = [];
all_Hcs = [];

% loop over all POI
for poi = 1 : 8
    
    % select from all RR0 data the ones with the poi statnum
    indx = find(statnum == poi);
    RR_t = RR0(indx);   
    
    % select from all dBZ the ones with the poi statnum (predictor is dBZ1500 at the location of the poi)
    dBZ_p = dBZ(indx);  
  
    % loop over all PWD
    for pwd = 1 : 8
        
        % exclude cases where poi == pwd (cannot predict yourself)
        if pwd ~= poi
                        
            % save point numbers
            all_pois(length(all_pois)+1) = poi; % save # of poi
            all_pwds(length(all_pwds)+1) = pwd; % save # of pwd
            
            % compute euclidean distance
            coords = [xy(poi,1),xy(poi,2);xy(pwd,1),xy(pwd,2)];
            all_dists(length(all_dists)+1) = pdist(coords,'euclidean');

            % select from all RR0 data the ones with the pwd statnum
            indx = find(statnum == pwd);
            RR_p = RR0(indx);             
            
            % prepare a target-predictor dataset without NaN's
            t_p = cat(2,RR_t,RR_p,dBZ_p);                            
            [r,~] = find(isnan(t_p));
            indx_del = unique(r);
            t_p(indx_del,:) = [];
            
            % save the number of non-NaN data
            all_num_data(length(all_num_data)+1) = length(t_p); 
                
            % compute conditional entropy
            num_rep = 1;  
            sample_sizes = [length(t_p)];
            samplingstrategy = 'continuous';
            num_sasi = length(sample_sizes); 
            
            % station interpolation only
%             data = [t_p(:,1) t_p(:,2)];                     
%             edges = cell(1,2);
%             edges{1} = edges_RR;
%             edges{2} = edges_RR;  
            
            % station interpolation + radar
            data = [t_p(:,1) t_p(:,2) t_p(:,3)];  
            edges = cell(1,3);
            edges{1} = edges_RR;
            edges{2} = edges_RR;
            edges{3} = edges_dBZ;
            
            [data_binned, data_histcounts] = f_histcounts_anyd(data, edges);
            [H_x, ~, ~, H_xgy, ~, ~] = f_infomeasures_from_samples(data, edges, data_binned, data_histcounts, sample_sizes, num_rep, samplingstrategy);
            
            % save current entropy and conditional entropy                
            all_Hs(length(all_Hs)+1) = H_x;
            all_Hcs(length(all_Hcs)+1) = H_xgy;
            
        end
        
    end
    
end

% combine all output variables
all_results = cat(1,all_dists,all_pois,all_pwds,all_num_data,all_Hs,all_Hcs);
all_results = all_results';
all_results = sortrows(all_results,1);

% compute mean, number-of-points-weighted, spatially ignorant Entropy and Conditional Entropy
mean_H = sum(all_results(:,4) .* all_results(:,5)) / sum(all_results(:,4));
mean_Hc = sum(all_results(:,4) .* all_results(:,6)) / sum(all_results(:,4));

% compute mean, number-of-points-weighted, spatially binned Entropy and Conditional Entropy
edges_rangebins = [1978 4000 6000 8000 10000 12000 14000 16000];
num_bins = length(edges_rangebins);

mean_H_bins = NaN(num_bins-1,1);
mean_Hc_bins = NaN(num_bins-1,1);

for i = 1 : num_bins -1 
    indx = find(all_results(:,1)>= edges_rangebins(i) & all_results(:,1)< edges_rangebins(i+1));
    bin_results = all_results(indx,:);
    mean_H_bins(i) = sum(bin_results(:,4) .* bin_results(:,5)) / sum(bin_results(:,4));
    mean_Hc_bins(i) = sum(bin_results(:,4) .* bin_results(:,6)) / sum(bin_results(:,4));    
end







