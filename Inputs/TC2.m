%creates a transition system
%the grid is 18*8 = 144
%agent's state is just its position in the grid

%the blue guy

function T = TC2()

T.Q=[1:144];   %states
T.Pi=[21:24]; %all subsets of atomic propositions
%T.curr=48;
T.curr = 18;    %initial state

%adjacency matrix
T.adj=sparse(144,144);
for i=1:144
    T.adj(i,i)=1;
end

%left-right
for k=0:7
    for i=(k*18+1):((k+1)*18-1)
        T.adj(i,i+1)=100;
    end
    for i = (k*18+2):((k+1)*18)
        T.adj(i,i-1)=100;
    end    
end

%up-down
for k=0:6
    for i=(k*18+1):((k+1)*18)
        T.adj(i,i+18)=100;
    end
end

for k=1:7
     for i=(k*18+1):((k+1)*18)
        T.adj(i,i-18)=100;
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

T.adj(84,85) = 100;
T.adj(85,84) = 100;
T.adj(139,140)=100;
T.adj(140,139)=100;


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




