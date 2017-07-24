function [Path ] = searchActions(Product, acceptingstates)
% Given the product automaton and a progressing functions searches for a path to be followed by the robots

numberOfRobots=size(Product.STATES,2);
propertyIndex=numberOfRobots;


dim=size(Product.Q,2);

    
sources=[];
destinationsstates=[];
WG=[];
maxvalue=0;
for rowIndex=1:size(Product.trans,1)
    for columnIndex=1:size(Product.trans,2)
        destinations=Product.trans{rowIndex,columnIndex};
        for destinationIndex=1:size(destinations,2)
            maxvalue=max([maxvalue rowIndex destinations(destinationIndex)]);
          end
    end
end   
StatesReachability=zeros(maxvalue,maxvalue);
for source=1:size(Product.trans,1)
    for columnIndex=1:size(Product.trans,2)
        destinations=Product.trans{source,columnIndex};
        for destinationIndex=1:size(destinations,2)
            destination=destinations(destinationIndex);
            numstatechange=numberStateChanges(Product.STATES(source,:),Product.STATES(destination,:))+1;
            if(StatesReachability(source, destination)==0)
                StatesReachability(source, destination)=numstatechange;
            else
                StatesReachability(source, destination)=min([StatesReachability(source, destination) numstatechange]);
            end
        end
    end
end

dim=max(size(StatesReachability));

WG=[];
for rowIndex=1:size(StatesReachability,1)
    for columnIndex=1:size(StatesReachability,2)
        if((StatesReachability(rowIndex, columnIndex)>0))
            WG=[WG StatesReachability(rowIndex, columnIndex)];
        end
    end
end

%plot(digraph(StatesReachability),'Layout','force','EdgeLabel');

[dist, path, pred]=graphshortestpath(sparse(StatesReachability), 1, 'directed', true);

destinationStates=acceptingstates;
selectedpath=-1;
length=-1;
for i=1:size(destinationStates,1)
    if isequal(selectedpath,-1)
        acceptingIndex=find(ismember(Product.STATES,destinationStates(i,:),'rows'));
        selectedpath=path(acceptingIndex);
        length=dist(acceptingIndex);
    else
       acceptingIndex=find(ismember(Product.STATES,destinationStates(i,:),'rows'));
        if dist(acceptingIndex)<length
            selectedpath=path(acceptingIndex);
            length=dist(acceptingIndex);
        end
    end
end

selectedpath=selectedpath{1};
for actionIndex=1:size(selectedpath,2)
    %if(actionIndex<size(selectedpath,2))
     %    disp(selectedpath(actionIndex));
     %    disp(StatesReachability(selectedpath(actionIndex),selectedpath(actionIndex+1)));
     %    disp(Product.STATES(selectedpath(actionIndex),:))
     %    disp(Product.STATES(selectedpath(actionIndex+1),:));
    %end
    for robotIndex=1:numberOfRobots
        Path(actionIndex,robotIndex)=Product.STATES(selectedpath(actionIndex), robotIndex);
    end
end
a=1;
