%a sample automaton

function B = testB()

B.Q = [1:5]; %states
B.Sigma = [0:5]; %actions -- over 2^Pi
B.F = [5]; %final state
B.curr=1; %initial
for i=1:4
    for j=1:5
        B.trans{i,j}=[i];
    end
    B.trans{i,i}=[i i+1];
    
end
for i=1:5
    B.trans{5,i}=[1];
end

B.lab{1} = [20];
B.lab{2} = [21];
B.lab{3} = [22]; %labeling --  maps an action label to a TS label
B.lab{4} = [23];
B.lab{5} = [24];


B.parti{1} = [2];
B.parti{2} = [2];
B.parti{3} = [2];
B.parti{4} = [2];
B.parti{5} = [2];

B.alpha{4} = [1:5];

B.step = 1;