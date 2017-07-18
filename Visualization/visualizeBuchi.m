function [  ] = visualizeBuchi( Buchi )
%VISUALIZEBUCHI Summary of this function goes here
%   Detailed explanation goes here

labels={};
sources=[];
destList=[];
index=1;
StatesReachability=zeros(size(Buchi.Q,2),size(Buchi.Q,2));
for rowIndex=1:size(Buchi.trans,1)
    for columnIndex=1:size(Buchi.trans,2)
        if ~isempty(Buchi.trans(rowIndex,columnIndex))
            destinations=Buchi.trans(rowIndex,columnIndex);
            for destIndex=1:size(destinations,2)
                destination=destinations{destIndex};
                if ~isempty(destination)
                    StatesReachability(rowIndex,destination)=1;
                    lab=Buchi.lab(columnIndex)
                    if isempty(labels{index})
                         labels{index}=mat2str(lab{1});
                    else
                         labels{index}=strcat(labels{index}, ' OR ', mat2str(lab{1}));
                    end
                    sources=[sources rowIndex];
                    destList=[destList destination];
                    index=index+1;
                end
            end
        end
    end
end


h=plot(digraph(StatesReachability),'Layout','force');


labeledge(h, sources, destList, labels);
end

