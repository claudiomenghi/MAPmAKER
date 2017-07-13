%% INPUT
% spec: the specification of the automata
% h: the index upon which the automata must be explored
%% OUTPUT
function [P, kmap, STATES] = intersection(spec)

clear succ;
clear P;
clear B;
clear Bnew;

M = size(spec,2);
%% computes the cartesian product, i.e., all the possible states of the intersection
kmap=[1 0];


%% Computes all the possible states of the interesection automaton
P.curr = 1; 

%% computes the alphabet of the intersection, i.e.,
% all the possible combinations of actions the robot can perform

P.Sigma = cartesian_product(spec.Sigma);
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
            P.lab{t} = unique([P.lab{t} spec(k).lab{P.Sigma(t,k)}]);
        end
    end
end

%% computes the transition relation of the automata

P.trans{1,1}=[];
% contains a matrix with size: possible states X possible actions


bottomstackhindex=1;
topstackhindex=1;
%fprintf('Working on the intersection automaton for class');
%fprintf(' ...\n');

P.Q=1;
P.F=[];
STATES(1,:)=[ spec.curr 0];
iter=1;

acceptingFound=0;


while ~acceptingFound
    
    while (topstackhindex-bottomstackhindex>=0) %explore -- using the cut already

        %fprintf('Level %d \n', iter);

        iter = iter+1;
        addedelements=0;
        analizedElements=0;

        for j=bottomstackhindex:topstackhindex %do it from possible current states
            currenststateindex=j;
            CURRENT_STATE=STATES(currenststateindex,:);
            analizedElements=analizedElements+1;

            for t=1:act_no
                
                % computes the successors of the now state
                % succ{i} contains for each machine the successor for the
                % given label
                succ=CURRENT_STATE;
                
                acceptingValue=CURRENT_STATE(1,M+1);

                if acceptingValue==M
                   acceptingValue=0;
                end
                found=1;
                
                for m = 1:M
                    currentSpec=m;
                    localEvents=P.Sigma(t,currentSpec);

                     if ~isempty(spec(currentSpec).trans{CURRENT_STATE(1,currentSpec),localEvents})

                         succ(currentSpec) = spec(currentSpec).trans{CURRENT_STATE(1,currentSpec),localEvents};

                        % computing the value of the next k
                        % check whether the next state is of the machine M is an
                        % accepting state

                         addedAccepting=0;

                        if(~isempty(intersect(spec(acceptingValue+1).F,succ(acceptingValue+1))))

                            if(acceptingValue+1==currentSpec)
                                acceptingValue=acceptingValue+1;
                                if acceptingValue==M
                                    acceptingFound=1;
                                    addedAccepting=1;
                                end
                            end
                        end
                        succ(M+1)= acceptingValue; 
                     else
                         found=0;
                    end
                end
                if found
                    state=succ;

                    if(~ismember(state, STATES, 'rows'))
                        STATES=[STATES; state];
                        addedelements=addedelements+1;
                        P.Q=[P.Q topstackhindex+addedelements];
                        indexOfConfiguration=find(ismember(STATES,state,'rows'));
                        kmap=[kmap; indexOfConfiguration  acceptingValue];
                        if(addedAccepting)
                            acceptingFound=1;
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
end

% add the transition for the non visitable states after an accepting state has
% been found
for j=size(P.trans,1):size(P.Q,2)
    for t=1:act_no
        P.trans{j,t}=[];
    end
end



%B=removeRedundantStates(P, processed, init);