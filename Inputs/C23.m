%a sample automaton

function A = C23()

A.Q = [1:4]; %states
A.Sigma = [0:4]; %actions -- over 2^Pi
A.F = [4]; %final state
%A.curr=1;
A.curr = 3; %initial
for i=1:4
    for j=1:5
        A.trans{i,j}=[];
    end
end

A.trans{1,2}=[1,2];

A.trans{2,3}=[2,3];

A.trans{3,4}=[3,4];

A.trans{4,2}=[1,2];

%A.lab{1} = [30]; %labeling --  maps an action label to a subset of TS labels, 10 is empty

A.lab{1} = [21];%room 4 wittnessing
A.lab{2} = [21];%room 4 snapshot
A.lab{3} = [24];%room 2 snapshot
A.lab{4} = [23];%room 3

for i=1:4
    A.parti{i} = [2];
end

A.step = 1;