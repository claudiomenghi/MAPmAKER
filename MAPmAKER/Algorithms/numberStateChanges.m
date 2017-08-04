function num = numberStateChanges(source, destination, numrobots)
    num=0;
    for i=1:numrobots
        if (~isequal(source(i),destination(i)))
            num=num+1;
        end
    end

end



