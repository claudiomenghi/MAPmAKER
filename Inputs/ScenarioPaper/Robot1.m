%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot1(environmentMap, penvironmentMap)

T.Q=1:224;   %states
T.Pi=1:2; %all subsets of atomic propositions
%T.curr = 102;
%T.curr = 54;    %initial state

%Random value for the initial position of the robot
occupied=[4 9 11 12 18 21:23 41:43 46 55:57 60 63 64 69 70 74 81:84 ...
    95:98 108:112 114 115 122:129 134:140 141:143 146 148:154 155:157 160 ...
    162:168 169:171 176:182 183:185 191:196 197:199 105:210 211 212 219:224];

while (1)
    valid=1;
    T.curr = round(1 + (length(T.Q) - 1).*rand);
    for i=1:length(occupied)
        if T.curr==occupied(i)
            msg=['The initial position ', num2str(T.curr), ' is not valid.'];
            disp(msg)
            valid=0;
            break;
        end
    end
    if valid==1
        break;
    end  
end
T.init=T.curr;

%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot

% [{}, {action1}, {action2}, {action1, action2}]

%% services
for i=1:224
    T.ser{i}=[];
end

T.ser{53} = 2;
T.ser{54} = 2;
T.ser{55} = 2;

T.ser{99} = 1;
T.ser{100} = 1;

% adding the possible transition relation
T.pser=T.ser;
T.pser{94} = 2;
T.pser{130} = 1;


T.index = 3;




