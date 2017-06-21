function [nextCells] = getNextStates(Map, xdimension, ydimension, cellIndex)

    nextCells=[];
    [x,y]=transform_coordinates_index2xy(cellIndex, xdimension, ydimension);
    if(x+1< xdimension)
        nextCells=[nextCells transform_coordinates_xy2index(x+1,y, xdimension, ydimension)];
    end
    if(y+1< ydimension)
        nextCells=[nextCells transform_coordinates_xy2index(x,y+1, xdimension, ydimension)];
    end
    if(x-1 > 0)
        nextCells=[nextCells transform_coordinates_xy2index(x-1,y, xdimension, ydimension)];
    end
    if(y-1 > 0)
        nextCells=[nextCells transform_coordinates_xy2index(x,y-1, xdimension, ydimension)];
    end
end
