close all;
clear;


% creates the current scenario

%addpath('Inputs/Scenario1');
%createScenario1;

%addpath('Inputs/Scenario2');
%createScenario2;

%addpath('Inputs/Scenario3');
%createScenario3;

% addpath('Inputs/Scenario5');
% createScenario5;
addpath('Experiments/');
addpath('Inputs/Scenario3');
createScenario3;

addpath('Visualization');
addpath('Utils');
addpath('Algorithms');


configParams;



% sets visualization constants, colors, cell dimensions etc
setVisualizationConstants;

% addpath('Inputs/ScenarioRoboCup');
% createScenarioRoboCup;

%addpath('Inputs/ScenarioPaper');
%createScenarioPaper;



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
grid = visualizeInit(sys, offset, scale, grid, environment);
visualizeServices;

maxIteration=50;
plotenabled=1;
mapmaker(sys, spec, maxIteration, plotenabled, grid, environment, offset, scale);