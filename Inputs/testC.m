%a sample automaton

function A = testA()

A.Q = [1:4]; %states
A.Sigma = [1:16]; %actions -- over 2^Pi
A.F = [2 4]; %final state
A.curr=1; %initial
for i=1:16
    A.trans{1,i}=[1];
    A.trans{2,i}=[];
    A.trans{3,i}=[3];
    A.trans{4,i}=[1];
end
A.trans{1,5}=[1 2]; %A.trans{state,act}=[list states]
A.trans{2,2} = [3];
for i=9:12
    A.trans{2,i}=[3];
end
A.trans{3,3} = [3 4];
for i=13:16
    A.trans{3,4};
end

A.lab{1} = [11]; %labeling --  maps an action label to a subset of TS labels, 10 is empty
A.lab{2} = [12]; 
A.lab{3} = [13];
A.lab{4} = [];

A.lab{5} = [11 21];
A.lab{6} = [11 22];
A.lab{7} = [11 23];
A.lab{8} = [11 24];
A.lab{9} = [12 21];
A.lab{10} = [12 22];
A.lab{11} = [12 23];
A.lab{12} = [12 24];
A.lab{13} = [13 21];
A.lab{14} = [13 22];
A.lab{15} = [13 23];
A.lab{16} = [13 24];

A.parti{1} = [1 2];
A.parti{2} = [1];
A.parti{3} = [1];
A.parti{4} = [1];