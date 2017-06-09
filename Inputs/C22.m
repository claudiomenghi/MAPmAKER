%a sample automaton

function A = C22()

A.Q = [1:10]; %states
A.Sigma = [0:4]; %actions -- over 2^Pi
A.F = 1; %final state
A.curr = 1; %initial
for i=1:10
    for j=1:4
        A.trans{i,j}=[];
    end
end

for i=2:10
    for j=1:4
        A.trans{i,j}=[i];
    end
end

A.trans{1,1}=[2];
A.trans{1,2}=[2];
A.trans{1,3}=[3];
A.trans{1,4}=[4];

A.trans{2,3}=[5];
A.trans{2,4}=[6];

A.trans{5,4}= [1];
A.trans{6,3}= 1;

A.trans{3,1}=[7];
A.trans{3,2}=[7];
A.trans{3,4}=[8];

A.trans{7,4}=1;
A.trans{8,1}=1;
A.trans{8,2}=1;

A.trans{4,1}=9;
A.trans{4,2}=9;
A.trans{4,3} = 10;

A.trans{9,3}=1;
A.trans{10,1}=1;
A.trans{10,2}=1;

%A.lab{1} = [30]; %labeling --  maps an action label to a subset of TS labels, 10 is empty

A.lab{1} = [21];

A.lab{2} = [22]; 
A.lab{3} = [23]; 
A.lab{4} = [24];


for i=1:10
    A.parti{i} = [2];
end

A.step = 1;