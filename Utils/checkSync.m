function [result] = checkSync(sys, nextstatesystem, possible)
%% check whether the sync occurs correctly in the state
    result=1;
    numberOfprocess=size(sys,2);
    
    for m=1:numberOfprocess
        %if ~(currentstatesystem(m)==nextstatesystem(m))
            if ~isempty(sys(m).sync{nextstatesystem(m)})
                values=sys(m).sync{nextstatesystem(m)};
                for i=1:size(values,2)
                    if ~(nextstatesystem(values(i))==nextstatesystem(m))
                        result=0;
                        return;
                    end
                end
            end
        %end
    end
    if(possible)
        for m=1:numberOfprocess
            %if ~(currentstatesystem(m)==nextstatesystem(m))
                if ~isempty(sys(m).psync{nextstatesystem(m)})
                    values=sys(m).psync{nextstatesystem(m)};
                    for i=1:size(values,2)
                        if ~(nextstatesystem(values(i))==nextstatesystem(m))
                            result=0;
                            return;
                        end
                    end
                end
            %end
        end
    end
 
end