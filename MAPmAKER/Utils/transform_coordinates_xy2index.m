function [index] = transform_coordinates_xy2index(x, y, maxX, maxY)
    index= (x-1)*maxY+y;
end