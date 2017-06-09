function grid = visualizeInit(robotcolors, sys, offset, scale)
global whitevalue;
global blackvalue;


grid = ones(8*scale+1,18*scale+1)*whitevalue;
colors = zeros(8*scale+1,18*scale+1);
colorsadd = zeros(8*scale+1,18*scale+1);
N=length(sys);
% show the regions where services can be provided
for i=1:N
    ts=sys(i);
    servicelocation=find(~cellfun(@isempty, ts.ser));
    [x,y] =  transform_coordinates(servicelocation);
    sizex=size(x);
    for j=1:sizex(2)
        colors(x(j), y(j))=colors(x(j), y(j))+1;
    end
end

for i=1:N
    ts=sys(i);
    servicelocation=find(~cellfun(@isempty, ts.ser));
    [x,y] =  transform_coordinates(servicelocation);
    sizex=size(x);
    for j=1:sizex(2)
        if(colors(x(j), y(j))==1)
            grid((x(j)-1)*(scale)+1:(x(j))*scale,(y(j)-1)*scale+1:(y(j))*scale) = robotcolors(i); 
        else
            colorsize=scale/colors(x(j), y(j));
            colorstart=colorsize*colorsadd(x(j), y(j));
            grid((x(j)-1)*(scale)+1:(x(j))*scale,(y(j)-1)*scale+1+colorstart:(y(j))*scale+colorstart+colorsize) = robotcolors(i); 
            colorsadd(x(j), y(j))=colorsadd(x(j), y(j))+1;
        end
    end
end

%regions of interest for agent TA3
%for a = [105,106,123,124,27,28,45,46,111,112,129,130,51,52,33,34,98,99,116,117,100,101,118,119]
%    [x,y] = transform_coordinates(a);
%    grid((x-1)*(scale)+1:(x)*scale,(y-1)*scale+1:y*scale) = robotcolors(1); %0.427; %light green
%end

%regions of interest for TB1
%for a = [20,40,56,25,76]
%    [x,y] = transform_coordinates(a);
%    grid((x-1)*(scale)+1:(x)*scale,(y-1)*scale+1:y*scale) = robotcolors(2); %0.618; %light purple
%end


%grid lines
for i = 0:18
    for j = 1:8*scale+1
        grid(j, i*scale+1) = blackvalue;
    end
end

for j=0:8
    for i = 1:18*scale+1
        grid(j*scale+1,i) = blackvalue;
    end
end

%walls  left right
for a = [6,12,60,78,132,12+3*18]
    [x,y] = transform_coordinates(a);
    grid((x-1)*(scale)+1:(x)*scale,y*scale-1:y*scale+1) = blackvalue;
end

%walls  up down
for a = [91,91+1,91+4,91+5,79,80,83,84,85,86,89,90]
    [x,y] = transform_coordinates(a);
    grid((x)*(scale)-1:(x)*scale+1,(y-1)*scale+1:y*scale) = blackvalue;
end


for i=1:N
            color = robotcolors(i);
            [x,y]= transform_coordinates(sys(i).curr);
            grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;
end


c=colorcube(64);
imshow(grid, c);
pause(3)
