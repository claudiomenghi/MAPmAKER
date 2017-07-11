
addpath('Visualization');
addpath('Utils');
addpath('Algorithms');

%% results
% contains the number of times a true evidence for a unknown info is
% detected
trueEvidenceCounter=0;

% contains the number of times a true evidence for a unknown info is
% detected
falseEvicenceCounter=0;

% contains the lenght of step 1
lengthStep1=0;
% contains the lenght of step 2
lengthStep2=0;

% contains the lenght of step 1
timeStep1=0;
% contains the lenght of step 2
timeStep2=0;


%% 
configParams;



% sets visualization constants, colors, cell dimensions etc
setVisualizationConstants;




%figure;
% Create a new figure
f = figure;
%F=getframe();
%movie(F);
%v=VideoWriter('movie.avi');
%v.FrameRate = 1;
%open(v);

% Set a size if desired
width = 800;
height = 600;
set(f,'Position',[15 15 width height])
% Change the renderer to avoid bugs due to OpenGL
set(f,'Renderer','ZBuffer')

grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
grid=visualizeGrid(grid, environment);
imshow(grid, c);
grid = visualizeInit(sys,  offset, scale, grid, environment);
visualizeServices;


step1(sys, spec,H, 50, 1, grid)
