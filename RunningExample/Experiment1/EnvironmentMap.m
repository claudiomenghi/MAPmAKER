function E = EnvironmentMap()
E.occupied=[];
y=6;
x=5;
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



E.map(13,19)=0;
E.map(19,13)=0;
E.map(15,21)=0;
E.map(21,15)=0;
E.map(16,22)=0;
E.map(22,16)=0;
E.map(22,23)=0;
E.map(23,22)=0;
E.map(18,24)=0;
E.map(24,18)=0;
E.map(22,23)=0;
E.map(23,22)=0;
E.map(4,5)=0;
E.map(5,4)=0;
%E.map(11,5)=0;
%E.map(5,11)=0;
%E.map(12,6)=0;
%E.map(6,12)=0;
E.map(10,11)=0;
E.map(11,10)=0;
E.map(10,11)=0;
E.map(11,10)=0;

E.map(8,7)=0;
E.map(7,8)=0;
E.map(8,14)=0;
E.map(14,8)=0;
E.map(8,2)=0;
E.map(2,8)=0;
E.map(8,9)=0;
E.map(9,8)=0;

E.map(20,14)=0;
E.map(14,20)=0;

% possible map
E.pmap=E.map;
E.pmap(20,14)=1;
E.pmap(14,20)=1;
end

