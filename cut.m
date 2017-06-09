function A = cut(B,h)

A.Q = [];
Parti = participating(B,h);
A.Sigma = B.Sigma;
%A.Sigma = B.alpha{sum(power(2,Parti))};
A.curr = B.curr;
Qnew = [A.curr];

i=0;

while i<h && ~isempty(setdiff(Qnew,A.Q))
    A.Q = unique([A.Q Qnew]);
    Qnew=[];
    for j = A.Q
        for k = A.Sigma
            if k~=0
                A.trans{j,k} = B.trans{j,k};
                Qnew = unique([Qnew A.trans{j,k}]);
            end
        end
    end
    i=i+1;
end
A.Q = unique([A.Q Qnew]);
A.F = intersect(A.Q,B.F);