function [falseEvicenceCounter, trueEvidenceCounter, planlength, planningtime, solutionfound] = mapmaker(sys, spec,   environment, possiblepathenabled, maxIteration, plotenabled, grid,  offset, scale)
% it computes the plans for the robots
% sys: the model of the robot application, i.e., the robots
% spec: the specification of each robot
% environment: the model of the environment
% possiblepathenabled: if the search of possible plans is enabled
% maxIteration, the maximum number of iterations to be performed
% plotenabled, is equal to 1 if the plot is enabled
% grid, environment, offset, scale, possiblepathenabled
%
%
solutionfound=0;
falseEvicenceCounter=0;
trueEvidenceCounter=0;
planlength=0;
planningtime=0;
oldPlans=[];
oldPlanCounter=0;

Path=[];

%get the number of agents
N=size(sys,2);

currentiteration=0;
reply = '';
i=1;
iter=0;

perm = randperm(size(sys,2)); %permutation (i.e. ordering), meaning that agent 3 < agent 1 < agent 2
%perm=[1,2,3];


newInf=1;
while newInf
    
    spec.curr=1;
    possibleSolutionSearchTriggered=0;
    skip=0;
    iter=iter+1;
    
    fprintf('-----------------\n Iteration: %d. \n-----------------\n',iter);
    
    h=3;
    % fprintf('value of h %d ',h);
    % end
    clear Dep;
    clear ell;
    clear Buchi;
    clear B;
    clear P;
    
    
    %% computing the dependencies classes
    %dependency partition
    %disp('STEP 1: computing the depencencies');
    [Dep,ell] = computeDependencies(spec,perm,N,h);
    for i=1:N
        cut(spec(i),h);
    end
    
    for i=1:N
        sys(i).previouscurr = sys(i).curr;
    end
    
    currentiteration=currentiteration+1;
    
    %% analysing the dependincies classes
    for i=1:ell
        clear Buchi;
        clear B;
        clear P;
        
        dep = Dep{i};
        M = length(dep);
        
        %% compute the intersection automaton
        disp('computing the intersection');
        [Buchi, kmap, EXPLICIT_STATES] = intersection(spec);
        
        disp('Computing the product');
        tStart = tic;
        [P, sys, spec, acceptingstate] = product(sys,spec, Buchi, environment.x, environment.y, 0);
        tElapsed = toc(tStart);
        planningtime=planningtime+tElapsed;
        if(~(acceptingstate==-1))
            disp('searcing for a definitive path to be performed');
            [ DefinitivePath, found]=checkPlanPresence(oldPlans,[sys.curr],acceptingstate);
            if(~(found==1))
                [DefinitivePath ] = searchActions(P, acceptingstate);
            end
            solutionfound=1;
        end
        
        if(possiblepathenabled==1)
            disp('Computing the possible product');
            tStart = tic;
            [P, sys, spec, pacceptingstate] = product(sys,spec, Buchi, environment.x, environment.y, 1);
            tElapsed = toc(tStart);
            planningtime=planningtime+tElapsed;
            if(~(pacceptingstate==-1))
                %disp('STEP 6: searcing for a path to be performed');
                [ PossiblePath, found]=checkPlanPresence(oldPlans,[sys.curr],acceptingstate);
                if(~(found==1))
                    [PossiblePath ] = searchActions(P, pacceptingstate);
                end
                solutionfound=1;
            end

        end
            
        if(possiblepathenabled==1)
            if(pacceptingstate==-1)
                disp('no definitive or possible plan available');
                return;
            end

            if(acceptingstate==-1)
                disp('no definitive plan available');
                Path=PossiblePath;
            else
                disp('the shortest between definitive and possible plan is chosen');
                if(size(DefinitivePath,1)<size(PossiblePath,1))
                    Path=DefinitivePath;
                else
                    Path=PossiblePath;
                end
            end
        else
            if(acceptingstate==-1)
                disp('no definitive plan available');
                return;
            else
                disp('definitive plan found');
                Path=DefinitivePath;
            end
        end



        oldPlans{oldPlanCounter+1}=Path;
        oldPlanCounter=oldPlanCounter+1;
        %disp('STEP 7: updating the state of the machine');


        i=2;
        evidence=1;
        newInf=0;
        while evidence && i<=size(Path,1)
            if(plotenabled==1)
                grid=blankCurrentRobotPosition(sys, environment, grid, offset, scale);
            end
            machineindex=1;
            while machineindex<=N && evidence
                % simulates the discovering of new information
                [sys, grid, environment, infdiscovered, evidence]=actionBasedInfDiscover(grid, sys, environment, machineindex, sys(machineindex).curr,Path(i,machineindex), plotenabled);

                if(infdiscovered==0)
                    sys(machineindex).curr=Path(i,machineindex);
                    spec(machineindex).curr=EXPLICIT_STATES(Path(i,M+1),machineindex);
                    planlength=planlength+1;
                end
                if(infdiscovered==1)
                    if(evidence)
                        sys(machineindex).curr=Path(i,machineindex);
                        spec(machineindex).curr=EXPLICIT_STATES(Path(i,M+1),machineindex);
                        trueEvidenceCounter=trueEvidenceCounter+1;
                        planlength=planlength+1;
                    else
                        falseEvicenceCounter=falseEvicenceCounter+1;
                        evidence=0;
                        solutionfound=0;
                        newInf=1;
                    end
                end

                machineindex=machineindex+1;
            end

            i=i+1;
            if(plotenabled==1)
                grid=visualizeCurrentRobotPosition(sys, environment, grid, offset, scale);
                %               pause(2);
            end
        end
            
       
    end
end
