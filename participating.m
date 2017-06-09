function Parti = participating(A,h)

Parti = [];
Q = A.curr;

for i=1:h
    NewQ = [];
    for j=Q
        Parti = unique([Parti A.parti{j}]);
        for k=1:(length(A.Sigma)-1)
            NewQ = [NewQ A.trans{j,k}];            
        end
    end
    Q = unique(NewQ);
end

Parti = unique(Parti);