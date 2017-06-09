%a sample automaton

function A = B12()

A.Q = [1:6]; %states
A.Sigma = [0:7]; %actions -- over 2^Pi
A.F = [2 3 4 5 6]; %final state
%A.curr=5;
A.curr = 1; %initial
for i=A.Q
    for j=1:7
        A.trans{i,j}=[];
    end
end

for i=1:7
    A.trans{1,i}=[1];
end
A.trans{1,4}=[2];
A.trans{2,5}=[3];
A.trans{3,6}=[4];
A.trans{4,7}=[5];
A.trans{5,1}=[1];
A.trans{6,1}=[1];

%A.lab{1} = [20]; %labeling --  maps an action label to a subset of TS labels, 10 is empty

A.lab{1}= [17 21];
A.lab{2} = [11]; 
A.lab{3} = [12]; 
A.lab{4} = [13];
A.lab{5} = [14];
A.lab{6} = [15];
A.lab{7} = [16];

for i=1:6
    A.parti{i} = [1];
end
A.parti{5} = [1 2];

A.step = 1;