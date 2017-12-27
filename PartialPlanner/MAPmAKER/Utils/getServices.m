function [ services ] = getServices( sys, states )
%GETSERVICES Summary of this function goes here
%   Detailed explanation goes here

    services=[];
    for i=1:size(states,2)
%         disp('AAAA')
%         disp(size(sys))
%         disp(i)
%         disp(states(i));
%         disp(size(sys(i).ser));
%         sys(i).ser{states(i)}
        services=[services sys(i).ser{states(i)}];
    end
end

