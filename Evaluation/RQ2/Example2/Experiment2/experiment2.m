close all;
clear;

%30 min of timeout
timeoutval=1800;

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

            [timeout1, timeout2, falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1,  planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep1, performedpathstep2]=experimentRunner(sys, spec, partialenvironment, realenvironment, timeoutval);

            pathsStep1{initNumber,partialInfoNumber}=performedpathstep1;
            pathsStep2{initNumber,partialInfoNumber}=performedpathstep2;

            if ((timeout1==1)&&(timeout2==1))
                fid=fopen('resultsex2.txt','a');
                fprintf(fid,'%d %s \n' ,[experimentNumber 'both timeout']);
            else    
                if ((timeout2==1))
                    fid=fopen('resultsex2.txt','a');
                    fprintf(fid,'%d %s \n' ,[experimentNumber 'dec found solution, no dec timeout']);
                    else
                    if((solutionfoundstep1==1) && (solutionfoundstep2==1))
                        Tr=(planningtimestep1/planningtimestep2);
                        Lr=(planlengthstep1/planlengthstep2);
                        fid=fopen('resultsex2.txt','a');
                        fprintf(fid, '%d %d %d %d %d %f %f %d %d\n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
                        X=sprintf('%d %d %d %d %d %f %f %d %d \n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
                        disp(X);
                    else
                        Tr='-';
                        Lr='-';
                        fid=fopen('resultsex2.txt','a');
                        fprintf(fid, '%d %d %d %d %d %c %c %d %d\n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
                        X=sprintf('%d %d %d %d %d %c %c %d %d \n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
                        disp(X);
                    end
                end
            end


            fclose(fid);
            disp('||||||||experiment number||||||||')
            experimentNumber=experimentNumber+1
        else
            init=init+1;
        end
        
    end
end

