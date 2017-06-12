function grid = visualizeInit(robotcolors, sys, offset, scale, grid, environment)
global blackvalue;



colors = zeros(environment.x*scale+1,environment.y*scale+1);
colorsadd = zeros(environment.x*scale+1,environment.y*scale+1);
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


%grid lines
for i = 0:environment.y
    for j = 1:environment.x*scale+1
        grid(j, i*scale+1) = blackvalue;
    end
end

for j=0:environment.x
    for i = 1:environment.y*scale+1
        grid(j*scale+1,i) = blackvalue;
    end
end

grid=visualizeGrid(scale, grid, environment);

for i=1:N
            color = robotcolors(i);
            [x,y]= transform_coordinates(sys(i).curr);
            grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;
end


c=colorcube(64);
imshow(grid, c);
pause(3)
