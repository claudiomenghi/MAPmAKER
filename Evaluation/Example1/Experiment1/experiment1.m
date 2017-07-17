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

%environment=EnvironmentMapPaper();

for initNumber=1:numberOfInitialConfigurations
    initRobot1Positions(initNumber)=getRandomInitPosition(environment);
    %initRobot1Positions(initNumber)=1;
    initRobot2Positions(initNumber)=getRandomInitPosition(environment);
end


for partialInfoNumber=1:numberOfPartialInfoConfigurations
    testenvironments(partialInfoNumber)=EnvironmentMapPaper();
end


%% running the experiment

fid=fopen('resultsex1.txt','w');
fprintf(fid, 'experimentNumber initConf partConf #F \t #T \t Tr \t Lr \t STEP1_solution_found \t STEP2_solution_found \n');
experimentNumber=1;
for initNumber=1:numberOfInitialConfigurations
    
    for partialInfoNumber=1:numberOfPartialInfoConfigurations
        %% saving the input
        %Save the input variables for future experiment replications
        environment=testenvironments(partialInfoNumber);
        initRobot1=initRobot1Positions(initNumber);
        initRobot2=initRobot2Positions(initNumber);
        createExperiment1;
        
        save(strcat('ReplicationPackage/experiment1-test', num2str(experimentNumber) ,'.mat'), 'sys', 'spec');
        [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1,  planlengthstep2, planningtimestep2, solutionfoundstep2]=experimentRunner(sys, spec, environment);
        
        if((solutionfoundstep1==1) && (solutionfoundstep2==1))
            Tr=(planningtimestep1/planningtimestep2);
            Lr=(planlengthstep1/planlengthstep2);
        else
            Tr=0;
            Lr=0;
        end
        X=sprintf('%d %d %d %d %d %f %f %d %d \n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
        disp(X);
        fprintf(fid, '%d %d %d %d %d %f %f %d %d\n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
        disp('||||||||experiment number||||||||')
        experimentNumber=experimentNumber+1
    end
end

fclose(fid);