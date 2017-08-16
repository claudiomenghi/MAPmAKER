function [falseEvicenceCounter, trueEvidenceCounter, planlength, planningtime, solutionfound, performedpath] = mapmaker(sys, spec,   environment, realenvironment,  possiblepathenabled, maxIteration, plotenabled, grid,  offset, scale, video_name)

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
performedpath=[];

N=size(sys,2);
%% creates a dependency class for each element
for i=1:N
    dependencyclassmap{i}=[i];
end

%% updates the dependency classes of the robots
for i=1:N
    for robotIndexIterator=1:size(sys(i).syncrobotset,2)
        robotIndex=sys(i).syncrobotset(robotIndexIterator);
        dependencyclassmap{robotIndex}=i;
    end
end

%% updates the dependency classes
dependencyclass{1}=[];
index=1;
analyzed=[];
for i=1:N
    class=dependencyclassmap{i};
    if ~ismember(class, analyzed)
        analyzed=[analyzed class];
        for j=1:N
            if (dependencyclassmap{j}==class)
                if(index>size(dependencyclass,1))
                    dependencyclass{index}=j;
                else
                    dependencyclass{index}=[dependencyclass{index} j];
                end
            end
        end
        index=index+1;
    end
end

disp(dependencyclass)


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
M=size(sys,2);

%% Video
%F=getframe();
%movie(F);
%video_name=sprintf('movie_%d', experimentnumber);
v=VideoWriter(video_name);
v.FrameRate = 1;
open(v);
%%
drawnow();
global f;
width = 800;
height = 600;
set(f,'Position',[15 15 width height])


currFrame = getframe(f);
set(f,'Position',[15 15 width height])


%currFrame.cdata=currFrame.cdata(:,1:size(currFrame.cdata,2),:);
writeVideo(v,currFrame);
writeVideo(v,currFrame);
writeVideo(v,currFrame);



newInf=1;
while newInf
    
    possibleSolutionSearchTriggered=0;
    skip=0;
    iter=iter+1;
    
    fprintf('-----------------\n Iteration: %d. \n-----------------\n',iter);
    
    h=3;
    % fprintf('value of h %d ',h);
    % end
    clear Buchi;
    clear B;
    clear P;
    
    
    currentiteration=currentiteration+1;
    
    for i=1:size(dependencyclass,2)
        clear newsys;
        clear newspec;
        disp('Analyzing the dependency class');
        class=dependencyclass{i};
        disp(class);
        
        for index=1:size(class,2)
            newsys(index)=sys(class(index));
            newspec(index)=spec(class(index));
        end
        [Path{i} EXPLICIT_STATES{i} plantime solutionfound]=computePlan(newsys,newspec, environment, possiblepathenabled);
        planningtime=planningtime+plantime;
    end
    
    if (solutionfound)
        disp('Performing the plan');
        maxlength=0;
        for i=1:size(Path,2)
            maxlength=max(maxlength,size(Path{i},1));
        end
        i=2;
        evidence=1;
        newInf=0;
        performedpath=[];
        while evidence && i<=maxlength
            
            for classIndex=1:size(dependencyclass,2)
                if i<=size(Path{classIndex},1)
                    class=dependencyclass{classIndex};
                    
                    if(plotenabled==1)
                        grid=blankCurrentRobotPosition(sys, environment, grid, offset, scale, class);
                    end
                    M=length(class);
                    m=1;
                    while m<=length(class) && evidence
                        machineindex=class(m);
                        locationInPath=find(class==machineindex);
                        performedpath(locationInPath,i)=Path{classIndex}(i,locationInPath);
                        
                        % simulates the discovering of new information
                        [sys, grid, environment, infdiscovered, evidence]=actionBasedInfDiscover(grid, sys, machineindex, environment, realenvironment,  sys(machineindex).curr,Path{classIndex}(i,locationInPath), plotenabled);
                        
                        if(infdiscovered==0)
                            sys(machineindex).curr=Path{classIndex}(i,locationInPath);
                            spec(machineindex).curr=EXPLICIT_STATES{classIndex}(Path{classIndex}(i,M+1),locationInPath);
                            planlength=planlength+1;
                            
                        end
                        if(infdiscovered==1)
                            if(evidence)
                                sys(machineindex).curr=Path{classIndex}(i,locationInPath);
                                spec(machineindex).curr=EXPLICIT_STATES{classIndex}(Path{classIndex}(i,M+1),locationInPath);
                                trueEvidenceCounter=trueEvidenceCounter+1;
                                planlength=planlength+1;
                            else
                                falseEvicenceCounter=falseEvicenceCounter+1;
                                evidence=0;
                                solutionfound=0;
                                newInf=1;
                            end
                        end
                        
                        
                        m=m+1;
                    end
                end
                
            end
            
            if(plotenabled==1)
                grid=visualizeCurrentRobotPosition(sys, environment, grid, offset, scale);
            end
            i=i+1;
            
            %% Video
            width = 800;
            height = 600;
            set(f,'Position',[15 15 width height])
            currFrame = getframe(f);
            %size(currFrame.cdata)   
           % currFrame.cdata=currFrame.cdata(:,1:size(currFrame.cdata,2),:);
            writeVideo(v,currFrame);
            %%
        end
        
        if(evidence==0)
            disp('new info about the environment detected');
        end
    else
        disp('No solution found');
        newInf=0;
    end
    
    disp('MAPmAKER end');
end

%% Video
close(gcf);
close(v);
%%

