function E = EnvironmentMap_Sergio(x, y, nrooms, ndoors, lroom)
% It generates a random scenario based on:
% x -> length of the map
% y -> width of the map
% nrooms -> number of rooms
% ndoors -> number of doors per room
% lroom -> lenght of the room (always squares) -> not implemented yet

% x=8;
% y=30;
% nrooms=6;
% lroom=3;
% ndoors=4;

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

%% Create the rooms

% I generate random centers locations for each room
room=zeros(nrooms, 2);
distance_loop=zeros(nrooms, 1);
for i=1:nrooms
    %Centers generated in the whole space
    %     room(i,1)=round(1+(x-1).*rand);
    %     room(i,2)=round(1+(y-1).*rand);
    %Centers generated so the rooms fit in the given space following the
    %next formula: r = a + (b-a).*rand(100,1);
    distance=0;
    if i > 1
        while distance < sqrt(13)
            room(i,1)=round(3+(x-2-3).*rand);
            room(i,2)=round(3+(y-2-3).*rand);
            for j=1:(i-1)
                distance_loop(j)=sqrt((room(i,1)-room(j,1))^2 + (room(i,2)-room(j,2))^2);
            end
            distance=min(distance_loop(1:j));
        end
    else
        room(i,1)=round(3+(x-2-3).*rand);
        room(i,2)=round(3+(y-2-3).*rand);
    end
    
end
%I'll generate the positions of the centers manually to test
% room(1,1)=2;
% room(1,2)=12;
% room(2,1)=5;
% room(2,2)=14;
% room(3,1)=2;
% room(3,2)=6;
% room(4,1)=6;
% room(4,2)=16;

room
% Set to 0 the walls of the rooms
doorpos=zeros(ndoors,1);
for i=1:nrooms
    door=0;
    for j=1:lroom
        %right wall
        E.map(room(i,2)+(room(i,1)-1)*y+2,room(i,2)+(room(i,1)-1)*y+1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+1,room(i,2)+(room(i,1)-1)*y+2)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+2+y,room(i,2)+(room(i,1)-1)*y+1+y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+1+y,room(i,2)+(room(i,1)-1)*y+2+y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+2-y,room(i,2)+(room(i,1)-1)*y+1-y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+1-y,room(i,2)+(room(i,1)-1)*y+2-y)=0;
        %upper wall
        E.map(room(i,2)+(room(i,1)-1)*y+2*y,room(i,2)+(room(i,1)-1)*y+y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+y,room(i,2)+(room(i,1)-1)*y+2*y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+2*y-1,room(i,2)+(room(i,1)-1)*y+y-1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+y-1,room(i,2)+(room(i,1)-1)*y+2*y-1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+2*y+1,room(i,2)+(room(i,1)-1)*y+y+1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y+y+1,room(i,2)+(room(i,1)-1)*y+2*y+1)=0;
        %lower wall
        E.map(room(i,2)+(room(i,1)-1)*y-2*y,room(i,2)+(room(i,1)-1)*y-y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-y,room(i,2)+(room(i,1)-1)*y-2*y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-2*y-1,room(i,2)+(room(i,1)-1)*y-y-1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-y-1,room(i,2)+(room(i,1)-1)*y-2*y-1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-2*y+1,room(i,2)+(room(i,1)-1)*y-y+1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-y+1,room(i,2)+(room(i,1)-1)*y-2*y+1)=0;
        %left wall
        E.map(room(i,2)+(room(i,1)-1)*y-2,room(i,2)+(room(i,1)-1)*y-1)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-1,room(i,2)+(room(i,1)-1)*y-2)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-2+y,room(i,2)+(room(i,1)-1)*y-1+y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-1+y,room(i,2)+(room(i,1)-1)*y-2+y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-2-y,room(i,2)+(room(i,1)-1)*y-1-y)=0;
        E.map(room(i,2)+(room(i,1)-1)*y-1-y,room(i,2)+(room(i,1)-1)*y-2-y)=0;
        
        %Randomly allocates the door
        for n=1:ndoors
            %makes sure the position of the door is not overlapped
            dif=0;
            while  dif==0
                doorpos_aux=round(1 + (lroom*4-1).*rand);
                for s=1:n
                    next=0;
                    if isequal(doorpos_aux, doorpos(s,1)) == 1
                        break
                    else
                        next=1;
                    end
                end
                if next==1
                    dif=1;
                end
            end
            doorpos(n,1) = doorpos_aux;
            
            switch doorpos(n,1)
                case 1
                    E.map(room(i,2)+(room(i,1)-1)*y+2,room(i,2)+(room(i,1)-1)*y+1)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y+1,room(i,2)+(room(i,1)-1)*y+2)=1;
                case 2
                    E.map(room(i,2)+(room(i,1)-1)*y+2+y,room(i,2)+(room(i,1)-1)*y+1+y)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y+1+y,room(i,2)+(room(i,1)-1)*y+2+y)=1;
                case 3
                    E.map(room(i,2)+(room(i,1)-1)*y+2-y,room(i,2)+(room(i,1)-1)*y+1-y)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y+1-y,room(i,2)+(room(i,1)-1)*y+2-y)=1;
                case 4
                    E.map(room(i,2)+(room(i,1)-1)*y+2*y,room(i,2)+(room(i,1)-1)*y+y)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y+y,room(i,2)+(room(i,1)-1)*y+2*y)=1;
                case 5
                    E.map(room(i,2)+(room(i,1)-1)*y+2*y-1,room(i,2)+(room(i,1)-1)*y+y-1)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y+y-1,room(i,2)+(room(i,1)-1)*y+2*y-1)=1;
                case 6
                    E.map(room(i,2)+(room(i,1)-1)*y+2*y+1,room(i,2)+(room(i,1)-1)*y+y+1)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y+y+1,room(i,2)+(room(i,1)-1)*y+2*y+1)=1;
                case 7
                    E.map(room(i,2)+(room(i,1)-1)*y-2*y,room(i,2)+(room(i,1)-1)*y-y)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y-y,room(i,2)+(room(i,1)-1)*y-2*y)=1;
                case 8
                    E.map(room(i,2)+(room(i,1)-1)*y-2*y-1,room(i,2)+(room(i,1)-1)*y-y-1)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y-y-1,room(i,2)+(room(i,1)-1)*y-2*y-1)=1;
                case 9
                    E.map(room(i,2)+(room(i,1)-1)*y-2*y+1,room(i,2)+(room(i,1)-1)*y-y+1)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y-y+1,room(i,2)+(room(i,1)-1)*y-2*y+1)=1;
                case 10
                    E.map(room(i,2)+(room(i,1)-1)*y-2,room(i,2)+(room(i,1)-1)*y-1)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y-1,room(i,2)+(room(i,1)-1)*y-2)=1;
                case 11
                    E.map(room(i,2)+(room(i,1)-1)*y-2+y,room(i,2)+(room(i,1)-1)*y-1+y)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y-1+y,room(i,2)+(room(i,1)-1)*y-2+y)=1;
                case 12
                    E.map(room(i,2)+(room(i,1)-1)*y-2-y,room(i,2)+(room(i,1)-1)*y-1-y)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y-1-y,room(i,2)+(room(i,1)-1)*y-2-y)=1;
                otherwise
                    E.map(room(i,2)+(room(i,1)-1)*y+2,room(i,2)+(room(i,1)-1)*y+1)=1;
                    E.map(room(i,2)+(room(i,1)-1)*y+1,room(i,2)+(room(i,1)-1)*y+2)=1;
            end
        end
    end
end

end


