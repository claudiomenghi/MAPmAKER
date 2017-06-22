close all;
clear all;

addpath('Inputs');
addpath('Inputs/Scenario1');
addpath('Inputs/Scenario2');
addpath('Visualization');
addpath('Utils');
addpath('Algorithms');


configParams;

% creates the current scenario
%createScenario1;
createScenario2;

% sets visualization constants, colors, cell dimensions etc
setVisualizationConstants;


%get the number of agents
tmp=size(sys);
N=tmp(2); 

%figure;
grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
hh=figure;
grid=visualizeGrid(grid, environment);
imshow(grid, c);
grid = visualizeInit(sys, offset, scale, grid, environment);
visualizeServices;

%F=getframe();
%movie(F);
%v=VideoWriter('movie.avi');
%v.FrameRate = 1;
%open(v);


reply = '';
i=1;
iter=0;

perm = randperm(size(sys,2)); %permutation (i.e. ordering), meaning that agent 3 < agent 1 < agent 2
%perm=[1,2,3];
        
while isempty(reply)
    
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
    
    while 1
    %% analysing the dependincies classes
        for i=1:ell
            clear Buchi;
            clear B;
            clear P;

            dep = Dep{i};
            M = length(dep);
            currentmachine=dep(i);
            disp('STEP 2: analyzing machine');
            disp(currentmachine);

            %% compute the intersection automaton
            disp('STEP 3: computing the intersection');
            [Buchi, kmap, EXPLICIT_STATES] = intersection(spec,dep, h);

            disp('STEP 4: computing the progressiveFunction');
            [ Buchi, progressiveFunction ] = computeProgressiveFunction( Buchi , size(dep,2), kmap);

           % if isequal([1],B.Q)
           %     fprintf('h too small! \n');
           %     skip = 1;
           %     break;
           % end

           disp('STEP 5: computing the product');
           [P, sys, spec] = product(sys,spec,dep, Buchi,H, environment.x, environment.y);

           disp('STEP 6: searcing for a path to be performed');
           [Path ] = searchActions(P, progressiveFunction);
           disp('STEP 7: updating the state of the machine');
           
           grid=blankCurrentRobotPosition(sys, environment, grid, offset, scale);
           sys(currentmachine).curr=Path(2,1);
           spec(currentmachine).curr=EXPLICIT_STATES(Path(2,2),currentmachine);
           disp([sys(currentmachine).curr spec(currentmachine).curr]);
           grid=visualizeCurrentRobotPosition(sys, environment, grid, offset, scale);
%           [grid, offset]=visualize(grid, sys, offset, spec, environment);
           pause(2);
        end
    
    end
    
    if ~skip
     
        for i=1:N
             if (sys(i).lastaction~=0) && (ismember(spec(i).curr,spec(i).F))
                 perm = [setdiff(perm,[i],'stable'),i];
                 fprintf('Reordering triggered by agent %d. \n', i);                 
             end
        end

        fprintf('New permutation:'); 
        disp(perm);
       
        [grid, offset]=visualize(grid, sys, offset, spec, environment);
       
        if sys(1).lastaction == 0
            reply = ''; 
        else
           
            reply = input('Do you want more? ', 's');
        end
        %reply = 'n';
        fprintf('\n');
    end
    
   % [sys, grid, environment]=infDiscover(grid, sys, environment);
    
    
%    currFrame = getframe(hh);
%    writeVideo(v,currFrame);
end
close(v);
