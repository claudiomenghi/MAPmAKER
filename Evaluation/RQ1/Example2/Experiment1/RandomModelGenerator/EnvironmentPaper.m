function E = EnvironmentMap()


%Random value for the initial position of the robot
E.occupied=[4 9 11 12 18 21:23 41:43 46 55:57 60 63 64 69 70 74 81:84 ...
    95:98 108:112 114 115 122:129 134:140 141:143 146 148:154 155:157 160 ...
    162:168 169:171 176:182 183:185 191:196 197:199 105:210 211 212 219:224];

y=14;
x=16;
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

%Low right walls
for i=[3,4]
    E.map(1+i*y,2+i*y)=0;
    E.map(2+i*y,1+i*y)=0;
end

for i=[0,1,2,3,4]
    E.map(3+i*y,4+i*y)=0;
    E.map(4+i*y,3+i*y)=0;
end

for i=[0,1,2,3,4]
    E.map(4+i*y,5+i*y)=0;
    E.map(5+i*y,4+i*y)=0;
end

for i=[0,1,2,4]
    E.map(8+i*y,9+i*y)=0;
    E.map(9+i*y,8+i*y)=0;
end

for i=[0,1]
    E.map(10+i*y,9+i*y)=0;
    E.map(9+i*y,10+i*y)=0;
end

E.map(6+4*y,7+4*y)=0;
E.map(7+4*y,6+4*y)=0;

%Low upper and bottom walls
E.map(1+y*(4+1),1+y*4)=0;
E.map(1+y*4,1+y*(4+1))=0;

E.map(1+y*(2+1),1+y*2)=0;
E.map(1+y*2,1+y*(2+1))=0;

for i=[3,4,5]
    E.map(i+y*(4+1),i+y*4)=0;
    E.map(i+y*4,i+y*(4+1))=0;
end

for i=[7,8]
    E.map(i+y*(4+1),i+y*4)=0;
    E.map(i+y*4,i+y*(4+1))=0;
end

for i=[7,8]
    E.map(i+y*(4+1),i+y*4)=0;
    E.map(i+y*4,i+y*(4+1))=0;
end

for i=[7,8]
    E.map(i+y*(3+1),i+y*3)=0;
    E.map(i+y*3,i+y*(3+1))=0;
end

E.map(9+y*(1+1),9+y*1)=0;
E.map(9+y*1,9+y*(1+1))=0;

for i=[10,11,12,13,14]
    E.map(i+y*(4+1),i+y*4)=0;
    E.map(i+y*4,i+y*(4+1))=0;
end

%Upper right & left walls
for i=[5,6]
    E.map(10+i*y,11+i*y)=0;
    E.map(11+i*y,10+i*y)=0;
end

for i=7:x
    E.map(8+i*y,9+i*y)=0;
    E.map(9+i*y,8+i*y)=0;
end

for i=8:x
    E.map(2+i*y,3+i*y)=0;
    E.map(2+i*y,3+i*y)=0;
end

E.map(1+8*y,2+8*y)=0;
E.map(2+8*y,1+8*y)=0;

%Upper upper & bottom walls
E.map(1+y*(8+1),1+y*8)=0;
E.map(1+y*8,1+y*(8+1))=0;

E.map(2+y*(7+1),2+y*7)=0;
E.map(2+y*7,2+y*(7+1))=0;

for i=[9,10]
    E.map(i+y*(6+1),i+y*6)=0;
    E.map(i+y*6,i+y*(6+1))=0;
end

%Objects room bottom-left

%Objects room bottom-center
for i=[7,8]
    E.map(i+y*(0+1),i+y*0)=0;
    E.map(i+y*0,i+y*(0+1))=0;
    
    E.map(i+y*(1+1),i+y*1)=0;
    E.map(i+y*1,i+y*(1+1))=0;
end

E.map(6+1*y,7+1*y)=0;
E.map(7+1*y,6+1*y)=0;

%Objects room bottom-right

for i=[11,12]
    E.map(i+y*(0+1),i+y*0)=0;
    E.map(i+y*0,i+y*(0+1))=0;
end

E.map(10+0*y,11+0*y)=0;
E.map(11+0*y,10+0*y)=0;

E.map(12+0*y,13+0*y)=0;
E.map(13+0*y,12+0*y)=0;

for i=[2,3,4]
    E.map(12+i*y,13+i*y)=0;
    E.map(13+i*y,12+i*y)=0;
end

for i=[13,14]
    E.map(i+y*(1+1),i+y*1)=0;
    E.map(i+y*1,i+y*(1+1))=0;
end

%Objects room big
E.map(3+5*y,4+5*y)=0;
E.map(4+5*y,3+5*y)=0;
E.map(4+5*y,5+5*y)=0;
E.map(5+5*y,4+5*y)=0;
E.map(4+5*y,4+6*y)=0;
E.map(4+6*y,4+5*y)=0;

for i=[8,9,10,11,12,13]
    E.map(3+y*i,4+y*i)=0;
    E.map(4+y*i,3+y*i)=0;
end
E.map(3+7*y,3+8*y)=0;
E.map(3+8*y,3+7*y)=0;
E.map(3+13*y,3+14*y)=0;
E.map(3+14*y,3+13*y)=0;

for i=[9,10,11,12]
    E.map(7+y*i,8+y*i)=0;
    E.map(8+y*i,7+y*i)=0;
end
E.map(8+8*y,8+9*y)=0;
E.map(8+9*y,8+8*y)=0;
E.map(8+12*y,8+13*y)=0;
E.map(8+13*y,8+12*y)=0;

for i=[10,11]
    E.map(5+y*i,6+y*i)=0;
    E.map(6+y*i,5+y*i)=0;
    
    E.map(6+y*i,7+y*i)=0;
    E.map(7+y*i,6+y*i)=0;
end
E.map(6+9*y,6+10*y)=0;
E.map(6+10*y,6+9*y)=0;
E.map(6+11*y,6+12*y)=0;
E.map(6+12*y,6+11*y)=0;



%% possible map
E.pmap=E.map;


end

