%% Input
% action1: the first action to be considered
% action2: the second action to be considered
%% Output
% return an automaton corresponding to the formula
% FINALLY(action1||action2))
function A = Mission1b(action1, action2, action3,   robotsNecessaryForAction1, robotsNecessaryForAction2, robotsNecessaryForAction3)

A.name='Mission2';
%% states
A.Q = 1:2; 

%% initial state
A.curr = 1;

%% final states
A.F = 2; 

actionNum=4;
A.Sigma = 1:actionNum; %actions -- over 2^Pi
% [
% 1 - {}, 
% 2 - {action1}, 
% 3 - {action2}, 
% 4 - {action1, action2}, 
%]
%% transitions
for i=A.Q
    for j=1:actionNum
        A.trans{i,j}=[];
    end
end

A.trans{1,A.Sigma(1)}=1;
A.trans{1,A.Sigma(2)}=2;
A.trans{1,A.Sigma(3)}=2;
A.trans{1,A.Sigma(4)}=2;
A.trans{2,A.Sigma(1)}=2;


%% labeling
% maps an action label to a subset of TS labels
A.lab{1} = []; 
A.lab{2} = action1; 
A.lab{3} = action2; 
A.lab{4} = [action1 action2];

%% partitioning
% specifies for each action the other involved actors. It represents
% synchronization primitives
A.lab{1}= [];
A.parti{2} = robotsNecessaryForAction1; 
A.parti{3} = robotsNecessaryForAction2; 
A.parti{4} = robotsNecessaryForAction3; 
A.parti{5} = [robotsNecessaryForAction1 robotsNecessaryForAction2];
A.parti{6} = [robotsNecessaryForAction1 robotsNecessaryForAction3];
A.parti{7} = [robotsNecessaryForAction2 robotsNecessaryForAction3];
A.parti{8} = [robotsNecessaryForAction1 robotsNecessaryForAction2 robotsNecessaryForAction3];

A.step = 1;
end