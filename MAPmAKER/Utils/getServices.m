function [ services ] = getServices( sys, states )
%GETSERVICES Summary of this function goes here
%   Detailed explanation goes here

    services=[];
    for i=1:size(states,2)
        services=[services sys(i).ser{states(i)}];
    end
    
end
