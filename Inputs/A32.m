%a sample automaton

function A = A32()

A.Q = [1:6]; %states
A.Sigma = [0:6]; %actions -- over 2^Pi
A.F = [2 4 6]; %final state
A.curr = 1; %initial
%A.curr=6;
for i=A.Q
    for j=1:6
        A.trans{i,j}=[];
    end
end
        
for i=1:6
    A.trans{1,i}=[1];
    A.trans{3,i}=[3];
    A.trans{5,i}=[5];
end
A.trans{1,2}=[1 2];
A.trans{2,3}=[3];
A.trans{3,4}=[3 4];
A.trans{4,5}=[5];
A.trans{5,6}=[5 6];
A.trans{6,1}=[3];

A.lab{1} = [36]; %unload3 %labeling --  maps an action label to a subset of TS labels, 10 is empty
A.lab{2} = [11 31]; %load1
A.lab{3} = [32]; %unload1
A.lab{4} = [33]; %load2
A.lab{5} = [34]; %unload2
A.lab{6} = [35]; %load3
%A.lab{7} = [16];

A.parti{1} = [1 3];
A.parti{2} = [3];
for i=3:6
    A.parti{i} = [3];
end

A.step = 1;