%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1(environmentMap, penvironmentMap)

T.Q=1:169;   %states
T.Pi=1:2; %all subsets of atomic propositions
%T.curr = 102;
T.curr = 2;    %initial state
T.init=T.curr;

%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot

% [{}, {action1}, {action2}, {action1, action2}]

%% services
for i=1:169
    T.ser{i}=[];
end

T.ser{93} = 2;

T.ser{102} = 1;

% adding the possible transition relation
T.pser=T.ser;
T.pser{98} = 1;
T.pser{118} = 2;


T.index = 3;




