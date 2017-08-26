function [P] = dijkstra(P)


fprintf('Running dijkstra \n');
processed = [];
to_search = 1;
found = 0;
P.d{1}=0;
while ~isempty(to_search) && ~found
    
    %the one with maximum P.d
    i=to_search(1);
    for j = 1:length(to_search)
        if P.d{to_search(j)} < P.d{i}
            i=to_search(j);
        end
    end
    

    if ismember(i,P.max)
            P.final = i;
            found = 1;
            break;
    end
        
    to_search=setdiff(to_search,i);
    processed = unique([processed i]);
    for j=P.succ{i}
        
        if isempty(P.pred{j})
            P.pred{j} = i;
            P.pred_action{j} = P.action{i,j};
        end
        
        to_search = [to_search j];
   
        if P.d{j} > P.d{i} + P.weight{i,j}
            P.d{j} = P.d{i} + P.weight{i,j};
        
        end
    end
    to_search = setdiff(to_search, processed, 'stable');
    
end