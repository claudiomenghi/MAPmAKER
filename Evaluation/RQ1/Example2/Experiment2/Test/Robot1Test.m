%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1Test(environmentMap, penvironmentMap, initPosition)

T.name='Robot1';
T.id=1; % the identifiers of the robot


T.Q=1:9;   %states
T.Pi=1:3; %all subsets of atomic propositions

T.curr=initPosition;

T.init=T.curr;

%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot

% [{}, {action1}, {action2}, {action1, action2}]

%% services
for i=1:size(T.Q,2)
    T.ser{i}=[];
    T.sync{i}=[];
end

T.ser{1} = 2;

T.ser{9} = 1;

T.ser{3} = 3;

% adding the possible transition relation
T.pser=T.ser;
T.sync{9} = 2;

T.index = 3;




