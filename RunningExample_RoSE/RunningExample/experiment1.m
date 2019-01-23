close all;
clear;

% creates the current scenario
addpath('Visualization');
addpath('Utils');
addpath('Algorithms');

configParams;

% sets visualization constants, colors, cell dimensions etc
setVisualizationConstants;

%% preparing the input for the experiments
numberOfInitialConfigurations=3;
numberOfPartialInfoConfigurations=3;

environment=EnvironmentMap();
realenvironment=RealEnvironmentMap();

%% running the experiment

fid=fopen('results_rose.txt','w');
fprintf(fid, 'experimentNumber initConf partConf #F \t #T \t Tr \t Lr \t STEP1_solution_found \t STEP2_solution_found \n');
experimentNumber=1;
         
initRobot1=1;
initRobot2=47;
initRobot3=6;

global actions;
actions={'help_grasping', 'fetch_supplies', 'deliver', 'take_snapshot', 'send_info'};

sys(1)=Robot1(environment.map, environment.pmap, initRobot1);
sys(2)=Robot2(environment.map, environment.pmap, initRobot2);
sys(3)=Robot3(environment.map, environment.pmap, initRobot3);


spec(1)=MissionRobot1(1, []);
spec(2)=MissionRobot2(2, 3,  2, []);
spec(3)=MissionRobot3(4, 5,  1, []);

global currFrame_i;
global offset;
global scale;
global whitevalue;
global c;
plotenabled=1;

%figure;
% Create a new figure
% Set a size if desired
width = 800;
height = 600;



maxIteration=10;

%% runs the step 1 of the evaluation

possiblesearchenabled=1;
[falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1]=mapmaker(sys, spec, environment, realenvironment, possiblesearchenabled, maxIteration, plotenabled,  offset, scale, 'movie_RunningExampleRoSE_Step1');

%% runs the step 2 of the evaluation


possiblesearchenabled=0;
[falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1]=mapmaker(sys, spec, environment, realenvironment, possiblesearchenabled, maxIteration, plotenabled, offset, scale, 'movie_RunningExampleRoSE_Step2');

fclose(fid);