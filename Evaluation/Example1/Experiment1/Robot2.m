%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot2(environmentMap, penvironmentMap, initPosition)

T.name='Robot2';
T.id=2; % the identifiers of the robot


T.Q=1:224;   %states
T.Pi=4:5; %all subsets of atomic propositions
%T.curr= 76;

%T.curr = 106;    %initial state

%Random value for the initial position of the robot
T.curr=initPosition;

T.init=T.curr;
T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%% services
for i=1:224
    T.ser{i}=[];
    T.sync{i}=[];
end

T.ser{216} = 4;
T.ser{215} = 4;

T.ser{106} = 5; %t1
T.ser{107}= 5; %t2
T.sync{106}=1;
T.sync{107}=1;

T.ser{94} = 4;
T.ser{130} = 5;
T.sync{130}=1;

% adding the possible transition relation
T.pser=T.ser;


T.index = 3;




