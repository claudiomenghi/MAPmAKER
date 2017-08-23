function [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1, planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep1, performedpathstep2]= experimentRunner(sys, spec, environment, realenvironment, experimentNumber)

function [timeout1, timeout2, falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1, planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep1, performedpathstep2]= experimentRunner(sys, spec, environment, realenvironment, timeoutval, experimentNumber)

global offset;
global scale;
global whitevalue;
global c;

plotenabled=1;

% Set a size if desired
width = 800;
height = 600;
global f;
f = figure('Position',[15 15 width height]);
set(f,'Position',[15 15 width height])
% Change the renderer to avoid bugs due to OpenGL
%set(f,'Renderer','ZBuffer')

if(plotenabled==1)
grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
grid=visualizeGrid(grid, environment);
imshow(grid, c,'InitialMagnification','fit');
grid = visualizeInit(sys, offset, scale, grid, environment);
visualizeServices(sys, offset, scale, grid, environment);
else
grid=[];
end

set(f,'Position',[15 15 width height]);
% Change the renderer to avoid bugs due to OpenGL
set(f,'Renderer','ZBuffer')

maxIteration=10;

%% runs the step 1 of the evaluation
possiblesearchenabled=1;

sys1=sys;
spec1=spec;
environment1=environment;
realenvironment1=realenvironment;

video_name=sprintf('movie_%d_Step1', experimentNumber);
        [timeout1, falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1, performedpathstep1]=mapmakerRQ2(sys, spec, environment, realenvironment, possiblesearchenabled, plotenabled, grid,  offset, scale, 1, timeoutval, video_name);

%% runs the step 2 of the evaluation

f = figure('Position',[15 15 width height]);
if(plotenabled==1)
grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
grid=visualizeGrid(grid, environment);
imshow(grid, c);
grid = visualizeInit(sys, offset, scale, grid, environment);
grid = visualizeServices(sys, offset, scale, grid, environment);
else
grid=[];
end

%possiblesearchenabled=0;
video_name=sprintf('movie_%d_Step2', experimentNumber);
[timeout2, falseEvicenceCounterstep2, trueEvidenceCounterstep2, planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep2]=mapmakerRQ2(sys1, spec1, environment1, realenvironment1, possiblesearchenabled, plotenabled, grid,  offset, scale, 0, timeoutval, video_name);


end
