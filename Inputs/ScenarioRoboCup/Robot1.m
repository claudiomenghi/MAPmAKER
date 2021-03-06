%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1(environmentMap, penvironmentMap)

T.Q=1:169;   %states
T.Pi=1:2; %all subsets of atomic propositions
%T.curr = 102;
%T.curr = 2;    %initial state
%Random value for the initial position of the robot

T.curr = round(1 + (length(T.Q) - 1).*rand);
while (T.curr==9 || T.curr==10 || T.curr==11 || T.curr==12 || T.curr==13 ...
    || T.curr==27 || T.curr==36 || T.curr==40 || T.curr==44 || T.curr==49 ...
    || T.curr==76 || T.curr==77 || T.curr==79 || T.curr==81 || T.curr==82 ...
    || T.curr==83 || T.curr==89 || T.curr==90 || T.curr==112 || T.curr==125 ...
    || T.curr==132 || T.curr==135 || T.curr==136 || T.curr==138 || T.curr==140 ...
    || T.curr==141 || T.curr==153 || T.curr==154 || T.curr==160 || T.curr==161 ...
    || T.curr==162 || T.curr==163 || T.curr==166 || T.curr==167)
    msg=['The initial position ', T.curr, ' is not valid.'];
    disp(msg)
    T.curr = round(1 + (length(T.Q) - 1).*rand);
end
T.init=T.curr;

%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot

% [{}, {action1}, {action2}, {action1, action2}]

%% services
for i=1:169
    T.ser{i}=[];
end

T.ser{93} = 1;
T.ser{94} = 1;
T.ser{102} = 2;
T.ser{103} = 2;

% adding the possible transition relation
T.pser=T.ser;

T.pser{57} = 1;
T.pser{58} = 1;
T.pser{63} = 2;
T.pser{64} = 2;

T.index = 3;




