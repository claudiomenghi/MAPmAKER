function [nextCells] = getNextStates(map, xdimension, ydimension, cellIndex)

    nextCells=[];
    [x,y]=transform_coordinates_index2xy(cellIndex, xdimension, ydimension);
    if(x+1<= xdimension)
        nextCell=transform_coordinates_xy2index(x+1, y,  xdimension, ydimension);
        if(map(cellIndex, nextCell)==1)
            nextCells=[nextCells nextCell];
        end 
    end
    if(y+1<= ydimension)
        nextCell=transform_coordinates_xy2index( x, y+1, xdimension, ydimension);
        if(map(cellIndex, nextCell)==1)
            nextCells=[nextCells nextCell];
        end 
    end
    if(x-1 > 0)
        nextCell=transform_coordinates_xy2index( x-1, y, xdimension, ydimension);
        if(map(cellIndex, nextCell)==1)
            nextCells=[nextCells nextCell];
        end 
    end
    if(y-1 > 0)
        nextCell=transform_coordinates_xy2index( x,y-1, xdimension, ydimension);
        if(map(cellIndex, nextCell)==1)
            nextCells=[nextCells nextCell];
        end 
    end
end
