function E = RealEnvironmentMap()
E.occupied=[];
y=7;
x=7;
size=x*y;
E.x=x;
E.y=y;
%adjacE.mapncy matrix
E.map=sparse(size,size);

for i=size
    E.map(i,i)=1;
end

E.map=sparse(size,size);
for i=size
    E.map(i,i)=1;
end

%lE.mapft-right
for k=0:x
    for i=(k*y+1):((k+1)*y-1)
        E.map(i,i+1)=1;
    end
    for i = (k*y+2):((k+1)*y)
        E.map(i,i-1)=1;
    end
end

%up-down
for k=0:x
    for i=(k*y+1):((k+1)*y)
        E.map(i,i+y)=1;
    end
end

for k=1:x
    for i=(k*y+1):((k+1)*y)
        E.map(i,i-y)=1;
    end
end


%Room right-bottom corner
E.map(5,6)=0;
E.map(6,5)=0;
E.map(14,21)=0;
E.map(21,14)=0;

%Room left-top corner
E.map(29,36)=0;
E.map(36,29)=0;
E.map(44,45)=0;
E.map(45,44)=0;

%Table in the middle
E.map(17,18)=0;
E.map(18,17)=0;
E.map(18,19)=0;
E.map(19,18)=0;
E.map(25,24)=0;
E.map(24,25)=0;
E.map(26,25)=0;
E.map(25,26)=0;
E.map(31,32)=0;
E.map(32,31)=0;
E.map(32,33)=0;
E.map(33,32)=0;
E.map(11,18)=0;
E.map(18,11)=0;
E.map(39,32)=0;
E.map(32,39)=0;

%Room right-bottom corner
% E.map(12,13)=1;
% E.map(13,12)=1;
% E.map(13,20)=1;
% E.map(20,13)=1;
%Room left-top corner
E.map(30,37)=0;
E.map(37,30)=0;
E.map(37,38)=1;
E.map(38,37)=1;




end

