% creates a transition system
% the grid is 18*8 = 144, labeled from bottom left to top right
% agent's state is its position in the grid

% the green guy from the paper

function T = TS1()

T.Q=[1:144];   %states, actions: self-loops have the name of the respective states
T.Pi=[31:36];  %all subsets of atomic propositions
T.curr = 91;   %initial state

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
T.adj(85,84) = 1;
T.adj(139,140)=1;
T.adj(140,139)=1;
%observation == labeling function
for i=1:144
    T.ser{i}=[];
end

T.ser{27} = [31,33,35]; %load A, load B, load C
T.ser{28} = [31,33,35];
T.ser{45} = [31,33,35];
T.ser{46} = [31,33,35];

T.ser{111} = [31]; %unload H, unload A, unload C
T.ser{112} = [31];
T.ser{129} = [31];
T.ser{130} = [31];

T.ser{51} = [36]; %unload B
T.ser{52} = [36];
T.ser{33} = [36];
T.ser{34} = [36];

T.ser{98} = [32,34]; %load H, load C
T.ser{99} =[32,34];
T.ser{116} = [32,34];
T.ser{117} =[32,34];

T.ser{100} = [35]; %load B
T.ser{101} = [35];
T.ser{118} = [35];
T.ser{119} = [35];

T.ser{105} = [33,36]; %load A, unload B
T.ser{106} = [33,36];
T.ser{123} = [33,36];
T.ser{124} = [33,36];