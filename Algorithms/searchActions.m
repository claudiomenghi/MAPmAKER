function [Path ] = searchActions(Product, progressiveFunction)
% Given the product automaton and a progressing functions searches for a path to be followed by the robots

numberOfRobots=size(Product.STATES,2);
propertyIndex=numberOfRobots;

disp('Computing the progressive function');

dim=size(Product.Q,2);

%% computing the product progressive funciton

numProductStates=size(Product.STATES(:,1),1);
PRODUCT_PROGRESSIVE_FUNCTION=1:numProductStates;

for stateIndex=1:numProductStates
    PRODUCT_PROGRESSIVE_FUNCTION(stateIndex)=progressiveFunction(Product.STATES(stateIndex,propertyIndex));
end
    
    
StatesReachability=zeros(dim,dim);
for rowIndex=1:size(Product.trans,1)
    for columnIndex=1:size(Product.trans,2)
        destinations=Product.trans{rowIndex,columnIndex};
        for destinationIndex=1:size(destinations,2)
            StatesReachability(rowIndex,destinations(destinationIndex))=1;
        end
    end
end



maxValue=max(progressiveFunction(:,:));
destinationStates=find(PRODUCT_PROGRESSIVE_FUNCTION==maxValue);

%plot(digraph(StatesReachability),'Layout','force');

[dist, path, pred]=graphshortestpath(sparse(StatesReachability), 1);


selectedstate=destinationStates(1);
weight=dist(selectedstate);

for i=1:size(destinationStates,2)
    if(dist(destinationStates(i))<weight)
        selectedstate=destinationStates(i);
        weight=dist(selectedstate);
    end
end

selectedpath=path(selectedstate);
disp(selectedpath);


for actionIndex=1:size(selectedpath{1},2)
    for robotIndex=1:numberOfRobots
        Path(actionIndex,robotIndex)=Product.STATES(selectedpath{1}(actionIndex), robotIndex);
    end
end

