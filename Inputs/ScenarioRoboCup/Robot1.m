%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1(environmentMap, penvironmentMap)

T.Q=1:169;   %states
T.Pi=1:2; %all subsets of atomic propositions
%T.curr = 102;
%T.curr = 2;    %initial state
%Random value for the initial position of the robot
T.curr = round(1 + (length(T.Q) - 1).*rand);
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

T.ser{93} = 1;
T.ser{94} = 1;
T.ser{102} = 2;
T.ser{103} = 2;

% adding the possible transition relation
T.pser=T.ser;

T.pser{57} = 1;
T.pser{58} = 1;
T.pser{63} = 2;
T.pser{64} = 2;

T.index = 3;




