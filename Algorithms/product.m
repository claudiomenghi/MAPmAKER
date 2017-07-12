%
% Buchi: the intersection between the spec of the automata
% H: the value of H to be used
% M: the number of robots in the dependency class
% B:
function [P, sys, spec, acceptingstate] = product(sys,spec,Buchi, maxX, maxY, possible)



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

P.STATES(1,:)=[sys.curr; Buchi.curr];

acceptingstate=-1;
acceptingFound=0;

%% inspecting the state space of the automata
% until i is less than h and there are new states that are not visited
while  ~acceptingFound && (topstackhindex-bottomstackhindex>=0)

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
            currentProcessIndex=m;

            if(possible)
                nextstatesM=[CURRENT_STATE(currentProcessIndex) getNextStates(sys(currentProcessIndex).padj, maxX, maxY,CURRENT_STATE(currentProcessIndex))];
            else
                nextstatesM=[CURRENT_STATE(currentProcessIndex) getNextStates(sys(currentProcessIndex).adj, maxX, maxY,CURRENT_STATE(currentProcessIndex))];
            end

            clear succ;
            for nextstateAutMpos = 1:numel(nextstatesM)

                nextstate=CURRENT_STATE;
                nextstateM=nextstatesM(nextstateAutMpos);
                nextstate(m)=nextstateM;

                found=0;
                %% check the next state of the automaton of the property
                for t=1:act_no           
                    if ~isempty(Buchi.trans{CURRENT_STATE(numberOfprocess+1),t})
                        nextstateproperty=Buchi.trans{CURRENT_STATE(numberOfprocess+1),t};
                        propertyservices=Buchi.lab{t};
                        %%
                        if(possible)
                            nextstateOfMServices=sys(currentProcessIndex).pser{nextstateM};
                        else
                            nextstateOfMServices=sys(currentProcessIndex).ser{nextstateM};
                        end
                        %% adds the state that is the successor of the "Buchi automaton"
                        if isequal(propertyservices,nextstateOfMServices)


                            found=1; 
                            %% specifies how the creation of the product works when also the BA is moving
                            nextstate(numberOfprocess+1)=nextstateproperty;
                            nextstate(1,numberOfprocess+2:size(CURRENT_STATE(1,:),2))=CURRENT_STATE(1,numberOfprocess+2:size(CURRENT_STATE(1,:),2));

                            if(ismember(nextstateproperty,Buchi.F))
                                % an accepting state that can be
                                % entered infinitely many often has
                                % been found
                                acceptingFound=1;
                                acceptingstate=nextstate;
                            end
                            if(~ismember(nextstate, P.STATES, 'rows'))
                                P.STATES=[P.STATES; nextstate];
                                addedelements=addedelements+1;
                                P.Q=[P.Q topstackhindex+addedelements];
                            end

                           indexOfConfiguration=find(ismember(P.STATES,nextstate,'rows'));

                           P.trans{currenststateindex,t}=[ P.trans{currenststateindex,t} indexOfConfiguration];
                            if(acceptingFound)
                                return;
                            end
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

   


fprintf('Size of the product: %d \n', length(P.Q));
