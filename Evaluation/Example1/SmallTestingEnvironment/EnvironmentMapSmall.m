function E = EnvironmentMapSmall()


%Random value for the initial position of the robot
E.occupied=[];

y=3;
x=3;
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



%% possible map
E.pmap=E.map;

E.doors=ones(1,1);
E.doors_pos=zeros(1,1);

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

