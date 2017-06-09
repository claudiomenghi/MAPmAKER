%create a transition system

function T = TA()

T.Q=[1:216];   %states
T.Pi=[11:16]; %all subsets of atomic propositions
T.curr = 146;    %initial state

%adjacency matrix
T.adj=sparse(216,216);
for i=432
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

T.ser{45} = [11,13,15];
T.ser{46} = [11,13,15];
T.ser{63} = [11,13,15];
T.ser{64} = [11,13,15];

T.ser{51} = [10,16];
T.ser{52} = [10,16];
T.ser{69} = [10,16];
T.ser{70} = [10,16];

T.ser{165} = [11];
T.ser{166} = [11];
T.ser{183} = [11];
T.ser{184} = [11];

T.ser{171} = [10,15,12,14];
T.ser{172} = [10,15,12,14];
T.ser{189} = [10,15,12,14];
T.ser{190} = [10,15,12,14];

T.ser{177} = [13];
T.ser{178} = [13];
T.ser{195} = [13];
T.ser{196} = [13];

T.index = 1;

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


