%% Input
% spec: the BA contains the specification of each robot
% perm: a permutation of the agents
% N: the total number of agens
% h: the horizont of of the computation of the intersection automaton
%% Output
% Dep{i}: i in 1...ell, is the list of indexes of the automata in ith dependency class
% ell: is the number of dependency classes
function [Dep,ell] = computeDependencies(spec,perm, N,h) 

for i=1:N
    fprintf('Computing participating for %d. \n', (i));
    Parti{i} = (participating(spec(i),h));
end


ell=0;
unsorted = perm;
while ~isempty(unsorted)
    ell = ell + 1;
    Dep{ell} = unsorted(1);
    newDep = unsorted(1);
    while ~isempty(newDep)
        newDep = [];
        for i=Dep{ell}
            newDep = unique([newDep Parti{i}]);
            for j=1:N
                if ~isempty(intersect(newDep,Parti{j}))
                    newDep = unique([newDep j]);
                end
            end
        end
        newDep = setdiff(newDep,Dep{ell});
        Dep{ell} = unique([Dep{ell} newDep]);
        Dep{ell} = intersect(perm,Dep{ell},'stable');
    end
    unsorted = setdiff(unsorted,Dep{ell},'stable');
    %for j = 1:length(Dep{ell})
    %    Dep{ell}(j) = permrev(Dep{ell}(j));
    %end     
end

fprintf('The dependency classes are:\n');
for i=1:ell
    fprintf('%d ',Dep{i});
    fprintf('\n');
end



