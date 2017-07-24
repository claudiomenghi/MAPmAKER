function num = numberStateChanges(source, destination)
    num=0;
    for i=1:size(source,2)-1
        if (~isequal(source(i),destination(i)))
            num=num+1;
        end
    end

end



