%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot2(environmentMap, penvironmentMap)

T.Q=1:169;   %states
T.Pi=3:4; %all subsets of atomic propositions
%T.curr= 76;

T.curr = 142;    %initial state
T.init=T.curr;
T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%% services
for i=1:169
    T.ser{i}=[];
end

T.ser{102} = 3;

T.ser{63} = 4; 

T.pser=T.ser;
T.pser{98} = 1;
T.pser{118} = 2;

T.index = 3;




