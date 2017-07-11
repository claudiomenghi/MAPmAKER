


trueEvidenceCounter=0;
falseEvicenceCounter=0;


addpath('Inputs');
% creates the current scenario

%addpath('Inputs/Scenario1');
%createScenario1;

%addpath('Inputs/Scenario2');
%createScenario2;

addpath('Inputs/Scenario3');
createScenario3;

%addpath('Inputs/Scenario5');
%createScenario5;

%addpath('Inputs/ScenarioRoboCup');
%createScenarioRoboCup;

addpath('Visualization');
addpath('Utils');
addpath('Algorithms');


configParams;



% sets visualization constants, colors, cell dimensions etc
setVisualizationConstants;


%get the number of agents
tmp=size(sys);
N=tmp(2); 

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
currentiteration=0;
reply = '';
i=1;
iter=0;

perm = randperm(size(sys,2)); %permutation (i.e. ordering), meaning that agent 3 < agent 1 < agent 2
%perm=[1,2,3];
        
while currentiteration<maxIteration
    
    possibleSolutionSearchTriggered=0;
    skip=0;
    iter=iter+1;
    
    fprintf('-----------------\n Iteration: %d. \n-----------------\n',iter);
   
     h=3;
     fprintf('value of h %d ',h);
   % end
    clear Dep;
    clear ell;
    clear Buchi;
    clear B;
    clear P;
    
    
    %% computing the dependencies classes
    %dependency partition
    disp('STEP 1: computing the depencencies');
    [Dep,ell] = computeDependencies(spec,perm,N,h);
    for i=1:N
        cut(spec(i),h);
    end

    for i=1:N
        sys(i).previouscurr = sys(i).curr;
    end
    
    while currentiteration<maxIteration
   currentiteration=currentiteration+1;
    
    %% analysing the dependincies classes
        for i=1:ell
            clear Buchi;
            clear B;
            clear P;

            dep = Dep{i};
            M = length(dep);
            
            %% compute the intersection automaton
            disp('STEP 3: computing the intersection');
            [Buchi, kmap, EXPLICIT_STATES] = intersection(spec,h);

            disp('STEP 4: computing the progressiveFunction');
            [ Buchi, progressiveFunction ] = computeProgressiveFunction( Buchi , size(dep,2), kmap);

           % if isequal([1],B.Q)
           %     fprintf('h too small! \n');
           %     skip = 1;
           %     break;
           % end

           %disp('STEP 5: computing the product');
           %[P, sys, spec] = product(sys,spec, Buchi,H, environment.x, environment.y, 0);

           %disp('STEP 6: searcing for a path to be performed');
           %[DefinitivePath ] = searchActions(P, progressiveFunction);
           
           disp('STEP 5: computing the product');
           [P, sys, spec] = product(sys,spec, Buchi,H, environment.x, environment.y, 1);

           disp('STEP 6: searcing for a path to be performed');
           [PossiblePath ] = searchActions(P, progressiveFunction);

%           if(size(DefinitivePath,1)<size(PossiblePath,1))
 %              Path=DefinitivePath;
 %          else
               Path=PossiblePath;
  %         end
           
           disp('STEP 7: updating the state of the machine');
           
           
           
           i=2; 
           evidence=1;
           while evidence && i<=size(Path,1)
               grid=blankCurrentRobotPosition(sys, environment, grid, offset, scale);
               machineindex=1;
               while machineindex<=N && evidence
                    % simulates the discovering of new information
                    [sys, grid, environment, infdiscovered, evidence]=actionBasedInfDiscover(grid, sys, environment, machineindex, sys(machineindex).curr,Path(i,machineindex));
                    
                    if(infdiscovered==0)
                        sys(machineindex).curr=Path(i,machineindex);
                        spec(machineindex).curr=EXPLICIT_STATES(Path(i,M+1),machineindex);
                    end
                    if(infdiscovered==1)
                        if(evidence)
                            sys(machineindex).curr=Path(i,machineindex);
                            spec(machineindex).curr=EXPLICIT_STATES(Path(i,M+1),machineindex);
                            trueEvidenceCounter=trueEvidenceCounter+1
                        else
                            falseEvicenceCounter=falseEvicenceCounter+1
                        end
                    end
                    
                    machineindex=machineindex+1;
               end           

               i=i+1;
           
               grid=visualizeCurrentRobotPosition(sys, environment, grid, offset, scale);
               pause(2);
           end
%           [grid, offset]=visualize(grid, sys, offset, spec, environment);
           
           currFrame = getframe(gcf);
         %  writeVideo(v,currFrame);

        end
    
    end
     
end
%close(v);