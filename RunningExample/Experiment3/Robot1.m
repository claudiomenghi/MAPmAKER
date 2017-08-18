%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1(environmentMap, penvironmentMap, initPosition)

T.name='Robot1';
T.id=1; % the identifiers of the robot

T.Q=1:30;   %states
T.Pi=1:2; %all subsets of atomic propositions

T.curr=initPosition;

T.init=T.curr;
% contains all the services provided by the robot
T.services=[];
% contains all the robots that must synch with this robot
T.syncrobotset=[T.id];

%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot

% [{}, {action1}]

%% services
for i=1:size(T.Q,2)
    T.ser{i}=[];
    T.sync{i}=[];
end

T.ser{7} = 1;
T.ser{9} = 1;

% adding the possible transition relation
T.pser=T.ser;
T.compser=T.ser;

T.sync{7} = 2;  % must sync with the robot with identifiers 2
T.psync=T.sync;
T.psync{9}=2;
T.compsync=T.psync;

%% updates the services provided by the robot
for i=1:size(T.Q,2)
    if ~isempty(T.ser{i})
        T.services=[T.services T.ser{i}];
    end
    if ~isempty(T.pser{i})
        T.services=[T.services T.ser{i}];
    end
end

%% updates the robots that must synch with this robot
for i=1:size(T.Q,2)
    if ~isempty(T.sync{i})
        T.syncrobotset=[T.syncrobotset T.sync{i}];
    end
    if ~isempty(T.psync{i})
        T.syncrobotset=[T.syncrobotset T.psync{i}];
    end
end

T.index = 1;




