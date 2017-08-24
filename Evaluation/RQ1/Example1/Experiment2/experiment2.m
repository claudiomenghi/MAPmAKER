close all;
clear;

load ModelsExperiment2.mat

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
    fid=fopen('resultsex2.txt','w');
    fprintf(fid, 'experimentNumber initConf partConf #F \t #T \t Tr \t Lr \t STEP1_solution_found \t STEP2_solution_found \n');
end
experimentNumber=1;

planningtimestep1_array=zeros(9,1);
planningtimestep2_array=zeros(9,1);

for initNumber=1:ModelsExperiment2.numberOfInitialConfigurations
    
    for partialInfoNumber=1:ModelsExperiment2.numberOfPartialInfoConfigurations
        
        if(init==curr)
            %% saving the input
            %Save the input variables for future experiment replications
            close all;
            
            sys=ModelsExperiment2.sys{initNumber,partialInfoNumber};
            spec=ModelsExperiment2.spec{initNumber,partialInfoNumber};
            partialenvironment=ModelsExperiment2.partialenvironment{initNumber,partialInfoNumber};
            realenvironment=ModelsExperiment2.realenvironment{initNumber,partialInfoNumber};
            
            [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1,  planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep1, performedpathstep2]=experimentRunner(sys, spec, partialenvironment, realenvironment, experimentNumber);
            
            pathsStep1{initNumber,partialInfoNumber}=performedpathstep1;
            pathsStep2{initNumber,partialInfoNumber}=performedpathstep2;
            
            %writeExperimentResults('resultsex2.txt', experimentNumber, initNumber, partialInfoNumber, falseEvicenceCounterstep1, trueEvidenceCounterstep1, Tr, Lr, solutionfoundstep1, solutionfoundstep2)
            writeExperimentResults('resultsex2.txt', experimentNumber, initNumber, partialInfoNumber, falseEvicenceCounterstep1, trueEvidenceCounterstep1, solutionfoundstep1, solutionfoundstep2, planningtimestep1, planningtimestep2, planlengthstep1, planlengthstep2)

            disp('||||||||experiment number||||||||')
            experimentNumber=experimentNumber+1
        else
            init=init+1;
        end
        
    end
end

j=1;
n=1;
m=1;
while j <= length(planningtimestep1_array)
    if planningtimestep1_array(j) ~= 45
        planningtimestep1_array_corrected(n)=planningtimestep1_array(j);
        n=n+1;
    end
    if planningtimestep2_array(j) ~= 45
        planningtimestep2_array_corrected(m)=planningtimestep2_array(j);
        m=m+1;
    end
    j=j+1;
end

planningtimestep1_avg=mean(planningtimestep1_array_corrected);
planningtimestep2_avg=mean(planningtimestep2_array_corrected);
planningtimestep1_median=median(planningtimestep1_array_corrected);
planningtimestep2_median=median(planningtimestep2_array_corrected);
planningtimestep1_min=min(planningtimestep1_array_corrected);
planningtimestep2_min=min(planningtimestep2_array_corrected);
planningtimestep1_max=max(planningtimestep1_array_corrected);
planningtimestep2_max=max(planningtimestep2_array_corrected);

save ResultsExperiment2.mat 

