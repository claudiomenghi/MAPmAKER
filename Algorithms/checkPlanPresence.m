function [ Plan, found] = checkPlanPresence(oldPlans, source, destination )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    Plan=[];
    found=0;
    for planIndex=1:size(oldPlans,2)
        if(isequal(oldPlans{planIndex}(1,1:size(source,2)),source))
            if(isequal(oldPlans{planIndex}(size(oldPlans{planIndex},1),:),destination))
                Plan=oldPlans{planIndex};
                found=1;
            end
        end
    end

end

