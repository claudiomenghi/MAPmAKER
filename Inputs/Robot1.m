%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1(environmentMap, penvironmentMap)

T.Q=1:144;   %states
T.Pi=31:36; %all subsets of atomic propositions
%T.curr = 102;
T.curr = 91;    %initial state
T.init=T.curr;

%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot

% [{}, {action1}, {action2}, {action1, action2}]

%% services
for i=1:144
    T.ser{i}=[];
end

T.ser{27} = 1;
T.ser{28} = 2;
T.ser{45} = 2;
T.ser{46} = 2;

T.ser{111} = 1;
T.ser{112} = 1;
T.ser{129} = 1;
T.ser{130} = 1;

T.ser{51} = 2;
T.ser{52} = 2;
T.ser{33} = 2;
T.ser{34} = 2;

T.ser{98} = [1 2];
T.ser{99} = [1 2];
T.ser{116} = [1 2];
T.ser{117} = [1 2];

T.ser{100} = [1 2];
T.ser{101} = [1 2];
T.ser{118} = [1 2];
T.ser{119} = [1 2];

T.ser{105} = 2;
T.ser{106} = 2;
T.ser{123} = 2;
T.ser{124} = 2;

T.index = 3;




