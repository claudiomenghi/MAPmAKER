%a sample automaton

function A = B21()

A.Q = [1:6]; %states
A.Sigma = [0:8]; %actions -- over 2^Pi
A.F = [2 3 4 5 6]; %final state
A.curr = 4; %initial

for i=A.Q
    for j=1:8
        A.trans{i,j}=[];
    end
end

for i=1:8
    A.trans{1,i}=[1];
end
A.trans{1,4}=[2];
A.trans{2,5}=[3];
A.trans{3,6}=[4];
A.trans{4,7}=[5];
A.trans{5,8}=[6];
A.trans{6,1}=[1];

%A.lab{1} = [20]; %labeling --  maps an action label to a subset of TS labels, 10 is empty

A.lab{1}= [27 11];
A.lab{2} = [21]; 
A.lab{3} = [22]; 
A.lab{4} = [23];
A.lab{5} = [24];
A.lab{6} = [25];
A.lab{7} = [26];
A.lab{8} = [28];

for i=1:6
    A.parti{i} = [2];
end

A.parti{5} = [1 2];


A.step = 1;