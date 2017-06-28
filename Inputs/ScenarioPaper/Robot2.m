%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot2(environmentMap, penvironmentMap)

T.Q=1:224;   %states
T.Pi=3:4; %all subsets of atomic propositions
%T.curr= 76;

T.curr = 106;    %initial state
T.init=T.curr;
T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%% services
for i=1:224
    T.ser{i}=[];
end

T.ser{216} = 3;
T.ser{215} = 3;

T.ser{106} = 4; %t1
T.ser{107}= 4; %t2

% adding the possible transition relation
T.pser=T.ser;
T.pser{94} = 3;
T.pser{130} = 4;

T.index = 3;




