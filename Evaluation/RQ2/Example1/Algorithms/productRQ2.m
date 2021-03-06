%
% Buchi: the intersection between the spec of the automata
% H: the value of H to be used
% M: the number of robots in the dependency class
% B:
function [timeout, P, sys, spec, acceptingstates, acceptingFound] = productRQ2(sys,spec,Buchi, maxX, maxY, possible, timeoutval)

tStart = tic;
timeout=0;
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

P.STATES(1,:)=[sys.curr Buchi.curr 0];

acceptingstates=[];
acceptingFound=0;

%% inspecting the state space of the automata
% until i is less than h and there are new states that are not visited
while  ~acceptingFound && (topstackhindex-bottomstackhindex>=0)

    %fprintf('Level %d of the product \n', i);
    i=i+1;
    addedelements=0;
    analizedElements=0;

     %% analyzing the new states with the specified h
    for currenststateindex=bottomstackhindex:topstackhindex %take a state
        
        tElapsed = toc(tStart);
        if(tElapsed>timeoutval)
            timeout=1;
            return
        end
        
        CURRENT_STATE=P.STATES(currenststateindex,:);
        analizedElements=analizedElements+1;
        for t=1:act_no
            P.trans{currenststateindex,t}=[];
        end          
        comb=[];
        %explore all components of sys(1)...sys(M)
        for m=1:numberOfprocess
            currentProcessIndex=m;

            if(possible)
                nextstatesM{m}=[CURRENT_STATE(currentProcessIndex) getNextStates(sys(currentProcessIndex).padj, maxX, maxY,CURRENT_STATE(currentProcessIndex))];
            else
                nextstatesM{m}=[CURRENT_STATE(currentProcessIndex) getNextStates(sys(currentProcessIndex).adj, maxX, maxY,CURRENT_STATE(currentProcessIndex))];
            end
            if(isempty(comb))
                comb=nextstatesM{m};
            else
                comb=combvec(comb,nextstatesM{m});
            end
            clear currentProcessIndex;
        end
        
        for conf=1:size(comb,2)
            nextstatesystem=comb(:,conf)';
            nextstate=[nextstatesystem CURRENT_STATE(1,numberOfprocess+1) CURRENT_STATE(1,numberOfprocess+2)];
            found=0;
            %% check whether the next state is consistent with the sync
            if checkSync(sys,  nextstate, possible)
                %% check the next state of the automaton of the property
                for t=1:act_no           
                    nextstateproperty=Buchi.trans{CURRENT_STATE(numberOfprocess+1),t};
                    propertyservices=Buchi.lab{t};
                    %%
                    if(possible)
                        nextstateOfMServices=getPossibleServices(sys,nextstatesystem);
                    else
                        nextstateOfMServices=getServices(sys, nextstatesystem);
                    end
                    if(~isempty(nextstateproperty))
                        %% adds the state that is the successor of the "Buchi automaton"
                        if (isempty(propertyservices) && isequal(nextstateOfMServices,[])) || (isequal(propertyservices,nextstateOfMServices))


                            %% specifies how the creation of the product works when also the BA is moving
                            nextstate(numberOfprocess+1)=nextstateproperty;
                            %nextstate(1,numberOfprocess+2:size(CURRENT_STATE(1,:),2))=CURRENT_STATE(1,numberOfprocess+2:size(CURRENT_STATE(1,:),2));

                            if(ismember(nextstateproperty,Buchi.F))
                                nextstate(numberOfprocess+2)=nextstate(numberOfprocess+2)+1;
                                %if(~ismember(nextstate,acceptingstates))
                                    % an accepting state that can be
                                    % entered infinitely many often has
                                    % been found

                                %    nextstate(1, numberOfprocess+2)=1;
                                %    acceptingstates=[acceptingstates; nextstate];
                                %else
                                if(nextstate(numberOfprocess+2)==2)
                                    % adds the accepting state since it is
                                    % visited twice
                                    %nextstate(1, numberOfprocess+2)=2;
                                    acceptingstates=[acceptingstates; nextstate];
                                    acceptingFound=1;
                                end
                            end
                            if(~ismember(nextstate, P.STATES, 'rows'))
                                P.STATES=[P.STATES; nextstate];
                                addedelements=addedelements+1;
                                P.Q=[P.Q topstackhindex+addedelements];
                            end

                           indexOfConfiguration=find(ismember(P.STATES,nextstate,'rows'));
                           if ~(ismember(indexOfConfiguration, P.trans{currenststateindex,t}))
                                P.trans{currenststateindex,t}=[ P.trans{currenststateindex,t} indexOfConfiguration];
                           end

                        end
                    end
                end
                 
               
%                 %% specifies how the creation of the intersection works when the ba does not move
%                 if(~ismember(nextstate, P.STATES, 'rows'))
%                     P.STATES=[P.STATES; nextstate];
%                     addedelements=addedelements+1;
%                     P.Q=[P.Q topstackhindex+addedelements];
%                 end
% 
%                 indexOfConfiguration=find(ismember(P.STATES,nextstate,'rows'));
% 
%                 % add a transition to the automaton
%                 if ~(ismember(indexOfConfiguration, P.trans{currenststateindex,t}))
%                     P.trans{currenststateindex,t}=[ P.trans{currenststateindex,t} indexOfConfiguration];
%                 end
            end
        end
    end
    bottomstackhindex=bottomstackhindex+analizedElements;
    topstackhindex=topstackhindex+addedelements;
end

   


%fprintf('Size of the product: %d \n', length(P.Q));
