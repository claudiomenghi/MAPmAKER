%creates a transition system
%the grid is 18*8 = 144
%agent's state is just its position in the grid

%the blue guy

function T = PTC2(environmentMap, penvironmentMap)

T.Q=[1:144];   %states
T.Pi=[21:24]; %all subsets of atomic propositions
%T.curr=48;
T.curr = 18;    %initial state

%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;
T.lastaction=0; % the last action executed by the robot

%observation == labeling function
for i=1:144
    T.ser{i}=[];
end

% for i= 1:6
%     for j = 0:4
%         T.ser{i+18*j}=[22]; %room R3
%     end
% end
    
for i=7:12
    for j=0:3
       T.ser{i+18*j}=[21]; %room R4
    end
end

for i=13:18
    for j=0:3
       T.ser{i+18*j}=[23]; %room R5
    end
end

for i=79:90
    for j=0:3
       T.ser{i+18*j}=[24]; %room R2
    end
end

T.index = 2;




