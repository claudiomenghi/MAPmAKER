close all;
clear;

load ModelsExperiment3.mat

% creates the current scenario
addpath('Visualization');
addpath('Utils');
addpath('Algorithms');

configParams;

% sets visualization constants, colors, cell dimensions etc
setVisualizationConstants;


curr=1;
init=1;

%% running the experiment
if(curr==init)
    fid=fopen('resultsex3.txt','w');
    fprintf(fid, 'experimentNumber initConf partConf #F \t #T \t Tr \t Lr \t STEP1_solution_found \t STEP2_solution_found \n');
end
experimentNumber=1;
for initNumber=1:ModelsExperiment3.numberOfInitialConfigurations
    
    for partialInfoNumber=1:ModelsExperiment3.numberOfPartialInfoConfigurations
       
        if(init==curr)
            %% saving the input
            %Save the input variables for future experiment replications
            close all;

            sys=ModelsExperiment3.sys{initNumber,partialInfoNumber};
            spec=ModelsExperiment3.spec{initNumber,partialInfoNumber};
            partialenvironment=ModelsExperiment3.partialenvironment{initNumber,partialInfoNumber};
            realenvironment=ModelsExperiment3.realenvironment{initNumber,partialInfoNumber};

            [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1,  planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep1, performedpathstep2]=experimentRunner(sys, spec, partialenvironment, realenvironment, experimentNumber);

            pathsStep1{initNumber,partialInfoNumber}=performedpathstep1;
            pathsStep2{initNumber,partialInfoNumber}=performedpathstep2;
            
             writeExperimentResults('resultsex3.txt', experimentNumber, initNumber, partialInfoNumber, falseEvicenceCounterstep1, trueEvidenceCounterstep1, Tr, Lr, solutionfoundstep1, solutionfoundstep2)

            disp('||||||||experiment number||||||||')
            experimentNumber=experimentNumber+1
        else
            init=init+1;
        end
        
    end
end

