function [Path ] = searchActions(Product, acceptingstate)
% Given the product automaton and a progressing functions searches for a path to be followed by the robots

numberOfRobots=size(Product.STATES,2);
propertyIndex=numberOfRobots;


dim=size(Product.Q,2);

    
    
StatesReachability=zeros(dim,dim);
for rowIndex=1:size(Product.trans,1)
    for columnIndex=1:size(Product.trans,2)
        destinations=Product.trans{rowIndex,columnIndex};
        for destinationIndex=1:size(destinations,2)
            StatesReachability(rowIndex,destinations(destinationIndex))=1;
        end
    end
end

destinationStates=acceptingstate;

%plot(digraph(StatesReachability),'Layout','force');

acceptingIndex=find(ismember(Product.STATES,acceptingstate,'rows'));
[dist, path, pred]=graphshortestpath(sparse(StatesReachability), 1, acceptingIndex);

selectedpath=path;

for actionIndex=1:size(path,2)
    for robotIndex=1:numberOfRobots
        Path(actionIndex,robotIndex)=Product.STATES(path(actionIndex), robotIndex);
    end
end

