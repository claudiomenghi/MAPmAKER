function E = EnvironmentMap2()

%adjacency matrix
E=sparse(144,144);
for i=144
    E(i,i)=1;
end

%left-right
for k=0:7
    for i=(k*18+1):((k+1)*18-1)
        E(i,i+1)=1;
    end
    for i = (k*18+2):((k+1)*18)
        E(i,i-1)=1;
    end    
end

%up-down
for k=0:6
    for i=(k*18+1):((k+1)*18)
        E(i,i+18)=1;
    end
end

for k=1:7
     for i=(k*18+1):((k+1)*18)
        E(i,i-18)=1;
    end
end
    
E(6,7)=0;
E(7,6)=0;
E(12,13)=0;
E(13,12)=0;
for i=[3,4,7]
    E(6+i*18,7+i*18)=0;
    E(12+i*18,13+i*18)=0;
    E(7+i*18,6+i*18)=0;
    E(13+i*18,12+i*18)=0;
end

E(73,91)=0;
E(91,73)=0;

for i=[1,4,5]
    E(73+i,91+i)=0;
    E(91+i,73+i)=0;
end

E(61,79)=0;
E(79,61)=0;

for i=[1,4,5,6,7,10,11]
    E(61+i,79+i)=0;
    E(79+i,61+i)=0;
end

E(84,85) = 1;
E(85,85) = 1;
E(138,139)=1;
E(139,138)=1;



end

