close all;
clear all;

addpath('Inputs');
addpath('Visualization');
addpath('Utils');
addpath('Algorithms');

configParams;

% creates the current scenario
createScenario;

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
v=VideoWriter('movie.avi');
v.FrameRate = 1;
open(v);


reply = '';
i=1;
iter=0;

perm = [3,1,2]; %permutation (i.e. ordering), meaning that agent 3 < agent 1 < agent 2
%perm=[1,2,3];
        

while isempty(reply)
    
    possibleSolutionSearchTriggered=0;
    skip=0;
    iter=iter+1;
    
    fprintf('-----------------\n Iteration: %d. \n-----------------\n',iter);
   % h = input('Input h :');
   % if isempty(h)
        h=3;
   % end
    clear Dep;
    clear ell;
    clear Buchi;
    clear B;
    clear P;
    
    
%% computing the dependencies classes
    %dependency partition
    [Dep,ell] = computeDependencies(spec,perm,N,h);
    for i=1:N
        cut(spec(i),h);
    end

    for i=1:N
        sys(i).previouscurr = sys(i).curr;
    end
        
%% analysing the dependincies classes
    for i=1:ell
        clear Buchi;
        clear B;
        clear P;
        
        dep = Dep{i};
        M = length(dep);
        
        [Buchi, B] = intersection(spec,dep, h);
        fprintf('Buchi %d done \n', i);
        
       % if isequal([1],B.Q)
       %     fprintf('h too small! \n');
       %     skip = 1;
       %     break;
       % end

       [P, sys, spec] = product(sys,spec,dep,M,B,Buchi,H);
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
    
    [sys, grid, environment]=infDiscover(grid, sys, environment);
    
    
    currFrame = getframe(hh);
    writeVideo(v,currFrame);
end
close(v);
