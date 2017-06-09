%a sample automaton

function A = B32()

A.Q = [1:6]; %states
A.Sigma = [0:8]; %actions -- over 2^Pi
A.F = [2 3 4 5 6]; %final state
A.curr = 2; %initial
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

A.lab{1}= [37 21];
A.lab{2} = [31]; 
A.lab{3} = [32]; 
A.lab{4} = [33];
A.lab{5} = [34];
A.lab{6} = [35];
A.lab{7} = [36];
A.lab{8} = [38];

A.parti{8} = [3 2];
for i=1:7
    A.parti{i} = [3];
end

A.step = 1;