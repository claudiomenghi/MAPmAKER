%a sample automaton

function A = C3()

A.Q = [1:4]; %states
A.Sigma = [0:4]; %actions -- over 2^Pi
A.F = [4]; %final state
A.curr = 3; %initial
for i=A.Q
    for j=1:4
        A.trans{i,j}=[];
    end
end

for i=1:4
    A.trans{1,i}=[1];
    A.trans{2,i}=[2];
    A.trans{3,i}=[3];
end
A.trans{1,2}=[1 2];
A.trans{2,3}=[2 3];
A.trans{3,4}=[3 4];
A.trans{4,2}=[1 2];
A.trans{4,1}=[1]; 

%A.lab{1} = [30]; %labeling --  maps an action label to a subset of TS labels, 10 is empty
A.lab{2} = [32]; 
A.lab{3} = [33]; 
A.lab{4} = [34];
A.lab{1} = [31];

for i=1:4
    A.parti{i} = [3];
end

A.step = 1;