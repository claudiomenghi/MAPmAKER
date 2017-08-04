%% Input
% A: the specification of one of the automata
% h: the index upon which the specification must be explored
%% Output
% the automata participating in the spec satisfaction
function Parti = participating(A,h)

Parti = [];
Q = A.curr;

for i=1:h
    NewQ = [];
    for j=Q
        Parti = unique([Parti A.parti{j}]);
        [row actionNum]=size(A.Sigma);
        for k=1:actionNum
            NewQ = [NewQ A.trans{j,k}];            
        end
    end
    Q = unique(NewQ);
end

Parti = unique(Parti);