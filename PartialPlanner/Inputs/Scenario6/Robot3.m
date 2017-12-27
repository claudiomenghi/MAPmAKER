%% Input
% environmentMap: the definitive map of the environment
% penvironmentMap: the possible map of the environment
%% Output
% the model of the robot
function T = Robot3(environmentMap, penvironmentMap)

T.Q=1:144;   %states
T.Pi=5:6; %all subsets of atomic propositions
%T.curr=48;
T.curr = 18;    %initial state
T.init=T.curr;
%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%% services
%observation == labeling function
for i=1:144
    T.ser{i}=[];
end

    
for i=7:12
    for j=0:3
       T.ser{i+18*j}=5; %room R4
    end
end

for i=13:18
    for j=0:3
       T.ser{i+18*j}=6; %room R5
    end
end

for i=79:90
    for j=0:3
       T.ser{i+18*j}=5; %room R2
    end
end

T.index = 2;




