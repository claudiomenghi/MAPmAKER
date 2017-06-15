% updates the system with new information about the environment
function [sys, grid, environment] = infDiscover(scale, grid, sys, environment)
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
        fprintf('checking for new knowledge observed from one of the robots');
        
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
        tmp=PTB1(environment.map, environment.pmap);
        tmp.lastaction= sys(1).lastaction;
        tmp.curr= sys(1).curr;
        tmp.previouscurr=sys(1).curr;
        sys(1)=tmp;

        tmp=PTC2(environment.map, environment.pmap);
        tmp.lastaction= sys(2).lastaction;
        tmp.curr= sys(2).curr;
        tmp.previouscurr=sys(2).curr;
        sys(2)=tmp;

        tmp=PTA3(environment.map, environment.pmap);
        tmp.lastaction= sys(3).lastaction;
        tmp.curr= sys(3).curr;
        tmp.previouscurr=sys(3).curr;
        sys(3)=tmp;
        grid=visualizeDiscoveredGrid(scale, grid, environment, discovered);

    end
    
end