% grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
% hh=figure;
% grid=visualizeGrid(grid, environment);
% imshow(grid, c);
% grid = visualizeInit(sys, offset, scale, grid, environment);
% visualizeServices;

%figure(); imshow(grid, c);
 
x=18;
y=8;
nrooms=2;
ndoors=2;
lroom=3;
%function E = EnvironmentMap_Sergio(x, y, nrooms, ndoors, lroom)
%sergio=RandomEnvironmentMap_Sergio(x, y, nrooms, ndoors, lroom);
sergio=RandomEnvironmentMap_Sergio_xycorrected(x, y, nrooms, ndoors, lroom);
%grid = ones(sergio.x*scale+1,sergio.y*scale+1)*whitevalue;
grid = ones(sergio.y*scale+1,sergio.x*scale+1)*whitevalue;
hh=figure;
%grid=visualizeGrid(grid, sergio);
grid=visualizeGrid_xycorrected(grid, sergio);
figure(); imshow(grid, c);
xlabel('x'); ylabel('y');
