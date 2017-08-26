%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot2(environmentMap, penvironmentMap)

T.Q=1:144;   %states
T.Pi=3:4; %all subsets of atomic propositions

T.curr = 111;

%T.curr = 73;    %initial state
T.init=T.curr;
T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%% services
for i=1:144
    T.ser{i}=[];
end

T.ser{27} = 3;
T.ser{28} = 3;
T.ser{45} = 3;
T.ser{46} = 3;
T.ser{111} = 3;
T.ser{112} = 3;
T.ser{129} = 3;
T.ser{130} = 3;

T.ser{20} = 4; %t1
T.ser{40}= 4; %t2
T.ser{56}= 4; %t3
T.ser{25}=4; %t5
T.ser{76}=4; %t4

T.pser=T.ser;


T.index = 1;




