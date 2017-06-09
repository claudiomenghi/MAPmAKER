%create a transition system

function T = TB3()

T.Q=[1:144];   %states
T.Pi=[31:37]; %all subsets of atomic propositions
T.curr = 21;    %initial state

%adjacency matrix
T.adj=sparse(144,144);
for i=144
    T.adj(i,i)=1;
end

%left-right
for k=0:7
    for i=(k*18+1):((k+1)*18-1)
        T.adj(i,i+1)=1;
    end
    for i = (k*18+2):((k+1)*18)
        T.adj(i,i-1)=1;
    end    
end

%up-down
for k=0:6
    for i=(k*18+1):((k+1)*18)
        T.adj(i,i+18)=1;
    end
end

for k=1:7
     for i=(k*18+1):((k+1)*18)
        T.adj(i,i-18)=1;
    end
end
    
T.adj(6,7)=0;
T.adj(7,6)=0;
T.adj(12,13)=0;
T.adj(13,12)=0;
for i=[3,4,7]
    T.adj(6+i*18,7+i*18)=0;
    T.adj(12+i*18,13+i*18)=0;
    T.adj(7+i*18,6+i*18)=0;
    T.adj(13+i*18,12+i*18)=0;
end

T.adj(73,91)=0;
T.adj(91,73)=0;

for i=[1,4,5]
    T.adj(73+i,91+i)=0;
    T.adj(91+i,73+i)=0;
end

T.adj(61,79)=0;
T.adj(79,61)=0;

for i=[1,4,5,6,7,10,11]
    T.adj(61+i,79+i)=0;
    T.adj(79+i,61+i)=0;
end

T.adj(84,85) = 1;
T.adj(85,85) = 1;
T.adj(138,139)=1;
T.adj(139,138)=1;


%observation == labeling function
for i=1:144
    T.ser{i}=[];
end

T.ser{27} = [32];
T.ser{28} = [32];
T.ser{45} = [32];
T.ser{46} = [32];

T.ser{111} = [31];
T.ser{112} = [31];
T.ser{129} = [31];
T.ser{130} = [31];

T.ser{20} = [33];
T.ser{40}= [34];
T.ser{56}= [35];
T.ser{24}=[37];
T.ser{60} = [38];
T.ser{76}=[36];

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


