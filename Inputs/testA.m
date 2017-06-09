%a sample automaton

function A = testA()

A.Q = [1:4]; %states
A.Sigma = [0:5]; %actions -- over 2^Pi
A.F = [2 4]; %final state
A.curr=2; %initial
for i=1:5
    A.trans{1,i}=[1];
    A.trans{2,i}=[];
    A.trans{3,i}=[3];
    A.trans{4,i}=[1];
end
A.trans{1,5}=[1 2]; %A.trans{state,act}=[list states]
A.trans{2,3}=[3];
A.trans{3,4}=[3 4];

A.lab{1} = [10]; %labeling --  maps an action label to a subset of TS labels, 10 is empty
A.lab{2} = [11]; 
A.lab{3} = [12]; 
A.lab{4} = [13];
A.lab{5} = [11 21];

A.parti{1} = [1 2];
A.parti{2} = [1];
A.parti{3} = [1];
A.parti{4} = [1];

A.alpha{2} = [1:4];
A.alpha{4} = [5];
A.alpha{6} = [1:5];

A.step = 1;