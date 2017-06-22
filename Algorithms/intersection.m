%% INPUT
% spec: the specification of the automata
% dep: the automata in the dependency class
% h: the index upon which the automata must be explored
%% OUTPUT
function [P, kmap, STATES] = intersection(spec,dep, h)

clear succ;
clear P;
clear B;
clear Bnew;

M = length(dep);
%% computes the cartesian product, i.e., all the possible states of the intersection
%STATES=cartesian_product(spec(dep).Q, 1:h); 
%P.Q=1:size(STATES,1);

% P.Q = [ spec(dep).Q contains the current state of ech of the automata of
% the spec 1:h, 2:h] contains the current accepting level]
% number of row of P.Q, states number
%st_no=size(STATES,1); 

kmap=[1 0];


%% Computes all the possible states of the interesection automaton
P.curr = 1; % initial location from which the state space exploration starts

%for i=1:st_no % for every possible configuration of locations
%    P.V1{i} = STATES(i); % saves the index 2*h in the V1 cell, i.e., saves how much progress can be made% 
%P.V2{i} = -1000;
%    if isequal(STATES(i,:),current)
        % saves in P.curr the index of the global state of the intersection
%        P.curr=i;
%    end
%end
%P.V2{P.curr}=0;
%P.V1{P.curr}=0; 

%% computes the alphabet of the intersection, i.e.,
% all the possible combinations of actions the robot can perform

P.Sigma = cartesian_product(spec(dep).Sigma);
act_no=size(P.Sigma,1);

%% it computes the services associated with each combination of actions (in sigma)
P.lab{act_no}=[];

% it loops over all the possible ways in which the actions can be combined
for t = 1:act_no 
    % tries to perform a combination of actions
    % label for each sigma in Sigma
    P.lab{t}=[];
    for k = 1:M
        if P.Sigma(t,k)~=0
            P.lab{t} = unique([P.lab{t} spec(dep(k)).lab{P.Sigma(t,k)}]);
        end
    end
end

%% computes the transition relation of the automata

P.trans{1,1}=[];
% contains a matrix with size: possible states X possible actions


processed = [];
tobeprocessed = [1, 1];
bottomstackhindex=1;
topstackhindex=1;
fprintf('Working on the intersection automaton for class');
fprintf(' %d', dep);
fprintf(' ...\n');

P.Q=1;
P.F=[];
STATES(1,:)=[ spec(dep).curr 0];
stacklevel=1;
iter=1;
visitedstates=[];
acceptingMachineArray=1;

while (topstackhindex-bottomstackhindex>=0) && (iter<=h) %explore -- using the cut already
   
    fprintf('Level %d \n', iter);
    
    iter = iter+1;
    addedelements=0;
    analizedElements=0;
    
    for j=bottomstackhindex:topstackhindex %do it from possible current states
        addedstates=0;
        currenststateindex=j;
        CURRENT_STATE=STATES(currenststateindex,:);
        acceptingMachine=acceptingMachineArray(currenststateindex,:);
        analizedElements=analizedElements+1;
        
        for t=1:act_no
            % computes the successors of the now state
            % succ{i} contains for each machine the successor for the
            % given label
            succ=CURRENT_STATE;
            found=0;
            for m = 1:M
                currentSpec=dep(m);
                if(~P.Sigma(t,currentSpec)==0)
                    localEvents=P.Sigma(t,currentSpec);
                   
                     if ~isempty(spec(currentSpec).trans{CURRENT_STATE(1,currentSpec),localEvents})
                          succ(currentSpec) = spec(currentSpec).trans{CURRENT_STATE(1,currentSpec),localEvents};
                        found=1;
                    end
                end
            end
            if(found==1)

                acceptingValue=CURRENT_STATE(1,M+1);

                % computing the value of the next k
                % check whether the next state is of the machine M is an
                % accepting state
                 acceptingcheckSpec=dep(acceptingMachine);
                 addedAccepting=0;
                 if(acceptingValue==M)
                     acceptingValue=0;
                 end
                if(~isempty(intersect(spec(acceptingcheckSpec).F,succ(acceptingcheckSpec))))
                    
                    if(acceptingMachine==M)
                        addedAccepting=1;
                        acceptingMachine=1;
                    else
                        acceptingMachine=acceptingMachine+1;
                       
                    end
                     acceptingValue=acceptingValue+1;
                end
                succ(M+1)= acceptingValue;      
                state=succ;
                
                if(~ismember(state, STATES, 'rows'))
                    STATES=[STATES; state];
                    acceptingMachineArray=[acceptingMachineArray; acceptingMachine];
                    addedelements=addedelements+1;
                    P.Q=[P.Q topstackhindex+addedelements];
                    indexOfConfiguration=find(ismember(STATES,state,'rows'));
                    kmap=[kmap; indexOfConfiguration  acceptingValue];
                    if(addedAccepting)
                        P.F=[P.F indexOfConfiguration];
                     end
                end
                
                indexOfConfiguration=find(ismember(STATES,state,'rows'));
                
                % add a transition to the automaton
                P.trans{j,t}=indexOfConfiguration;
                
            end
            
            
        end
        
    end
    bottomstackhindex=bottomstackhindex+analizedElements;
    topstackhindex=topstackhindex+addedelements;
end

%B=removeRedundantStates(P, processed, init);