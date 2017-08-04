

function [ Buchi, progressiveFunction ] = computeProgressiveFunction( Buchi , nagent, kmap)
%COMPUTEPROGRESSIVEFUNCTION given a Buchi automaton computes the
%progressive function for each of the states of the automaton

disp('Computing the progressive function');

dim=size(Buchi.Q,2);
BuchiReachability=zeros(dim,dim);
for rowIndex=1:size(Buchi.trans,1)
    for columnIndex=1:size(Buchi.trans,2)
            BuchiReachability(rowIndex,Buchi.trans{rowIndex,columnIndex})=1;
    end
end
dist=distances(digraph(BuchiReachability));

%plot(digraph(BuchiReachability),'Layout','force');

for(q = 1:size(Buchi.Q,2))
    statenode=Buchi.Q(q);
    progressiveFunction(q)=0;
    minvalue=inf;
    for(k = 1:size(Buchi.F,2))
        acceptingnode=Buchi.F(k);
        minvalue=min(minvalue, dist(q,acceptingnode));
    end
    progressiveFunction(q)=kmap(q,2)-minvalue;
end

end

