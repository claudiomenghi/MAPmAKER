%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot2(environmentMap, penvironmentMap)

T.Q=1:169;   %states
T.Pi=3:4; %all subsets of atomic propositions
%T.curr= 76;

%.curr = 142;    %initial state
%Random value for the initial position of the robot
T.curr = round(1 + (length(T.Q) - 1).*rand);
while (T.curr==9 || T.curr==10 || T.curr==11 || T.curr==12 || T.curr==13 ...
    || T.curr==27 || T.curr==36 || T.curr==40 || T.curr==44 || T.curr==49 ...
    || T.curr==76 || T.curr==77 || T.curr==79 || T.curr==81 || T.curr==82 ...
    || T.curr==83 || T.curr==89 || T.curr==90 || T.curr==112 || T.curr==125 ...
    || T.curr==132 || T.curr==135 || T.curr==136 || T.curr==138 || T.curr==140 ...
    || T.curr==141 || T.curr==153 || T.curr==154 || T.curr==160 || T.curr==161 ...
    || T.curr==162 || T.curr==163 || T.curr==166 || T.curr==167)
    disp('The initial position ', T.curr, ' is not valid.')
    T.curr = round(1 + (length(T.Q) - 1).*rand);
end
T.init=T.curr;
T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%% services
for i=1:169
    T.ser{i}=[];
end

T.ser{102} = 3;
T.ser{103} = 3;
T.ser{6} = 4; 
T.ser{7} = 4; 

T.pser=T.ser;
T.pser{98} = 3;
T.pser{99} = 3;
T.pser{2} = 4;
T.pser{3} = 4;

T.index = 3;




