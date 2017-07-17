%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1Test(environmentMap, penvironmentMap, initPosition)

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
for i=1:224
    T.ser{i}=[];
end

T.ser{1} = 2;

T.ser{2} = 1;

T.ser{3} = 3;

% adding the possible transition relation
T.pser=T.ser;


T.index = 3;




