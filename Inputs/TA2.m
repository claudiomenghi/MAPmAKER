%create a transition system

function T = TA2(environmentMap)

T.Q=1:144;   %states
T.Pi=21:26; %all subsets of atomic propositions
T.curr = 117;    %initial state

T.adj=environmentMap;

%observation == labeling function
for i=1:144
    T.ser{i}=[];
end

T.ser{27} = [21,23,25];
T.ser{28} = [21,23,25];
T.ser{45} = [21,23,25];
T.ser{46} = [21,23,25];

T.ser{111} = 21;
T.ser{112} = 21;
T.ser{129} = 21;
T.ser{130} = 21;

T.ser{51} = 26;
T.ser{52} = 26;
T.ser{33} = 26;
T.ser{34} = 26;

T.ser{98} = [22,24];
T.ser{99} =[22,24];
T.ser{116} = [22,24];
T.ser{117} =[22,24];

T.ser{100} = 25;
T.ser{101} = 25;
T.ser{118} = 25;
T.ser{119} = 25;

T.ser{105} = [23,26];
T.ser{106} = [23,26];
T.ser{123} = [23,26];
T.ser{124} = [23,26];



T.index = 2;

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


