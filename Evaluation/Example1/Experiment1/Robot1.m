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


T.ser{53} = 2;
T.ser{54} = 2;
T.ser{55} = 2;

T.ser{99} = 1;
T.ser{100} = 1;
T.ser{130} = 1;


T.sync{99} = 2;  % must sync with the robot with identifiers 2
T.sync{100} =2;
T.sync{130} =2;


% adding the possible transition relation
T.pser=T.ser;


T.index = 3;




