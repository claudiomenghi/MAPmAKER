function [ services ] = getPossibleServices( sys, states )
%GETSERVICES Summary of this function goes here
%   Detailed explanation goes here

    services=[];
     for i=1:size(states,2)
        services=[services sys(i).pser{states(i)}];
    end
    
end

