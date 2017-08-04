function [ grid ] = visualizeCurrentRobotPosition( sys, environment, grid, offset, scale)
%VISUALIZECURRENTROBOTPOSITION Summary of this function goes here
%   Detailed explanation goes here

global blackvalue;
global legendText;
global c;

%% displays the initial robot position
N=length(sys);
for m=1:N
    i=m;
    [x,y]= transform_coordinates(sys(i).curr, environment.x, environment.y);
    grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = blackvalue;
end

imshow(grid, c);
%xlabel(legendText)
visualizeServices(sys, offset, scale, grid, environment);
xlabel(legendText);

pause(0.5)


end

