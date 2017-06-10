%creates a transition system
%the grid is 18*8 = 144
%agent's state is just its position in the grid

%the green guy from the paper

function T = PTA3(environmentMap, penvironmentMap)

T.Q=1:144;   %states
T.Pi=31:36; %all subsets of atomic propositions
%T.curr = 102;
T.curr = 91;    %initial state


%adjacency matrix
T.adj=environmentMap;
T.padj=penvironmentMap;

T.lastaction=0; % the last action executed by the robot



%observation == labeling function
for i=1:144
    T.ser{i}=[];
end

T.ser{27} = [31,33,35];
T.ser{28} = [31,33,35];
T.ser{45} = [31,33,35];
T.ser{46} = [31,33,35];

T.ser{111} = [31];
T.ser{112} = [31];
T.ser{129} = [31];
T.ser{130} = [31];

T.ser{51} = [36];
T.ser{52} = [36];
T.ser{33} = [36];
T.ser{34} = [36];

T.ser{98} = [32,34];
T.ser{99} =[32,34];
T.ser{116} = [32,34];
T.ser{117} =[32,34];

T.ser{100} = [35];
T.ser{101} = [35];
T.ser{118} = [35];
T.ser{119} = [35];

T.ser{105} = [33,36];
T.ser{106} = [33,36];
T.ser{123} = [33,36];
T.ser{124} = [33,36];

T.index = 3;

% %LOADED
% %left-right
% for k=0:11
%     for i=(216+k*18+1):(216+(k+1)*18-1)
%         T.adj(i,i+1)=1;
%     end
%     for i = (216+k*18+2):(216+(k+1)*18)
%         T.adj(i,i-1)=1;
%     end    
% end
% 
% %up-down
% for k=0:10
%     for i=(216+k*18+1):(216+(k+1)*18)
%         T.adj(i,i+18)=1;
%     end
% end
% 
% for k=1:11
%      for i=(216+k*18+1):(216+(k+1)*18)
%         T.adj(i,i-18)=1;
%     end
% end
%     
% T.adj(216+6,216+7)=0;
% T.adj(216+7,216+6)=0;
% T.adj(216+12,216+13)=0;
% T.adj(216+13,216+12)=0;
% for i=[1,4,5,6,7,10,11]
%     T.adj(216+6+i*18,216+7+i*18)=0;
%     T.adj(216+12+i*18,216+13+i*18)=0;
%     T.adj(216+7+i*18,216+6+i*18)=0;
%     T.adj(216+13+i*18,216+12+i*18)=0;
% end
% 
% 
% T.adj(216+145,216+127)=0;
% T.adj(216+127,216+145)=0;
% for i=[1,4,5]
%     T.adj(216+145+i,216+127+i)=0;
%     T.adj(216+127+i,216+145+i)=0;
% end
% 
% T.adj(216+97,216+115)=0;
% T.adj(216+115,216+97)=0;
% 
% for i=[1,4,5,6,7,10,11]
%     T.adj(216+97+i,216+115+i)=0;
%     T.adj(216+115+i,216+97+i)=0;
% end
% 
% %%%LOADING - UNLOADING


