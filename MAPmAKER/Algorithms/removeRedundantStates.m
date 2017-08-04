%% INPUT
% inputAutomaton
% states the index of the states to be kept in the automaton
% initialState the index of the initial state in the matrix states
%% OUTPUT 
% outputAutomaton
function [ outputAutomaton ] = removeRedundantStates( inputAutomaton , states, initialState)
% Removes from the input Automaton all the states that are not reachable
% from the initial state of the automaton
outputAutomaton.Q=ones(1, size(states,2));
outputAutomaton.Sigma=inputAutomaton.Sigma;

%% adding the initial state
outputAutomaton.curr=states(initialState);

%% adding the final states
outputAutomaton.F=[];
for stateIndex = states
    if(~isempty(inputAutomaton.F))
        if ismember(inputAutomaton.F,inputAutomaton.Q(stateIndex,:),'rows') 
            outputAutomaton.F=[outputAutomaton.F stateIndex];
        end
    end
end

%% adding the transition relation

numStates=size(states, 2);
numLabels=size(outputAutomaton.Sigma, 1);

for stateIndex=1:numStates
    for labelIndex=1:numLabels
        sourcestate=inputAutomaton.Q(stateIndex);
        if(~isempty(inputAutomaton.trans{sourcestate,labelIndex}))
            destinationstate=inputAutomaton.trans{sourcestate,labelIndex};
            destinationIndex=find(ismember(states,destinationstate));
            outputAutomaton.trans{stateIndex,labelIndex}=destinationIndex;
        else
            outputAutomaton.trans{stateIndex,labelIndex}=[];
        end
    end
end

outputAutomaton.lab=inputAutomaton.lab;

outputAutomaton.V1=inputAutomaton.V1;
outputAutomaton.V2=inputAutomaton.V2;


end

