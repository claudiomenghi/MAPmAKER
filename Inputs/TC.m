%create a transition system

function T = TC()

T.Q=[1:216];   %states
T.Pi=[31:36]; %all subsets of atomic propositions
T.curr = 186;    %initial state

%adjacency matrix
T.adj=sparse(216,216);
for i=1:216
    T.adj(i,i)=1;
end

%left-right
for k=0:11
    for i=(k*18+1):((k+1)*18-1)
        T.adj(i,i+1)=1;
    end
    for i = (k*18+2):((k+1)*18)
        T.adj(i,i-1)=1;
    end    
end

%up-down
for k=0:10
    for i=(k*18+1):((k+1)*18)
        T.adj(i,i+18)=1;
    end
end

for k=1:11
     for i=(k*18+1):((k+1)*18)
        T.adj(i,i-18)=1;
    end
end
    
T.adj(6,7)=0;
T.adj(7,6)=0;
T.adj(12,13)=0;
T.adj(13,12)=0;
for i=[1,4,5,6,7,10,11]
    T.adj(6+i*18,7+i*18)=0;
    T.adj(12+i*18,13+i*18)=0;
    T.adj(7+i*18,6+i*18)=0;
    T.adj(13+i*18,12+i*18)=0;
end


T.adj(145,127)=0;
T.adj(127,145)=0;
for i=[1,4,5]
    T.adj(145+i,127+i)=0;
    T.adj(127+i,145+i)=0;
end

T.adj(97,115)=0;
T.adj(115,97)=0;

for i=[1,4,5,6,7,10,11]
    T.adj(97+i,115+i)=0;
    T.adj(115+i,97+i)=0;
end

%observation == labeling function
for i=1:216
    T.ser{i}=[];
end


T.ser{43} = [32];
T.ser{61} = [32];
T.ser{48} = [32];
T.ser{66} = [32];
T.ser{99} = [32];
T.ser{100} = [32];

T.ser{49} = [33];
T.ser{67} = [33];
T.ser{105} = [33];
T.ser{106} = [33];

T.ser{123} = [34];
T.ser{124} = [34];
T.ser{157} = [34];
T.ser{175} = [34];

T.ser{117} = [35];
T.ser{118} = [35];
T.ser{156} = [35];
T.ser{174} = [35];
T.ser{151} = [35];
T.ser{169} = [35];

T.ser{150} = [36];
T.ser{168} = [36];
T.ser{148} = [36];
T.ser{149} = [36];

T.ser{58}=[31];

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


