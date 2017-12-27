function [x,y] = transform_coordinates_index2xy(index, maxX, maxY)

y = mod(index, maxY);

for i=1:size(y,2)
    if(y(i)==0)
        y(i)=maxY;
    end
end
x = ceil(index/maxY);

end