function E = EnvironmentMap()

y=13;
x=13;
size=x*y;
E.x=x;
E.y=y;
size=x*y;
E.map=sparse(size,size);

%% Create the map as a canvas
for i=x*y
    E.map(i,i)=1;
end
%lE.mapft-right
for k=0:(x-1)
    for i=(k*y+1):((k+1)*y-1)
        E.map(i,i+1)=1;
    end
    for i = (k*y+2):((k+1)*y)
        E.map(i,i-1)=1;
    end
end

%up-down
for k=0:(x-2)
    for i=(k*y+1):((k+1)*y)
        E.map(i,i+y)=1;
    end
end

for k=1:(x-1)
    for i=(k*y+1):((k+1)*y)
        E.map(i,i-y)=1;
    end
end

%% Set walls

%Hallway
for i=[1,3,4,5,6,8,10]
    E.map(i+y*(3+1),i+y*3)=0;
    E.map(i+y*3,i+y*(3+1))=0;
end

for i=[0,1,3]
    E.map(5+i*y,6+i*y)=0;
    E.map(6+i*y,5+i*y)=0;
end

for i=[2,3]
    E.map(1+i*y,2+i*y)=0;
    E.map(2+i*y,1+i*y)=0;
end
E.map(1+1*y,1+2*y)=0;
E.map(1+2*y,1+1*y)=0;

E.map(5+3*y,5+2*y)=0;
E.map(5+2*y,5+3*y)=0;
E.map(4+y*3,5+y*3)=0;
E.map(5+y*3,4+y*3)=0;

%Kitchen

for i=[1,3,4,5,10,11,12,13]
    E.map(i+y*(5+1),i+y*5)=0;
    E.map(i+y*5,i+y*(5+1))=0;
end
for i=11:12
    E.map(i+y*(4+1),i+y*4)=0;
    E.map(i+y*4,i+y*(4+1))=0;
end
for i=9:x
    E.map(i+y*(0+1),i+y*0)=0;
    E.map(i+y*0,i+y*(0+1))=0;
end

E.map(10+y*(1+1),10+y*1)=0;
E.map(10+y*1,10+y*(1+1))=0;

for i=[2,3]
    E.map(9+i*y,10+i*y)=0;
    E.map(10+i*y,9+i*y)=0;
end
for i=[2,3]
    E.map(10+i*y,11+i*y)=0;
    E.map(11+i*y,10+i*y)=0;
end

for i=[4,5,7,8,9,10,11,12,13]
    E.map(8+i*y,9+i*y)=0;
    E.map(9+i*y,8+i*y)=0;
end

E.map(9+0*y,8+0*y)=0;
E.map(8+0*y,9+0*y)=0;
E.map(11+5*y,10+5*y)=0;
E.map(10+5*y,11+5*y)=0;
E.map(12+5*y,13+5*y)=0;
E.map(13+5*y,12+5*y)=0;

for i=[2,3,4]
    E.map(12+i*y,13+i*y)=0;
    E.map(13+i*y,12+i*y)=0;
end

%Bedroom
for i=11:12
    E.map(i+y*(6+1),i+y*6)=0;
    E.map(i+y*6,i+y*(6+1))=0;
end
E.map(11+6*y,10+6*y)=0;
E.map(10+6*y,11+6*y)=0;
E.map(12+6*y,13+6*y)=0;
E.map(13+6*y,12+6*y)=0;

for i=10:11
    E.map(i+y*(9+1),i+y*9)=0;
    E.map(i+y*9,i+y*(9+1))=0;
end
for i=10:12
    E.map(9+y*i,10+y*i)=0;
    E.map(10+y*i,9+y*i)=0;
end
for i=10:12
    E.map(11+y*i,12+y*i)=0;
    E.map(12+y*i,11+y*i)=0;
end

%Living room
for i=3:5
    E.map(i+y*(6+1),i+y*6)=0;
    E.map(i+y*6,i+y*(6+1))=0;
end
E.map(2+6*y,3+6*y)=0;
E.map(3+6*y,2+6*y)=0;
E.map(5+6*y,6+6*y)=0;
E.map(6+6*y,5+6*y)=0;

E.map(1+6*y,2+6*y)=0;
E.map(2+6*y,1+6*y)=0;
E.map(1+6*y,1+7*y)=0;
E.map(1+7*y,1+6*y)=0;

E.map(3+12*y,4+12*y)=0;
E.map(4+12*y,3+12*y)=0;
E.map(7+12*y,8+12*y)=0;
E.map(8+12*y,7+12*y)=0;
for i=4:7
    E.map(i+y*(11+1),i+y*11)=0;
    E.map(i+y*11,i+y*(11+1))=0;
end

for i=5:6
    E.map(i+y*(9+1),i+y*9)=0;
    E.map(i+y*9,i+y*(9+1))=0;
end
for i=5:6
    E.map(i+y*(10+1),i+y*10)=0;
    E.map(i+y*10,i+y*(10+1))=0;
end
E.map(5+10*y,4+10*y)=0;
E.map(4+10*y,5+10*y)=0;
E.map(6+10*y,7+10*y)=0;
E.map(7+10*y,6+10*y)=0;

for i=8:10
    E.map(7+y*i,8+y*i)=0;
    E.map(8+y*i,7+y*i)=0;
end
E.map(8+7*y,8+8*y)=0;
E.map(8+8*y,8+7*y)=0;
E.map(8+10*y,8+11*y)=0;
E.map(8+11*y,8+10*y)=0;

E.map(2+10*y,2+11*y)=0;
E.map(2+11*y,2+10*y)=0;
E.map(2+10*y,2+9*y)=0;
E.map(2+9*y,2+10*y)=0;
E.map(1+10*y,2+10*y)=0;
E.map(2+10*y,1+10*y)=0;
E.map(3+10*y,2+10*y)=0;
E.map(2+10*y,3+10*y)=0;

%% possible map
E.pmap=E.map;
E.pmap(75,93)=1;
E.pmap(93, 75)=1;
E.pmap(6, 7)=1;
E.pmap(7, 6)=1;
E.pmap(96,97) = 1;
E.pmap(64, 82)=1;

E.pmap(82, 64)=1;


end

