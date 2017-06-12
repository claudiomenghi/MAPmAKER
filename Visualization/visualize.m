function [grid, offset] = visualize(grid, robotcolors, sys, offset, scale, spec, environment)
global blackvalue;

c=colorcube(64);
N=length(sys);
for i=1:N
    fprintf('System %d, new current state %d, automaton state %d \n',sys(i).index, sys(i).curr, spec(i).curr);
    [xprevious,yprevious] = transform_coordinates(sys(i).previouscurr);
[x,y]= transform_coordinates(sys(i).curr);
color = robotcolors(i);
 grid((xprevious-1)*scale+scale/2+4+ offset(i):(x-1)*scale+scale/2+4+offset(i), (yprevious-1)*scale+scale/2+4+offset(i):(y-1)*scale+scale/2+4+offset(i)) = blackvalue;
            grid((x-1)*scale+scale/2+4+offset(i):(xprevious-1)*scale+scale/2+4+offset(i), (y-1)*scale+scale/2+4+offset(i):(yprevious-1)*scale+scale/2+4+offset(i)) = blackvalue;
            if sys(i).lastaction ~= 0
                grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;
                if ((i==1) || (i==3))
                    offset(i) = offset(i) + 2;
                else
                    offset(i) = offset(i) - 2;
                end
            end
end

grid=visualizeGrid(scale, grid, environment);
imshow(grid, c)
%pause(3)
        
