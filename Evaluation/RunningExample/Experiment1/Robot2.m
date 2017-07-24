%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot2(environmentMap, penvironmentMap, initPosition)

T.name='Robot2';
T.id=2; % the identifiers of the robot


T.Q=1:30;   %states
T.Pi=1:4; %all subsets of atomic propositions
% [{}, 
% {action1}, 
% {action2},
% {action1}, {action2}
%]

%Random value for the initial position of the robot
T.curr=initPosition;

T.init=T.curr;

T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot

%% services
for i=1:size(T.Q,2)
    T.ser{i}=[];
    T.sync{i}=[];
end

%T.ser{25} = 4;
T.ser{22} = 3;
T.ser{7} = 2;
%T.ser{9} = 2;

% adding the possible transition relation
T.pser=T.ser;

T.sync{7} = 1;  % must sync with the robot with identifiers 2
T.psync=T.sync;
T.psync{9}=1;

T.index = 3;




