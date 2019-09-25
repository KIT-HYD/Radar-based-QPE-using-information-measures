function A = allcomb_singleinput(bla)

% Uwe Ehret, 30.7.2017
% This function does the same thing as allcomb, but
% input is not provided as collection of individual arrays (A, B, C)
% but as a single [1,n] cell array, where n is the number of formerly individual arrays
% so bla(1,1) = A, bla(1,2) = B etc.
% changes from the original code are indicated by 'UE'

% UE: 
varargin = bla; % assign the input to the former collective input variable 'varagin'

narginchk(1,Inf) ;

% UE
%NC = nargin ; 
NC = size(varargin,2); % get the number of individual arrays in the input

% check if we should flip the order
if ischar(varargin{end}) && (strcmpi(varargin{end},'matlab') || strcmpi(varargin{end},'john')),
    % based on a suggestion by JD on the FEX
    NC = NC-1 ;
    ii = 1:NC ; % now first argument will change fastest
else
    % default: enter arguments backwards, so last one (AN) is changing fastest
    ii = NC:-1:1 ;
end

args = varargin(1:NC) ;
% check for empty inputs
if any(cellfun('isempty',args)),
    warning('ALLCOMB:EmptyInput','One of more empty inputs result in an empty output.') ;
    A = zeros(0,NC) ;
elseif NC > 1
    isCellInput = cellfun(@iscell,args) ;
    if any(isCellInput)
        if ~all(isCellInput)
            error('ALLCOMB:InvalidCellInput', ...
                'For cell input, all arguments should be cell arrays.') ;
        end
        % for cell input, we use to indices to get all combinations
        ix = cellfun(@(c) 1:numel(c), args,'un',0) ;
        
        % flip using ii if last column is changing fastest
        [ix{ii}] = ndgrid(ix{ii}) ;
        
        A = cell(numel(ix{1}),NC) ; % pre-allocate the output
        for k=1:NC,
            % combine
            A(:,k) = reshape(args{k}(ix{k}),[],1) ;
        end
    else
        % non-cell input, assuming all numerical values or strings
        % flip using ii if last column is changing fastest
        [A{ii}] = ndgrid(args{ii}) ;
        % concatenate
        A = reshape(cat(NC+1,A{:}),[],NC) ;
    end
elseif NC==1,
    A = args{1}(:) ; % nothing to combine

else % NC==0, there was only the 'matlab' flag argument
    A = zeros(0,0) ; % nothing
end
