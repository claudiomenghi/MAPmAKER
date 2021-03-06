%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1(environmentMap, penvironmentMap, initPosition)

T.name='Robot1';
T.id=1; % the identifiers of the robot

T.Q=1:224;   %states
T.Pi=1:3; %all subsets of atomic propositions

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

% [{}, {action1}, {action2}, {action1, action2}]

%% services
for i=1:224
    T.ser{i}=[];
    T.sync{i}=[];
end

T.ser{45} = 3;
T.ser{47} = 3;
T.ser{213} = 3;
T.ser{199} = 3;

T.ser{37} = 2;
T.ser{38} = 2;
T.ser{218} = 2;
T.ser{204} = 2;

T.ser{99} = 1;
T.ser{3} = 1;
T.ser{80} = 1;


T.sync{99} = 2;  % must sync with the robot with identifiers 2
T.sync{3} =2;
T.sync{80} =2;


% adding the possible transition relation
T.pser=T.ser;
T.psync=T.sync;

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

T.index = 3;




