%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot3(environmentMap, penvironmentMap, initPosition)

T.name='Robot3';
T.id=3; % the identifiers of the robot


T.Q=1:224;   %states
T.Pi=6:7; %all subsets of atomic propositions
%T.curr= 76;

%T.curr = 106;    %initial state

%Random value for the initial position of the robot
T.curr=initPosition;

T.init=T.curr;
% contains all the services provided by the robot
T.services=[];
% contains all the robots that must synch with this robot
T.syncrobotset=[T.id];

T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%% services
for i=1:224
    T.ser{i}=[];
    T.sync{i}=[];
end

T.ser{200} = 6;
T.ser{199} = 6;

T.ser{50} = 7; %t1
T.ser{49}= 7; %t2




T.ser{140} = 6;
T.ser{120} = 6;


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




