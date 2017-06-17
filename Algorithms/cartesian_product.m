%% INPUT
%  varargin: contains an array of sets of elements
%% OUTPUT
% set: the cartesian product between the sets in the array
function set = cartesian_product(varargin)


%Cartesian (direct) product of input sets; input sets must be row vectors
%obtain a matrix (or a cell if uncomment last line), each row is an element of the product
N=zeros(1,nargin);
for i=1:nargin
    if isempty(varargin{i}) %is any of inputs is empty, the result is also empty
        set=[];
        return
    end
    varargin{i}=unique(varargin{i});    %eliminate repeated elements from a subset (and order subsets ascending)
    N(i)=length(varargin{i});   %vector N will contain the number of elements of each subset
end

N=[1 N 1];  %add 2 elements of 1 in order to execute the "for"-loop for the last and first subset
            %(otherwise we would have got error because of index i)

set=zeros(prod(N),nargin);  %size of a matrix that will contain on each row a element of the cartesian product

for i = nargin:-1:1 %go backward through inputs (add columns starting with the last one)
    % col=[]; %will be the column (of the final set) corresponding to the i-th subset from input
    prod_val=prod(N(i+2:length(N)));    %to avoid multiple computations of same value
    col=zeros(prod_val*length(varargin{i}), 1); %preallocate vector col (see content above)
    for j=1:length(varargin{i})
        % col=[col ; repmat(varargin{i}(j),prod(N(i+2:length(N))),1)];  %repeated appearances of the j-th element of i-th subset
                %each element is repeated "prod(...)" times (in order to add at right elements of subsequent sets)
                %in N would not have been borded with 2 elements of 1, we would have had "prod(N(i+1:nargin))",
                %but N has (nargin+2) elements, and the previous value N(i)(length of subset i) is now at index (i+1)
        col(1+prod_val*(j-1) : prod_val*j)=repmat(varargin{i}(j),prod(N(i+2:length(N))),1);  %store values in preallocated vector col
    end
    col=repmat(col,prod(N(1:i)),1);   %the whole column until now is repeated
                                      %(in order to add before it columns with elements from previous sets)
                                      %N(i+1) is now the number of elements of subset i
    set(:,i)=col;
end


% set=mat2cell(set,ones(1,prod(N)),nargin); %if we want to obtain a cell, each cell element being a element of Cartesian product
