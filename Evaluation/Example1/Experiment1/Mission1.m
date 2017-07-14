%% Input
% action1: the first action to be considered
% action2: the second action to be considered
%% Output
% return an automaton corresponding to the formula
% FINALLY(action1 && FINALLY(action2||action3))
function A = Mission2(action1, action2, action3,  robotsNecessaryForAction1, robotsNecessaryForAction2, robotsNecessaryForAction3)

A.name='Mission2';
%% states
A.Q = 1:2; 

%% initial state
A.curr = 1;

%% final states
A.F = 1; 

A.Sigma = 1:12; %actions -- over 2^Pi
% [
% 1 - {}, 
% 2 - {action1}, 
% 3 - {action2}, 
% 4 - {action3}, 
% 5 - {action1, action2}, 
% 6 - {action1, action3}, 
% 7 - {action2, action3},
% 8 - {action1, action2, action3}
%]
%% transitions
for i=A.Q
    for j=1:4
        A.trans{i,j}=[];
    end
end

A.trans{1,A.Sigma(1)}=1;
A.trans{1,A.Sigma(2)}=2;
A.trans{1,A.Sigma(5)}=3;
A.trans{1,A.Sigma(6)}=3;

A.trans{2,A.Sigma(1)}=2;
A.trans{2,A.Sigma(7)}=3;

A.trans{3,A.Sigma(1)}=3;

%% labeling
% maps an action label to a subset of TS labels
A.lab{1} = []; 
A.lab{2} = action1; 
A.lab{3} = action2; 
A.lab{4} = action3; 
A.lab{5} = [action1 action2];
A.lab{6} = [action1 action3];
A.lab{7} = [action2 action3];
A.lab{8} = [action1 action2 action3];

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