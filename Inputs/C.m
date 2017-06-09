%a sample automaton

function A = C()

A.Q = [1:6]; %states
A.Sigma = [0:6]; %actions -- over 2^Pi
A.F = [6]; %final state
A.curr = 1; %initial
for i=A.Q
    for j=1:6
        A.trans{i,j}=[];
    end
end

for i=1:6
    A.trans{1,i}=[1];
    A.trans{2,i}=[2];
    A.trans{3,i}=[3];
    A.trans{4,i}=[4];
    A.trans{5,i}=[5];
    A.trans{6,i}=[1];
end
A.trans{1,3}=[1 2];
A.trans{2,4}=[2 3];
A.trans{3,5}=[3 4];
A.trans{4,6}=[4 5];
A.trans{5,1}=[5 6];
A.trans{6,3}=[1 2];

%A.lab{1} = [30]; %labeling --  maps an action label to a subset of TS labels, 10 is empty
A.lab{2} = [31]; 
A.lab{3} = [32]; 
A.lab{4} = [33];
A.lab{5} = [34];
A.lab{6} = [35];
A.lab{1} = [36];

for i=1:7
    A.parti{i} = [3];
end

A.step = 1;