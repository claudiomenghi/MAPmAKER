function [x,y] = transform_coordinates_index2xy(index, maxX, maxY)

y = mod(index, maxY);
if(y==0)
    y=maxY;
end
x = ceil(index/maxY);

end