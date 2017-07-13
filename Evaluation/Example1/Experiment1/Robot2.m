%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot2(environmentMap, penvironmentMap, initPosition)

T.Q=1:224;   %states
T.Pi=3:4; %all subsets of atomic propositions
%T.curr= 76;

%T.curr = 106;    %initial state

%Random value for the initial position of the robot
T.curr=initPosition;

% occupied=[4 9 11 12 18 21:23 41:43 46 55:57 60 63 64 69 70 74 81:84 ...
%     95:98 108:112 114 115 122:129 134:140 141:143 146 148:154 155:157 160 ...
%     162:168 169:171 176:182 183:185 191:196 197:199 105:210 211 212 219:224];
% 
% while (1)
%     valid=1;
%     T.curr = round(1 + (length(T.Q) - 1).*rand);
%     for i=1:length(occupied)
%         if T.curr==occupied(i)
%             disp('The initial position ', T.curr, ' is not valid.')
%             valid=0;
%             break;
%         end
%     end
%     if valid==1
%         break;
%     end  
% end
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

T.ser{94} = 3;
T.ser{130} = 4;

% adding the possible transition relation
T.pser=T.ser;


T.index = 3;




