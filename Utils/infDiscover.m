% updates the system with new information about the environment
function [sys, grid, environment] = infDiscover(grid, sys, environment)
    xmax=environment.x;
    ymax=environment.y;
    discovered=ones(environment.x*environment.y,environment.x*environment.y)*3;
    [; N]=size(sys);
    for r=1:N
        % getting the location of the robot r
        location=sys(r).curr;
        % check whether there exists a possible transition close to the
        % current location
        [x,y]= transform_coordinates_index2xy(sys(r).curr, xmax, ymax);
        %if 
        fprintf('checking for new knowledge observed from one of the robots\n');
        
        if(y < ymax)
            indexy=transform_coordinates_xy2index(x,y, xmax, ymax);
            indexyp1=transform_coordinates_xy2index(x,y+1, xmax, ymax);
            if(abs(sys(r).adj(indexy,indexyp1)-sys(r).padj(indexy,indexyp1))==1)
                  % simulates the discovering of info
                  value=randsrc(1,1,[0 1; 0.5 0.5]);
                  environment.map(indexy,indexyp1)=value;
                  environment.map(indexyp1, indexy)=environment.map(indexy,indexyp1);
                  environment.pmap(indexy,indexyp1)=environment.map(indexy,indexyp1);
                  environment.pmap(indexyp1, indexy)= environment.pmap(indexy,indexyp1);
                  discovered(indexy,indexyp1)=value;
                  discovered(indexyp1, indexy)=value;
                  fprintf('Robot %d acquired new knowledge ', r);
                  fprintf('knowledge %d about the transition between [x,y]=[%d, %d] and [x+1,y+1]=[%d, %d] added', value, x, y, x, y+1);
            end
        end

        if(y > 1)
            indexy=transform_coordinates_xy2index(x,y, xmax, ymax);
            indexyp1=transform_coordinates_xy2index(x,y-1, xmax, ymax);
             if(abs(sys(r).adj(indexy,indexyp1)-sys(r).padj(indexy,indexyp1))==1)
                  
                  value=randsrc(1,1,[0 1; 0.5 0.5]);
                  environment.map(indexy,indexyp1)=value;
                  environment.map(indexyp1, indexy)=environment.map(indexy,indexyp1);
                  environment.pmap(indexy,indexyp1)=environment.map(indexy,indexyp1);
                   environment.pmap(indexyp1, indexy)= environment.pmap(indexy,indexyp1);
                    discovered(indexy,indexyp1)=value;
                   discovered(indexyp1, indexy)=value;
                  fprintf('Robot %d acquired new knowledge ', r);
                  fprintf('knowledge %d about the transition between [x,y]=[%d, %d] and [x+1,y+1]=[%d, %d] added', value, x, y, x, y-1);
                  
             end
        end

        if(x < xmax)
            indexy=transform_coordinates_xy2index(x,y, xmax, ymax);
            indexyp1=transform_coordinates_xy2index(x+1,y, xmax, ymax);
             if(abs(sys(r).adj(indexy,indexyp1)-sys(r).padj(indexy,indexyp1))==1)
                 value=randsrc(1,1,[0 1; 0.5 0.5]);
                  environment.map(indexy,indexyp1)=value;
                  environment.map(indexyp1, indexy)=environment.map(indexy,indexyp1);
                  environment.pmap(indexy,indexyp1)=environment.map(indexy,indexyp1);
                   environment.pmap(indexyp1, indexy)= environment.pmap(indexy,indexyp1);
                    discovered(indexy,indexyp1)=value;
                   discovered(indexyp1, indexy)=value;
                  fprintf('Robot %d acquired new knowledge ', r);
                  fprintf('knowledge %d about the transition between [x,y]=[%d, %d] and [x+1,y+1]=[%d, %d] added', value, x, y, x+1, y);
             end
        end

        if(x >1)
            indexy=transform_coordinates_xy2index(x,y, xmax, ymax);
            indexyp1=transform_coordinates_xy2index(x-1,y, xmax, ymax);
             if(abs(sys(r).adj(indexy,indexyp1)-sys(r).padj(indexy,indexyp1))==1)
                  value=randsrc(1,1,[0 1; 0.5 0.5]);
                  environment.map(indexy,indexyp1)=value;
                  environment.map(indexyp1, indexy)=environment.map(indexy,indexyp1);
                  environment.pmap(indexy,indexyp1)=environment.map(indexy,indexyp1);
                  environment.pmap(indexyp1, indexy)= environment.pmap(indexy,indexyp1);
                  discovered(indexy,indexyp1)=value;
                  discovered(indexyp1, indexy)=value;
                  fprintf('Robot %d acquired new knowledge ', r);
                  fprintf('Robot %d acquired new knowledge ', r);
                  fprintf('knowledge %d about the transition between [x,y]=[%d, %d] and [x+1,y+1]=[%d, %d] added', value, x, y, x-1, y);
             end
        end
        % notifies the other robots with the new information
        
         for r2=1:N
             sys(r2).adj=environment.map;
             sys(r2).padj=environment.pmap;
         end

        grid=visualizeDiscoveredGrid(grid, environment, sys, discovered);

    end
    
end