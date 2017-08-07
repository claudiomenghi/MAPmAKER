function E = EnvironmentMap()
E.occupied=[];
y=18;
x=8;
size=x*y;
E.x=x;
E.y=y;
%adjacE.mapncy matrix
E.map=sparse(size,size);
for i=144
    E.map(i,i)=1;
end

%lE.mapft-right
for k=0:7
    for i=(k*18+1):((k+1)*18-1)
        E.map(i,i+1)=1;
    end
    for i = (k*18+2):((k+1)*18)
        E.map(i,i-1)=1;
    end
end

%up-down
for k=0:6
    for i=(k*18+1):((k+1)*18)
        E.map(i,i+18)=1;
    end
end

for k=1:7
    for i=(k*18+1):((k+1)*18)
        E.map(i,i-18)=1;
    end
end

E.map(6,7)=0;
E.map(7,6)=0;
E.map(24,25)=0;
E.map(25,24)=0;
E.map(42,43)=0;
E.map(43,42)=0;

E.map(12,13)=0;
E.map(13,12)=0;
for i=[3,4,7]
    E.map(6+i*18,7+i*18)=0;
    E.map(12+i*18,13+i*18)=0;
    E.map(7+i*18,6+i*18)=0;
    E.map(13+i*18,12+i*18)=0;
end

E.map(73,91)=0;
E.map(91,73)=0;



for i=[1,2,3,4,5]
    E.map(73+i,91+i)=0;
    E.map(91+i,73+i)=0;
end

E.map(61,79)=0;
E.map(79,61)=0;

for i=[1,4,5,6,7,10,11]
    E.map(61+i,79+i)=0;
    E.map(79+i,61+i)=0;
end

E.map(114,115) = 0;
E.map(115,114) = 0;
E.map(96,97) = 0;
E.map(97,96) = 0;
E.map(84,85) = 1;
E.map(85,85) = 1;
E.map(138,139)=1;
E.map(139,138)=1;
E.map(6, 7)=1;
E.map(7, 6)=1;

E.map(75,93)=1;
E.map(93, 75)=1;
E.map(6, 7)=1;
E.map(7, 6)=1;
E.map(63, 81)=0;
E.map(64, 82)=0;
E.map(81, 63)=0;
E.map(82, 64)=0;

%E.map(75,93)=0;
%E.map(93,75)=0;

% possible map
E.pmap=E.map;

%Random value for the uncertainty of the environment's doors
E.doors=ones(4,1);
E.doors_pos=zeros(4,2);

for i=1:length(E.doors)
    E.doors(i,1)=round(rand);
    switch i
        case 1
            if E.doors(i,1) == 0
                E.map(3+5*y,3+4*y)=0;
                E.map(3+4*y,3+5*y)=0;
                E.pmap(3+5*y,3+4*y)=1;
                E.pmap(3+4*y,3+5*y)=1;
            end
            E.doors_pos(i,1)=3+4*y;
            E.doors_pos(i,2)=3+5*y;
        case 2
            if E.doors(i,1) == 0
                E.map(6+4*y,7+6*y)=0;
                E.map(7+5*y,6+6*y)=0;
                E.pmap(6+4*y,7+6*y)=1;
                E.pmap(7+5*y,6+6*y)=1;
            end
            E.doors_pos(i,1)=6+6*y;
            E.doors_pos(i,2)=7+6*y;
        case 3
            if E.doors(i,1) == 0
                E.map(6,7)=0;
                E.map(7,6)=0;
                E.pmap(6,7)=1;
                E.pmap(7,6)=1;
            end
            E.doors_pos(i,1)=6;
            E.doors_pos(i,2)=7;
        case 4
            if E.doors(i,1) == 0
                E.map(10+3*y,10+4*y)=0;
                E.map(10+4*y,10+3*y)=0;
                E.pmap(10+3*y,10+4*y)=1;
                E.pmap(10+4*y,10+3*y)=1;
            end
            E.doors_pos(i,1)=10+4*y;
            E.doors_pos(i,2)=10+3*y;
    end
end


end

