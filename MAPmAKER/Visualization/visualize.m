mfunction [grid, offset] = visualize(grid, sys, offset, spec, environment)
global blackvalue;
global scale;
global c;
global legendText;

N=length(sys);
for i=1:N
    fprintf('System %d, new current state %d, automaton state %d \n',sys(i).index, sys(i).curr, spec(i).curr);
    [xprevious,yprevious] = transform_coordinates(sys(i).previouscurr, environment.x, environment.y);
    [x,y]= transform_coordinates(sys(i).curr, environment.x, environment.y);
    grid((xprevious-1)*scale+scale/2+4+ offset(i):(x-1)*scale+scale/2+4+offset(i), (yprevious-1)*scale+scale/2+4+offset(i):(y-1)*scale+scale/2+4+offset(i)) = blackvalue;
    grid((x-1)*scale+scale/2+4+offset(i):(xprevious-1)*scale+scale/2+4+offset(i), (y-1)*scale+scale/2+4+offset(i):(yprevious-1)*scale+scale/2+4+offset(i)) = blackvalue;
    if sys(i).lastaction ~= 0
        grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = blackvalue;
    end
end

imshow(grid, c);
visualizeServices;
xlabel(legendText);
pause(3);
        
