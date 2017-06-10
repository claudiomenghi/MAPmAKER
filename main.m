
clear all;
%delete(findall(0,'Type','figure'));
%bdclose('all');

% sets the colors for the robots
robotcolors=[3 %green 
    30 % blue
    37 % purple
    ];

global whitevalue;
global blackvalue;
global redvalue;
global possibleengineenabled;
global robotFigEnabled;


global possibleSolutionSearchTriggered;
possibleSolutionSearchTriggered=0;
robotFigEnabled=0;

whitevalue=64;
blackvalue=57;
redvalue=44;
possibleengineenabled=1;

addpath('Inputs');
addpath('Visualization');

%no of agents
N=3; 


%inputs
%environment=EnvironmentMapa();
environment=EnvironmentMapb();

offset(1)=-10;
offset(2)= 9;
offset(3)=-13;

sys(1)=PTB1(environment.map, environment.pmap);
sys(2)=PTC2(environment.map, environment.pmap);
sys(3)=PTA3(environment.map, environment.pmap);

spec(1)=B12();
spec(2)=C23();
spec(3)=A32();



% contains the robot number
N=3;
scale = 30;

figure;
personalGrid = ones(N, environment.x*scale+1,environment.y*scale+1)*whitevalue;

for i=1:N
    if(robotFigEnabled==1)
     visualizePersonalInit(robotcolors, sys, offset, scale, personalGrid(i,:,:), environment, i);
    end
end



figure;
grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
grid = visualizeInit(robotcolors, sys, offset, scale, grid, environment);






% horizon for the intersection automaton
h=3;
% horizon for the product
H=5;

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

    %dependency partition
    [Dep,ell] = dependency(spec,perm,N,h);
    for i=1:N
        cut(spec(i),h);
    end

    for i=1:N
        sys(i).previouscurr = sys(i).curr;
    end
        
    for i=1:ell
        clear Buchi;
        clear B;
        clear P;
        
        dep = Dep{i};
        M = length(dep);
        
        [Buchi, B] = intersection(spec,dep,M,h);
        fprintf('Buchi %d done \n',i);
        
       % if isequal([1],B.Q)
       %     fprintf('h too small! \n');
       %     skip = 1;
       %     break;
       % end
       
       % H = input('Input H :');
       % if isempty(H)
            H=5;
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
       
        [grid, offset]=visualize(grid, robotcolors, sys, offset, scale, spec);
       
        if sys(1).lastaction == 0
            reply = ''; 
        else
           
            reply = input('Do you want more? ', 's');
        end
        %reply = 'n';
        fprintf('\n');
    end
end
