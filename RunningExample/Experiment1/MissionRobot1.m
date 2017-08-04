%% Input
% action1: the first action to be considered
% action2: the second action to be considered
%% Output
% return an automaton corresponding to the formula
% GLOBALLY(FINALLY(action1))
function A = MissionRobot1(action1,   robotsNecessaryForAction1)

A.name='MissionRobot1';
%% states
A.Q = 1:2; 

%% initial state
A.curr = 1;

%% final states
A.F = 2; 

actionNum=2;
A.Sigma = 1:2; %actions -- over 2^Pi
% [
% 1 - {}, 
% 2 - {action1}, 
%]
%% transitions
for i=A.Q
    for j=1:actionNum
        A.trans{i,j}=[];
    end
end

A.trans{1,A.Sigma(1)}=1;
A.trans{1,A.Sigma(2)}=2;
A.trans{2,A.Sigma(1)}=1;
A.trans{2,A.Sigma(2)}=2;


%% labeling
% maps an action label to a subset of TS labels
A.lab{1} = []; 
A.lab{2} = action1; 

%% partitioning
% specifies for each action the other involved actors. It represents
% synchronization primitives
A.lab{1}= [];
A.parti{2} = robotsNecessaryForAction1; 

A.step = 1;