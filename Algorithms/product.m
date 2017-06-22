%
% Buchi: the intersection between the spec of the automata
% H: the value of H to be used
% M: the number of robots in the dependency class
% B:
function [P, sys, spec] = product(sys,spec,dep,Buchi,H, maxX, maxY, possible)

global possibleengineenabled;

clear P;
clear weight;
clear succ;

numberOfprocess=size(sys,2);

%% sets the intial state of the intersection between the automaton and the property
%Keeps track of the current location of the property
P.curr = 1;
% number of 
act_no=size(Buchi.Sigma,1);
P.Sigma = 1:act_no;

Qnew = true;
P.Q = [1];
%%%%%%%%%


i=0;
P.max = [];
% maxV1
% maxV2
P.trans{1,1}=[];

% it contains the index of the new states and the value of the progressive
% function
%NEW_STATES_PROGRESSIVE_FUNCTION=progressiveFunction(1);
% giving the value -1 there are no states with index -1

bottomstackhindex=1;
topstackhindex=1;

P.STATES(1,:)=[sys(dep).curr Buchi.curr];



acceptingFound=0;
H=H-1;
while ~acceptingFound
    H=H+1;
    
    %% inspecting the state space of the automata
    % until i is less than h and there are new states that are not visited
    while i<H && (topstackhindex-bottomstackhindex>=0)

        fprintf('Level %d of the product \n', i);
        i=i+1;
        addedelements=0;
        analizedElements=0;

         %% analyzing the new states with the specified h
        for currenststateindex=bottomstackhindex:topstackhindex %take a state

            CURRENT_STATE=P.STATES(currenststateindex,:);
            analizedElements=analizedElements+1;
            for t=1:act_no
                P.trans{currenststateindex,t}=[];
            end                    
            %explore all components of sys(1)...sys(M)
            for m=1:numberOfprocess
                currentProcessIndex=dep(m);

                if(possible)
                    nextstatesM=getNextStates(sys(currentProcessIndex).padj, maxX, maxY,CURRENT_STATE(currentProcessIndex));
                else
                    nextstatesM=getNextStates(sys(currentProcessIndex).adj, maxX, maxY,CURRENT_STATE(currentProcessIndex));
                end
                
                clear succ;
                for nextstateAutMpos = 1:numel(nextstatesM)

                    nextstate=CURRENT_STATE;
                    nextstateM=nextstatesM(nextstateAutMpos);
                    nextstate(m)=nextstateM;

                    found=0;
                    %% check the next state of the automaton of the property
                    for t=1:act_no           
                        baindex=numberOfprocess+1;
                        if ~isempty(Buchi.trans{CURRENT_STATE(baindex),t})
                            nextstateproperty=Buchi.trans{CURRENT_STATE(baindex),t};
                            propertyservices=Buchi.lab{t};
                            %%
                            nextstateOfMServices=sys(currentProcessIndex).ser{nextstateM};

                            %% adds the state that is the successor of the "Buchi automaton"
                            if isequal(intersect(propertyservices,sys(currentProcessIndex).Pi),nextstateOfMServices)
                                  %% specifies how the creation of the product works when also the BA is moving
                                if(ismember(nextstateproperty,Buchi.F))
                                    acceptingFound=1;
                                end
                                nextstate(numberOfprocess+1)=nextstateproperty;
                                if(~ismember(nextstate, P.STATES, 'rows'))
                                    P.STATES=[P.STATES; nextstate];
                                    addedelements=addedelements+1;
                                    P.Q=[P.Q topstackhindex+addedelements];
                                end

                               indexOfConfiguration=find(ismember(P.STATES,nextstate,'rows'));

                               P.trans{currenststateindex,t}=[ P.trans{currenststateindex,t} indexOfConfiguration];

                            end
                        end

                    end 
                    if(found==0)

                        %% specifies how the creation of the intersection works when the ba does not move
                        if(~ismember(nextstate, P.STATES, 'rows'))
                            P.STATES=[P.STATES; nextstate];
                            addedelements=addedelements+1;
                            P.Q=[P.Q topstackhindex+addedelements];
                        end

                        indexOfConfiguration=find(ismember(P.STATES,nextstate,'rows'));


                        % add a transition to the automaton
                        P.trans{currenststateindex,t}=[ P.trans{currenststateindex,t} indexOfConfiguration];


                    end 
                end
            end
        end
        bottomstackhindex=bottomstackhindex+analizedElements;
        topstackhindex=topstackhindex+addedelements;
    end
end
   


fprintf('Size of the product: %d \n', length(P.Q));
