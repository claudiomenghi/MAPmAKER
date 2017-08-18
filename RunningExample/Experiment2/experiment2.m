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

fid=fopen('resultsex1.txt','w');
fprintf(fid, 'experimentNumber initConf partConf #F \t #T \t Tr \t Lr \t STEP1_solution_found \t STEP2_solution_found \n');
experimentNumber=1;
         
initRobot1=15;
initRobot2=26;
initRobot3=17;

global actions;
actions={'recharge', 'r1loadbox1', 'r2loadbox1', 'r2unloadbox1', 'detectunloadingbox1', 'takeApicture'};

sys(1)=Robot1(environment.map, environment.pmap, initRobot1);
sys(2)=Robot2(environment.map, environment.pmap, initRobot2);
sys(3)=Robot3(environment.map, environment.pmap, initRobot3);


spec(1)=MissionRobot1(1, 1);
spec(2)=MissionRobot2(2, 3,  1, []);
spec(3)=MissionRobot3(4, 5,  1, []);


global offset;
global scale;
plotenabled=1;
maxIteration=10;

%% runs the step 1 of the evaluation
possiblesearchenabled=1;
videoName='Experiment2_RunningExample_Step1';
        

possiblesearchenabled=1;
[falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1]=mapmaker(sys, spec, environment, realenvironment, possiblesearchenabled, maxIteration, plotenabled,  offset, scale, videoName);

%% runs the step 2 of the evaluation

videoName='Experiment2_RunningExample_Step2';
possiblesearchenabled=0;
[falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1]=mapmaker(sys, spec, environment, realenvironment, possiblesearchenabled, maxIteration, plotenabled, offset, scale, videoName);


fclose(fid);